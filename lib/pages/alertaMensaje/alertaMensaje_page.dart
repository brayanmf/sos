import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sos_edi/controller/login_controller.dart';
import 'package:sos_edi/models/sos/alerta_evacuacion_model.dart';
import 'package:sos_edi/models/sos/confirmacion_seguridad_model.dart';
import 'package:sos_edi/service/emergency_service.dart';

class AlertaMensajePage extends StatefulWidget {
  const AlertaMensajePage({Key? key}) : super(key: key);

  @override
  _AlertaMensajePageState createState() => _AlertaMensajePageState();
}

class _AlertaMensajePageState extends State<AlertaMensajePage> {
  final EmergencyService _emergencyService = EmergencyService();
  Timer? _timer;
  AlertaEvacuacionModel? _alerta;
  bool _isLoading = true;
  bool _isConfirming = false;

  @override
  void initState() {
    super.initState();
    _fetchAlert();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _fetchAlert());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchAlert() async {
    final alerta = await _emergencyService.getLatestAlert();
    if (mounted) {
      setState(() {
        _alerta = alerta;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemRed,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                _alerta?.tipoAlerta != null
                    ? '¡${_alerta!.tipoAlerta}!'
                    : '¡EMERGENCIA!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _alerta?.mensajeAlerta ?? '¡EVACUAR URGENTE!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              if (_isLoading) ...[
                const SizedBox(height: 20),
                const CupertinoActivityIndicator(color: Colors.white),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CupertinoButton.filled(
                  onPressed: _isConfirming
                      ? null
                      : () => _handleSafetyConfirmation(context),
                  child: _isConfirming
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : const Text(
                          'Estoy a salvo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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

  Future<void> _handleSafetyConfirmation(BuildContext context) async {
    setState(() => _isConfirming = true);

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

      final data = ConfirmacionSeguridadModel(
        idUsuario: Get.find<LoginController>().appUsr?.id,
        alertaEvacuacionId: _alerta?.id,
        latitud: position.latitude,
        longitud: position.longitude,
        estadoReportado: 'A salvo',
        comentario: 'Me encuentro en un lugar seguro.',
      );

      final success = await _emergencyService.confirmSafety(data);

      if (!mounted) return;

      if (success) {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Confirmación enviada'),
            content: const Text(
              'Tu estado y ubicación han sido registrados. Permanece en un lugar seguro.',
            ),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: const Text('Entendido'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      } else {
        _showError('No se pudo enviar la confirmación. Intenta de nuevo.');
      }
    } catch (e) {
      _showError('Error al obtener la ubicación: $e');
    } finally {
      if (mounted) setState(() => _isConfirming = false);
    }
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
