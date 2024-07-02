import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iipvm/main.dart'; // Asegúrate de importar correctamente tu clase MyApp
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences

void main() {
  testWidgets('Test MyApp Widget', (WidgetTester tester) async {
    // Inicializar SharedPreferences para la prueba
    SharedPreferences.setMockInitialValues({});

    // Inicializar SharedPreferences dentro de testWidgets
    final sharedPreferences = await SharedPreferences.getInstance();

    // Configurar MyApp con sharedPreferences
    runApp(MyApp(sharedPreferences: sharedPreferences));

    // Asegurar que la inicialización se complete antes de continuar
    await tester.pumpAndSettle();

    // Ejemplo de prueba: verificar que un widget inicial se encuentra
    expect(find.text('Welcome'), findsOneWidget);

    // Ejemplo de prueba: simular un gesto (por ejemplo, tap) y verificar cambios
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Verificar que se haya actualizado el estado del widget
    expect(find.text('Hello!'), findsOneWidget);
  });
}