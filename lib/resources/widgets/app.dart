import 'package:flutter/material.dart';
import 'package:iipvm/resources/widgets/footer.dart';
import 'package:iipvm/resources/widgets/navs/navbars/auth.dart';
import 'package:iipvm/resources/widgets/navs/sidebards/auth.dart';
import 'package:iipvm/resources/widgets/navs/bottombars/auth.dart';
import 'package:iipvm/services/auth_services.dart';
import 'package:provider/provider.dart';

class AppLayoutWidget extends StatelessWidget {
  final Widget child;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  AppLayoutWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()), // Muestra un indicador de carga mientras espera
          );
        } else {
          return Scaffold(
            key: scaffoldKey,
            appBar: snapshot.hasData && snapshot.data! ? NavbarAuthWidget(scaffoldKey: scaffoldKey) : null,
            drawer: snapshot.hasData && snapshot.data! ? SidebarAuthWidget() : null,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Espacio para el contenido dinámico
                Expanded(
                  child: child, // Aquí se muestra el contenido dinámico
                ),
                FooterWidget(),
              ],
            ),
            bottomNavigationBar: snapshot.hasData && snapshot.data! ? BottomAuthWidget() : null,
          );
        }
      }
    );
  }
}