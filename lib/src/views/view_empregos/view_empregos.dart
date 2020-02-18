import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/drop_down_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/switch_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/time_tile.dart';
import 'package:marcaii_flutter/strings.dart';

class ViewEmpregos extends StatefulWidget {
  const ViewEmpregos({
    @required this.emprego,
    Key key,
  }) : super(key: key);
  final Empregos emprego;

  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> {
  TextEditingController txtDesc;
  Empregos _emprego;

  static final porcentagens = [for (int i = 50; i <= 300; i++) i];
  static final porcDiferenciadas = [0]..addAll(porcentagens);
  final diferenciadas = <Diferenciadas>[];

  fillDiferenciadas() {
    for (int dia = 0; dia <= 6; dia++) {
      final Diferenciadas dif = _emprego.diferenciadas.firstWhere(
        (d) => d.weekday == dia,
        orElse: () => null,
      );

      if (dif != null) {
        diferenciadas.add(dif.copyWith());
      } else {
        diferenciadas.add(
          Diferenciadas(
            weekday: dia,
            porc: 0,
          ),
        );
      }
    }
  }

  void validateEmprego() {
    Navigator.of(context).pop(_emprego.copyWith(
      diferenciadas: diferenciadas.where((f) => f.porc != 0).toList(),
      nome: txtDesc.text,
    ));
  }

  Future<bool> canClose() async {
    ///Se o [_emprego] for alterado e for diferente de [widget.emprego]
    ///mostra um dialog confirmando se o usuário quer descartar as alterações feitas
    ///Se a resposta for true, retorna [widget.emprego] que a instancia anterior, sem alterações
    if (!_emprego.equals(widget.emprego)) {
      final r = await showCanCloseDialog(
        context: context,
        title: Strings.atencao,
        message: Strings.descartarAlteracoes,
        positiveCaption: Strings.descartar,
      );

      if (r != null && r == true) {
        Navigator.of(context).pop(widget.emprego);
      }
    } else {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    _emprego = widget.emprego.copyWith();
    txtDesc = TextEditingController(text: _emprego.nome);
    txtDesc.addListener(() {
      setState(() => _emprego = _emprego.copyWith(nome: txtDesc.text));
    });
    fillDiferenciadas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: canClose,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 4,
              title: const Text(Strings.empregos),
              floating: true,
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    Strings.salvar,
                    style: theme.textTheme.subhead,
                  ),
                  onPressed: validateEmprego,
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextTile(
                    icon: Icon(
                      LineAwesomeIcons.file_text_o,
                      color: Colors.lightBlue,
                    ),
                    label: Strings.descricao,
                    controller: txtDesc,
                    hint: "Emprego",
                  ),
                  DropdownTile<int>(
                    icon: Icon(
                      FontAwesomeIcons.percentage,
                      color: Consts.horaColor.first,
                    ),
                    label: Strings.porc,
                    initialValue: _emprego.porc,
                    items: porcentagens,
                    formatter: (int i) => "$i %",
                    onChanged: (p) {
                      setState(() {
                        _emprego = _emprego.copyWith(porc: p);
                      });
                    },
                  ),
                  DropdownTile<int>(
                    icon: Icon(
                      FontAwesomeIcons.percentage,
                      color: Consts.horaColor[1],
                    ),
                    label: Strings.porcCompleta,
                    initialValue: _emprego.porc_completa,
                    items: porcentagens,
                    formatter: (int i) => "$i %",
                    onChanged: (p) {
                      setState(() {
                        _emprego = _emprego.copyWith(porc: p);
                      });
                    },
                  ),
                  DropdownTile<int>(
                    icon: Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.orange,
                    ),
                    label: Strings.cargaHoraria,
                    initialValue: _emprego.carga_horaria,
                    items: <int>[for (final c in Consts.cargasHoraria) c],
                    onChanged: (int value) {
                      setState(() {
                        _emprego = _emprego.copyWith(carga_horaria: value);
                      });
                    },
                  ),
                  TimePickerTile(
                    icon: Icon(
                      FontAwesomeIcons.businessTime,
                      color: Colors.pink,
                    ),
                    initialTime: stringToTimeOfDay(_emprego.saida),
                    label: Strings.saida,
                    onTimeSet: (time) {
                      setState(() => _emprego = _emprego.copyWith(saida: time.toShortString()));
                    },
                  ),
                  SwitchTile(
                    initialValue: _emprego.banco_horas,
                    icon: Icon(
                      Icons.offline_pin,
                      color: Colors.teal,
                    ),
                    label: Strings.bancoHoras,
                    onChanged: (b) {
                      setState(() => _emprego = _emprego.copyWith(banco_horas: b));
                    },
                  ),
                  SwitchTile(
                    icon: Icon(
                      FontAwesomeIcons.envira,
                      color: Colors.red,
                    ),
                    initialValue: _emprego.ativo,
                    label: Strings.atual,
                    onChanged: (b) {
                      setState(() => _emprego = _emprego.copyWith(ativo: b));
                    },
                  ),
                  if (!_emprego.banco_horas)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Divider(),
                          Text(
                            Strings.diferenciadas,
                            style: theme.textTheme.caption.copyWith(color: theme.accentColor),
                          )
                        ],
                      ),
                    ),
                  if (!_emprego.banco_horas)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (final dif in diferenciadas)
                          DropdownTile<int>(
                            label: Consts.weekDayExtenso[dif.weekday],
                            icon: Icon(
                              FontAwesomeIcons.calendarWeek,
                              color: Consts.weekdayColors[dif.weekday],
                            ),
                            items: porcDiferenciadas,
                            initialValue: dif.porc,
                            formatter: (d) => "$d %",
                            onChanged: (int newPorc) {
                              final index = diferenciadas.indexOf(dif);
                              setState(() {
                                diferenciadas[index] = diferenciadas[index].copyWith(porc: newPorc);
                              });
                            },
                          ),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
