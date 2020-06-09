import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marcaii_flutter/src/database/dao/dao_diferencidas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_empregos.dart';
import 'package:marcaii_flutter/src/database/dao/dao_horas.dart';
import 'package:marcaii_flutter/src/database/dao/dao_salarios.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/utils/vault.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';

class ViewPresentation extends StatelessWidget {
  //TODO - Gerar View com apresentação do app;
  //Pedindo Salario, nome do emprego, carga horária, hora de saída, valor das porcentagens e valores diferenciais

  const ViewPresentation({
    this.onAllSet,
    Key key,
  }) : super(key: key);

  final void Function(List<Empregos>) onAllSet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Como Usar"),
      ),
      body: Center(
        child: MaterialButton(
          color: Get.theme.primaryColor,
          onPressed: () async {
            await Vault.setIsDark(false);
            final vigencia = Vigencia.fromString("01/2010");
            final e = await DaoEmpregos.insert(
              Empregos(
                nome: "Analista",
                ativo: true,
                banco_horas: false,
                carga_horaria: 220,
                fechamento: 25,
                saida: "18:00",
                porc: 50,
                porc_completa: 100,
                salarios: [],
                horas: [],
                diferenciadas: [],
                calendario: [],
              ),
            );

            final s = await DaoSalarios.insert(
              Salarios(emprego_id: e.id, ativo: true, valor: 1320.0, vigencia: vigencia.vigencia),
            );

            final d = await DaoDiferenciadas.insert(Diferenciadas(
              emprego_id: e.id,
              ativo: true,
              vigencia: vigencia.vigencia,
              porc: 110,
              weekday: 0,
            ));

            final h1 = await DaoHoras.insert(Horas(
              emprego_id: e.id,
              data: DateTime(2020, 6, 8),
              tipo: 0,
              inicio: "18:00",
              termino: "19:00",
            ));

            final h2 = await DaoHoras.insert(Horas(
              emprego_id: e.id,
              data: DateTime(2020, 6, 9),
              tipo: 1,
              inicio: "18:00",
              termino: "19:00",
            ));

            final h3 = await DaoHoras.insert(Horas(
              emprego_id: e.id,
              data: DateTime(2020, 6, 7),
              tipo: 2,
              inicio: "10:00",
              termino: "12:00",
            ));

            e
              ..salarios.add(s)
              ..diferenciadas.add(d)
              ..horas.addAll([h1, h2, h3]);

            onAllSet([e]);
          },
        ),
      ),
    );
  }
}
