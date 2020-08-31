import 'dart:async';

import 'package:flutter_utils/flutter_utils.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/state/app_state.dart';
import 'package:marcaii_flutter/src/utils/vigencia.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain(List<Empregos> empregos) {
    state = AppState(
      empregos: empregos,
    );

    _inVigencia.add(state.vigencia);
    _inEmpregos.add(state.empregos);
    _inNavPosition.add(0);
  }

  AppState state;

  final _bhsEmpregos = BehaviorSubject<List<Empregos>>();
  Stream<List<Empregos>> get empregos => _bhsEmpregos.stream;
  Sink<List<Empregos>> get _inEmpregos => _bhsEmpregos.sink;

  final _bhsVigencia = BehaviorSubject<Vigencia>();
  Stream<Vigencia> get outVigencia => _bhsVigencia.stream;
  Sink<Vigencia> get _inVigencia => _bhsVigencia.sink;

  final BehaviorSubject<int> _bhsNavPosition = BehaviorSubject<int>();
  Stream<int> get outNavPosition => _bhsNavPosition.stream;
  Sink<int> get _inNavPosition => _bhsNavPosition.sink;

  @override
  void dispose() {
    _bhsEmpregos.close();
    _bhsVigencia.close();
    _bhsNavPosition.close();
  }

  void _resetNavPos() {
    _inNavPosition.add(0);
  }

  void incMes() {
    state.addMes();
    _inVigencia.add(state.vigencia);
  }

  void decMes() {
    state.decMes();
    _inVigencia.add(state.vigencia);
  }

  void setVigencia(Vigencia vigencia) {
    state.setVigencia(vigencia);
    _inVigencia.add(state.vigencia);
  }

  void setNavPosition(int pos) {
    state.setNavPosition(pos);
    _bhsNavPosition.add(state.navPosition);
  }

  void addEmprego(Empregos emprego) async {
    await state.addEmprego(emprego);
    _inEmpregos.add(state.empregos);
    _resetNavPos();
  }

  void removeEmprego(Empregos emprego) async {
    await state.removeEmprego(emprego);
    _inEmpregos.add(state.empregos);
    _resetNavPos();
  }

  void updateEmprego(Empregos emprego) async {
    await state.updateEmprego(emprego);
    _inEmpregos.add(state.empregos);
  }

  void addHora(Horas hora, Vigencia vigencia) async {
    await state.addHora(hora, vigencia);
    _inEmpregos.add(state.empregos);
  }

  void removeHora(Horas hora, int emprego_id) async {
    await state.removeHora(hora: hora, emprego_id: emprego_id);
    _inEmpregos.add(state.empregos);
  }
}
