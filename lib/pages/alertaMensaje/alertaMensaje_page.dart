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
      // El color de fondo rojo cubre toda la pantalla para una alerta máxima
      backgroundColor: CupertinoColors.systemRed,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(), // Empuja el contenido hacia el centro verticalmente
              const Text(
                '¡EMERGENCIA!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '¡EVACUAR URGENTE!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const Spacer(), // Empuja el contenido hacia el centro verticalmente
              // Botón de "Estoy a salvo"
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CupertinoButton.filled(
                  onPressed: () => _handleSafetyConfirmation(context),
                  // Estilo nativo de iOS para el botón
                  child: const Text(
                    'Estoy a salvo',
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

  void _handleSafetyConfirmation(BuildContext context) {
    // TODO: Agrega la lógica para enviar la confirmación al backend.
    // 1. Obtener la ubicación actual (latitud y longitud).
    // 2. Llamar a tu API de .NET para registrar la confirmación.
    // 3. Manejar la respuesta y mostrar un mensaje de confirmación o error.
    print('Confirmación de seguridad enviada.');

    // Después de enviar la confirmación, puedes mostrar una alerta o
    // navegar a una pantalla de confirmación.
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
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el modal
              // Puedes navegar a la pantalla principal o mantener esta pantalla visible.
            },
          ),
        ],
      ),
    );
  }
}
