import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sos_edi/environment.dart';
import 'package:sos_edi/pages/alertaMensaje/alertaMensaje_page.dart';
import 'package:sos_edi/pages/confirmacionSeguro/confirmacionSeguro_page.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  GlobalKey<NavigatorState>? _navigatorKey;

  void init(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;

    final appId = Enviroment.onesignalAppId;
    if (appId.isEmpty || appId == 'TU_ONESIGNAL_APP_ID_AQUI') return;

    OneSignal.initialize(appId);
    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addClickListener(_onNotificationClicked);
    OneSignal.Notifications.addForegroundWillDisplayListener(
      _onForegroundDisplay,
    );
  }

  void login(String userId) {
    OneSignal.login(userId);
  }

  void logout() {
    OneSignal.logout();
  }

  void _onForegroundDisplay(OSNotificationWillDisplayEvent event) {
    event.notification.display();
  }

  void _onNotificationClicked(OSNotificationClickEvent event) {
    final data = event.notification.additionalData;
    if (data == null || _navigatorKey?.currentContext == null) return;

    final pantalla = data['pantalla'] as String?;

    switch (pantalla) {
      case 'alertaMensaje':
        _navigatorKey!.currentState!.push(
          MaterialPageRoute(builder: (_) => const AlertaMensajePage()),
        );
        break;
      case 'confirmacionSeguro':
        final alertaId = data['alertaEvacuacionId'] as int?;
        _navigatorKey!.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ConfirmacionSeguroPage(alertaEvacuacionId: alertaId),
          ),
        );
        break;
    }
  }
}
