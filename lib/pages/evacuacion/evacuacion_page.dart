import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sos_edi/controller/login_controller.dart';
import 'package:sos_edi/models/sos/alerta_evacuacion_model.dart';
import 'package:sos_edi/service/emergency_service.dart';

class EvacuacionPage extends StatefulWidget {
  const EvacuacionPage({super.key});

  @override
  State<EvacuacionPage> createState() => _EvacuacionPageState();
}

class _EvacuacionPageState extends State<EvacuacionPage> {
  bool _isActivating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: const Text('Tgestiona', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Panel de Seguridad',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Presiona el botón para activar la alerta de evacuación en todos los dispositivos de la empresa.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 64),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isActivating
                      ? null
                      : () => _showConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                  ),
                  child: _isActivating
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : const Text(
                          'ACTIVAR EVACUACIÓN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirmar Activación'),
        content: const Text(
          '¿Estás seguro de que quieres activar la alarma de evacuación? '
          'Esta acción alertará a todos los colaboradores de forma inmediata.',
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Activar'),
            onPressed: () {
              Navigator.of(context).pop();
              _activateEvacuation();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _activateEvacuation() async {
    setState(() => _isActivating = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('Los servicios de ubicación están desactivados.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('El permiso de ubicación fue denegado.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('El permiso de ubicación está bloqueado permanentemente.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final data = AlertaEvacuacionModel(
        idUsuario: Get.find<LoginController>().appUsr?.id.toString() ?? '',
        tipoAlerta: 'Evacuación',
        mensajeAlerta: 'Alerta de evacuación activada. ¡Evacúen de inmediato!',
        latitudActivacion: position.latitude,
        longitudActivacion: position.longitude,
        descripcionUbicacionActivacion: 'Ubicación del oficial de seguridad',
      );

      final service = EmergencyService();
      final success = await service.activateAlert(data);

      if (!mounted) return;

      if (success) {
        _showSuccess();
      } else {
        _showError('No se pudo activar la alerta. Intenta de nuevo.');
      }
    } catch (e) {
      _showError('Error al obtener la ubicación: $e');
    } finally {
      if (mounted) setState(() => _isActivating = false);
    }
  }

  void _showSuccess() {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alerta Activada'),
        content: const Text(
          'La alerta de evacuación ha sido enviada a todos los colaboradores.',
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Entendido'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
