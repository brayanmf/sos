import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EvacuacionPage extends StatelessWidget {
  const EvacuacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF2F2F7,
      ), // Color de fondo gris claro, similar a iOS
      appBar: AppBar(
        title: const Text('Tgestiona', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5, // Sombra sutil para la app bar
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
              // Botón de activación
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => _showConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Botón rojo para indicar peligro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
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

  // Función para mostrar la ventana de confirmación
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
              Navigator.of(context).pop(); // Cierra el modal
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction:
                true, // Texto en rojo para la acción destructiva
            child: const Text('Activar'),
            onPressed: () {
              // TODO: Agrega la lógica para activar la alarma aquí.
              // 1. Llama a tu API de .NET.
              // 2. Envía la ubicación actual (latitud, longitud).
              // 3. Maneja la respuesta.
              print('Alarma de evacuación activada.');
              Navigator.of(context).pop(); // Cierra el modal
              // Puedes mostrar un mensaje de éxito o navegar a otra pantalla.
            },
          ),
        ],
      ),
    );
  }
}
