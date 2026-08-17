import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sos_edi/controller/login_controller.dart';
import 'package:sos_edi/models/sos/confirmacion_seguridad_model.dart';
import 'package:sos_edi/pages/layaout/mapa_page.dart';
import 'package:sos_edi/service/emergency_service.dart';

class ConfirmacionSeguroPage extends StatefulWidget {
  final int? alertaEvacuacionId;

  const ConfirmacionSeguroPage({super.key, this.alertaEvacuacionId});

  @override
  State<ConfirmacionSeguroPage> createState() =>
      _SafetyConfirmationScreenState();
}

class _SafetyConfirmationScreenState extends State<ConfirmacionSeguroPage> {
  final EmergencyService _emergencyService = EmergencyService();
  bool _isLoadingLocation = true;
  bool _isConfirming = false;
  String _locationText = 'Obteniendo tu ubicación...';
  double? _latitude;
  double? _longitude;
  int? _alertaId;

  @override
  void initState() {
    super.initState();
    _alertaId = widget.alertaEvacuacionId;
    _getLocation();
    if (_alertaId == null) _fetchLatestAlertId();
  }

  Future<void> _fetchLatestAlertId() async {
    final alerta = await _emergencyService.getLatestAlert();
    if (mounted && alerta?.id != null) {
      setState(() => _alertaId = alerta!.id);
    }
  }

  void _getLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        _isLoadingLocation = false;
        _latitude = position.latitude;
        _longitude = position.longitude;
        _locationText =
            'Ubicación obtenida: Lat: ${_latitude?.toStringAsFixed(4)}, Long: ${_longitude?.toStringAsFixed(4)}';
      });
    }
  }

  Future<void> _handleSafetyConfirmation() async {
    if (_latitude == null || _longitude == null) {
      _showError('No se ha obtenido la ubicación aún.');
      return;
    }

    setState(() => _isConfirming = true);

    try {
      final data = ConfirmacionSeguridadModel(
        idUsuario: Get.find<LoginController>().appUsr?.id,
        alertaEvacuacionId: _alertaId,
        latitud: _latitude,
        longitud: _longitude,
        estadoReportado: 'A salvo',
        comentario: 'Me encuentro en el punto de encuentro externo.',
      );

      final success = await _emergencyService.confirmSafety(data);

      if (!mounted) return;

      if (success) {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Confirmación enviada'),
            content: const Text(
              'Tu estado y ubicación han sido registrados. Mantente en un lugar seguro.',
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
      } else {
        _showError('No se pudo enviar la confirmación. Intenta de nuevo.');
      }
    } catch (e) {
      _showError('Error al enviar la confirmación: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Confirmar Seguridad',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Container(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tu seguridad es lo primero',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Por favor, confirma tu estado de seguridad. Esto nos ayudará a coordinar la ayuda necesaria.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (_isLoadingLocation)
                          const CupertinoActivityIndicator()
                        else
                          const Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.blue,
                            size: 24,
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _locationText,
                            style: TextStyle(
                              fontSize: 16,
                              color: _isLoadingLocation
                                  ? Colors.black54
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!_isLoadingLocation &&
                        _latitude != null &&
                        _longitude != null) ...[
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => MapaPage(
                                  latitude: _latitude!,
                                  longitude: _longitude!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Ver en el mapa',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CupertinoButton.filled(
                  onPressed: _isLoadingLocation || _isConfirming
                      ? null
                      : _handleSafetyConfirmation,
                  padding: EdgeInsets.zero,
                  child: _isConfirming
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : const Text(
                          'Confirmar mi seguridad',
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
}
