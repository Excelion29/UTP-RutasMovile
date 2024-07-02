import 'package:flutter/material.dart';
import 'package:iipvm/models/user.dart';
import 'package:iipvm/resources/widgets/footer.dart';
import 'package:iipvm/services/auth_services.dart';
import 'package:provider/provider.dart';

class SidebarAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Provider.of<AuthService>(context).getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final user = snapshot.data;
          return Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user?.name ?? 'Guest'),
                  accountEmail: Text(user?.dni ?? '#######'),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 18, 120, 138), // Color de fondo deseado
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to another screen
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    await Provider.of<AuthService>(context, listen: false).logout();
                    Navigator.of(context).pushReplacementNamed('/'); // Close the drawer
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FooterWidget(),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
