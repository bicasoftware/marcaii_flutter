import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/utils/item_picker.dart';
import 'package:marcaii_flutter/strings.dart';

class VigenciaPicker extends StatefulWidget {
  const VigenciaPicker({
    @required this.mes,
    @required this.ano,
    @required this.onMesSet,
    @required this.onAnoSet,
    this.backgroundColor,
    Key key,
  }) : super(key: key);

  final int mes, ano;
  final void Function(int value) onMesSet, onAnoSet;
  final Color backgroundColor;

  @override
  _VigenciaPickerState createState() => _VigenciaPickerState();
}

class _VigenciaPickerState extends State<VigenciaPicker> {
  int mes, ano;

  @override
  void initState() {
    mes = widget.mes;
    ano = widget.ano;
    super.initState();
  }

  final anos = [for (int i = 2010; i < 2031; i++) i];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: ItemPicker<String>(
              backgroundColor: widget.backgroundColor ?? Theme.of(context).cardColor,
              items: Consts.meses,
              initValue: Consts.meses[mes],
              onCentered: (int mes) {
                widget.onMesSet(mes+1);
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: ItemPicker<int>(
              backgroundColor: widget.backgroundColor ?? Theme.of(context).cardColor,
              items: anos,
              initValue: ano,
              onCentered: (i) {
                widget.onAnoSet(anos[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
