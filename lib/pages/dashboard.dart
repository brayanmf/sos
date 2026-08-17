import 'package:convex_bottom_app_bar/convex_body.dart';
import 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
import 'package:convex_bottom_app_bar/convex_bottom_app_bar_v2.dart';
import 'package:convex_bottom_app_bar/convex_tab_controller.dart';
import 'package:convex_bottom_app_bar/convex_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sos_edi/pages/confirmacionSeguro/confirmacionSeguro_page.dart';
import 'package:sos_edi/pages/alertaMensaje/alertaMensaje_page.dart';
import 'package:sos_edi/pages/evacuacion/evacuacion_page.dart';
import 'package:sos_edi/pages/home/home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPage = 0;
  late ConvexTabController tabController = ConvexTabController(initialIndex: 0);

  void onBottomIconPressed(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SOS EDI')),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,

        body: ConvexTabView(
          controller: tabController,
          screens: [
            ConfirmacionSeguroPage(),

            EvacuacionPage(),
            AlertaMensajePage(),
          ],
          items: _items(),
        ),
      ),
    );
  }

  List<ConvexBottomAppBarItem> _items() {
    return [
      ConvexBottomAppBarItem(
        icon: const Icon(Icons.crisis_alert),
        title: 'Confirmación',
      ),

      ConvexBottomAppBarItem(
        icon: const Icon(Icons.person),
        title: 'Evacuación',
      ),
      ConvexBottomAppBarItem(icon: const Icon(Icons.alarm), title: 'Alarma'),
    ];
  }
}
