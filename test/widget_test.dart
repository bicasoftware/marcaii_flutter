import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:marcaii_flutter/singleton_test.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/column_types.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_column.dart';
import 'package:marcaii_flutter/src/database/sqlite_generator/sqlite_table.dart';

void main() {
  group('sql generator', () {
    test('create table', () {
      final String diferenciada = SqliteTable("diferenciadas", columns: {
        "ID": SqliteColumn(ColumnTypes.PRIMARY_KEY),
        "EMPREGO_ID": SqliteColumn(ColumnTypes.INTEGER, nullable: false),
        "PORC": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
        "WEEKDAY": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 6),
        "VIGENCIA": SqliteColumn(ColumnTypes.TEXT, nullable: false),
        "ATIVO": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
      }).generateCreateQuery();

      final String empregos = SqliteTable("empregos", columns: {
        "ID": SqliteColumn(ColumnTypes.PRIMARY_KEY),
        "PORC": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 50),
        "PORC_COMPLETA": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 100),
        "FECHAMENTO": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 25),
        "BANCO_HORAS": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
        "SAIDA": SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
        "CARGA_HORARIA": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 220),
        "ATIVO": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 1),
      }).generateCreateQuery();

      final String horas = SqliteTable("horas", columns: {
        "ID": SqliteColumn(ColumnTypes.PRIMARY_KEY),
        "EMPREGO_ID": SqliteColumn(ColumnTypes.INTEGER, nullable: false),
        "TIPO": SqliteColumn(ColumnTypes.INTEGER, nullable: false, defaultValue: 0),
        "INICIO": SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
        "TERMINO": SqliteColumn(ColumnTypes.TEXT, nullable: false, defaultValue: "17:00"),
      }).generateCreateQuery();

      final String salarios = SqliteTable("salarios", columns: {
        "ID": SqliteColumn(ColumnTypes.PRIMARY_KEY),
        "EMPREGO_ID": SqliteColumn(ColumnTypes.INTEGER),
        "VALOR": SqliteColumn(ColumnTypes.REAL),
        "VIGENCIA": SqliteColumn(ColumnTypes.TEXT),
        "ATIVO": SqliteColumn(ColumnTypes.INTEGER),
      }).generateCreateQuery();

      print("horas: \n $horas");
      print("empregos: \n $empregos");
      print("salarios: \n $salarios");
      print("diferenciadas: \n $diferenciada");
    });
  });
  
  test('singleton', () {
    final Obsidia obs1 = Obsidia();
    final obs2 = Obsidia();

    assert(obs1 == obs2);
    print(obs1.hashCode);
    print(obs2.hashCode);
  });

  test('number format', () {
    final f = NumberFormat.simpleCurrency(locale: "pt_Br").format(1320.56);
    print(f);
  });

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
