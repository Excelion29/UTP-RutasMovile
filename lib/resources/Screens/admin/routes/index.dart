import 'package:flutter/material.dart';
import 'package:iipvm/resources/widgets/app.dart'; // Asegúrate de importar el widget de layout adecuado

// Lista imaginaria de rutas pendientes
final List<String> rutasPendientes = [
  'Ruta 1',
  'Ruta 2',
  'Ruta 3',
  'Ruta 4',
  'Ruta 5',
];

class RutasPendientesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppLayoutWidget(
      child: ListView.builder(
        itemCount: rutasPendientes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rutasPendientes[index]),
            onTap: () {
              // Aquí puedes manejar la navegación cuando se seleccione una ruta pendiente
              // Por ejemplo, podrías navegar a los detalles de la ruta seleccionada
              // Navigator.push(...);
            },
          );
        },
      ),
    );
  }
}