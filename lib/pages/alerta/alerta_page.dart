import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos_edi/pages/layaout/mapa_page.dart';

class ConfirmacionSeguroPage extends StatefulWidget {
  const ConfirmacionSeguroPage({super.key});

  @override
  State<ConfirmacionSeguroPage> createState() =>
      _SafetyConfirmationScreenState();
}

class _SafetyConfirmationScreenState extends State<ConfirmacionSeguroPage> {
  bool _isLoadingLocation = true;
  String _locationText = 'Obteniendo tu ubicación...';
  double? _latitude;
  double? _longitude;
  @override
  void initState() {
    super.initState();
    _getLocation();
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

  // Lógica para manejar la confirmación de seguridad
  void _handleSafetyConfirmation() {
    // TODO: Agrega la lógica para enviar la confirmación al backend.
    // 1. Obtener la ubicación real (latitud y longitud).
    // 2. Llamar a tu API de .NET para registrar la confirmación con el AlertaID.
    // 3. Manejar la respuesta y mostrar un mensaje de confirmación o error.
    print('Confirmación de seguridad enviada.');

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
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el modal
              // Puedes navegar a la pantalla principal o mostrar una pantalla de estado.
            },
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
              // Indicador de ubicación y botón para ver el mapa
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
              // Botón de "Confirmar mi seguridad"
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CupertinoButton.filled(
                  onPressed: _isLoadingLocation
                      ? null
                      : _handleSafetyConfirmation,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Confirmar mi seguridad',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
