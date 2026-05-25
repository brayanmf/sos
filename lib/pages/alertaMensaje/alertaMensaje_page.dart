import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertaMensajePage extends StatefulWidget {
  const AlertaMensajePage({Key? key}) : super(key: key);

  @override
  _AlertaMensajePageState createState() => _AlertaMensajePageState();
}

class _AlertaMensajePageState extends State<AlertaMensajePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD32F2F), Color(0xFF7F0000)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Icono de alerta
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Etiqueta superior
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '¡EMERGENCIA!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Título principal
                  const Text(
                    '¡EVACUAR\nURGENTE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtítulo
                  Text(
                    'Sigue las instrucciones de\nlas autoridades competentes.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 56),
                  // Botón principal
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleSafetyConfirmation(context),
                      icon: const Icon(Icons.check_circle_outline, size: 24),
                      label: const Text(
                        'Estoy a salvo',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFD32F2F),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSafetyConfirmation(BuildContext context) {
    // TODO: Agrega la lógica para enviar la confirmación al backend.
    // 1. Obtener la ubicación actual (latitud y longitud).
    // 2. Llamar a tu API de .NET para registrar la confirmación.
    // 3. Manejar la respuesta y mostrar un mensaje de confirmación o error.
    print('Confirmación de seguridad enviada.');

    // Después de enviar la confirmación, puedes mostrar una alerta o
    // navegar a una pantalla de confirmación.
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFFD32F2F)),
            SizedBox(width: 8),
            Text('Confirmación enviada'),
          ],
        ),
        content: const Text(
          'Tu estado y ubicación han sido registrados. Permanece en un lugar seguro.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Entendido',
              style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
