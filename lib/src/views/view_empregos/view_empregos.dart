import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:marcaii_flutter/src/state/bloc/bloc_emprego.dart';
import 'package:marcaii_flutter/src/utils/dialogs/dialogs.dart';
import 'package:marcaii_flutter/src/utils/helpers/time_helper.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/composed_text_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/drop_down_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/switch_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/text_tile.dart';
import 'package:marcaii_flutter/src/views/shared/config_tiles/time_tile.dart';
import 'package:marcaii_flutter/src/views/view_empregos/emprego_validate.dart';
import 'package:marcaii_flutter/src/views/view_empregos/view_emprego_diferenciadas.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:provider/provider.dart';

class ViewEmpregos extends StatefulWidget {
  @override
  _ViewEmpregosState createState() => _ViewEmpregosState();
}

class _ViewEmpregosState extends State<ViewEmpregos> {
  static final porcentagens = [for (int i = 50; i <= 300; i++) i];

  GlobalKey<FormState> _formKey;
  BlocEmprego b;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void validateEmprego() {
    Navigator.of(context).pop(b.resultEmprego());
  }

  Future<bool> _willPop() async {
    ///Se o [_emprego] for alterado e for diferente de [widget.emprego]
    ///mostra um dialog confirmando se o usuário quer descartar as alterações feitas
    ///Se a resposta for true, retorna [widget.emprego] que a instancia anterior, sem alterações

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (b.didChange()) {
        final r = await showCanCloseDialog(
          context: context,
          title: Strings.atencao,
          message: Strings.descartarAlteracoes,
          positiveCaption: Strings.descartar,
        );

        if (r != null && r == true) {
          Navigator.of(context).pop(b.resultEmprego());
        }
      } else {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    b = Provider.of<BlocEmprego>(context);
    // final b = Provider.of<BlocEmprego>(context);

    return WillPopScope(
      onWillPop: _willPop,
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
                  onPressed: () {
                    final state = _formKey.currentState;
                    if (state.validate()) {
                      state.save();
                      Navigator.of(context).pop(b.emprego);
                    }
                  },
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        StreamObserver<String>(
                          stream: b.nome,
                          onSuccess: (_, nome) {
                            return ComposedTextTile(
                              icon: Icon(
                                Icons.work,
                                color: Colors.lightBlue,
                              ),
                              hint: "Emprego",
                              label: Strings.descricao,
                              initialValue: nome,
                              onSaved: b.setNome,
                              validator: (String s) {
                                if (s.isEmpty) {
                                  return "Descrição obrigatória";
                                } else {
                                  return null;
                                }
                              },
                            );
                          },
                        ),
                        StreamObserver<int>(
                          stream: b.porcNormal,
                          onSuccess: (_, porc) {
                            return TextTile(
                              trailingWidth: 32,
                              icon: Icon(
                                Icons.info,
                                color: Consts.horaColor.first,
                              ),
                              hint: "50",
                              label: Strings.porc,
                              initialValue: porc.toString(),
                              onSaved: (s) => b.setPorcNormal(int.tryParse(s)),
                              validator: (s) {
                                return EmpregoValidate.validatePorc(s, 50);
                              },
                            );
                          },
                        ),
                        StreamObserver<int>(
                          stream: b.porcCompleta,
                          onSuccess: (_, porc) {
                            return TextTile(
                              trailingWidth: 32,
                              icon: Icon(
                                Icons.info,
                                color: Consts.horaColor[1],
                              ),
                              label: Strings.porcCompleta,
                              initialValue: porc.toString(),
                              hint: "100",
                              inputType: TextInputType.number,
                              validator: (String s) => EmpregoValidate.validatePorc(s, 50),
                              onSaved: (String s) => b.setPorcCompleta(int.tryParse(s)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamObserver<int>(
                    stream: b.cargaHoraria,
                    onAwaiting: (_) => Container(),
                    onSuccess: (_, carga) {
                      return DropdownTile<int>(
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.orange,
                        ),
                        label: Strings.cargaHoraria,
                        initialValue: carga,
                        items: <int>[for (final c in Consts.cargasHoraria) c],
                        onChanged: b.setCargaHoraria,
                        trailingWidth: 60,
                      );
                    },
                  ),
                  StreamObserver<String>(
                    stream: b.saida,
                    onAwaiting: (_) => Container(),
                    onSuccess: (_, saida) => TimePickerTile(
                      icon: Icon(
                        Icons.time_to_leave,
                        color: Colors.pink,
                      ),
                      initialTime: stringToTimeOfDay(saida),
                      label: Strings.saida,
                      onTimeSet: b.setSaida,
                    ),
                  ),
                  StreamObserver<bool>(
                    stream: b.bancoHoras,
                    onAwaiting: (_) => Container(),
                    onSuccess: (_, bancoHoras) {
                      return SwitchTile(
                        initialValue: bancoHoras,
                        icon: Icon(
                          Icons.offline_pin,
                          color: Colors.teal,
                        ),
                        label: Strings.bancoHoras,
                        onChanged: b.setBancoHora,
                      );
                    },
                  ),
                  StreamObserver<bool>(
                    stream: b.ativo,
                    onAwaiting: (_) => Container(),
                    onSuccess: (_, ativo) => SwitchTile(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      initialValue: ativo,
                      label: Strings.atual,
                      onChanged: b.setAtivo,
                    ),
                  ),
                  ViewEmpregoDiferenciadas(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
