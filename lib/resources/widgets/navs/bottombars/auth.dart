import 'package:flutter/material.dart';

class BottomAuthWidget extends StatefulWidget {
  @override
  _BottomAuthWidgetState createState() => _BottomAuthWidgetState();
}

class _BottomAuthWidgetState extends State<BottomAuthWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
      switch (index) {
    case 0:
      Navigator.pushReplacementNamed(context, '/');
      break;
    case 1:
      Navigator.pushReplacementNamed(context, '/ruta-pendiente');
      break;
    case 2:
      Navigator.pushReplacementNamed(context, '/historial-rutas');
      break;
  }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 13, 138, 155),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(136, 236, 236, 236),
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Rutas Pendientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'Historial de Rutas',
          ),
        ],
    );
  }
}