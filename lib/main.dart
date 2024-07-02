import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:iipvm/resources/Screens/admin/dashboard.dart';
import 'package:iipvm/resources/Screens/auth/login.dart';
import 'package:iipvm/resources/Screens/admin/history/index.dart';
import 'package:iipvm/resources/Screens/admin/routes/index.dart';

import 'package:iipvm/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences),);
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key? key, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(sharedPreferences),
        ),
      ],
      child: MaterialApp(
        title: 'LogiMeet Perú',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthCheck(),
          '/ruta-pendiente': (context) => RutasPendientesScreen(),
          '/historial-rutas': (context) => HistorialRutasScreen(),
        },
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<AuthService>(context).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras espera
        } else {
          if (snapshot.hasData && snapshot.data!) {
            return DashboardScreen(); // Usuario autenticado, muestra el dashboard
          } else {
            return LoginScreen(); // Usuario no autenticado, muestra la pantalla de login
          }
        }
      },
    );
  }
}