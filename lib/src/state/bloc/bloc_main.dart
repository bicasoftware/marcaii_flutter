import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/app_state.dart';
import 'package:marcaii_flutter/src/state/bloc/base_bloc.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain({
    @required final String token,
    @required final List<Empregos> empregos,
  }) {
    this.state = AppState(
      token: token,
      empregos: empregos,
    );

    _bhsEmpregos.listen((empregos) {
      _countEmpregos.sink.add(empregos.length);
    });

    _bhsMes.listen((int m) {
      //TODO - implementar mudança do calendário aqui
      inVigencia.add(state.vigencia);
    });

    _bhsAno.listen((int a) {
      inVigencia.add(state.vigencia);
    });

    _bhsNavPosition.listen((int pos) {
      _appBarTitle.sink.add(Consts.appBarTitles[pos]);
    });

    _bhsNavPosition.sink.add(state.navPosition);
    inEmpregos.add(state.empregos);
    inToken.add(state.token);
    inAno.add(state.ano);
    inMes.add(state.mes);
    inVigencia.add(state.vigencia);
  }

  AppState state;

  final BehaviorSubject<String> _bhsToken = BehaviorSubject<String>();
  Stream<String> get outToken => _bhsToken.stream;
  Sink<String> get inToken => _bhsToken.sink;

  final BehaviorSubject<List<Empregos>> _bhsEmpregos = BehaviorSubject<List<Empregos>>();
  Stream<List<Empregos>> get outEmpregos => _bhsEmpregos.stream;
  Sink<List<Empregos>> get inEmpregos => _bhsEmpregos.sink;

  final _countEmpregos = StreamController<int>();
  get outCount => _countEmpregos.stream;

  final BehaviorSubject<int> _bhsMes = BehaviorSubject<int>();
  Stream<int> get outMes => _bhsMes.stream;
  Sink<int> get inMes => _bhsMes.sink;

  final BehaviorSubject<int> _bhsAno = BehaviorSubject<int>();
  Stream<int> get outAno => _bhsAno.stream;
  Sink<int> get inAno => _bhsAno.sink;

  final BehaviorSubject<String> _bhsVigencia = BehaviorSubject<String>();
  Stream<String> get outVigencia => _bhsVigencia.stream;
  Sink<String> get inVigencia => _bhsVigencia.sink;

  final BehaviorSubject<int> _bhsNavPosition = BehaviorSubject<int>();
  Stream<int> get outNavPosition => _bhsNavPosition.stream;

  final _appBarTitle = StreamController<String>();
  get outAppbarTitle => _appBarTitle.stream;

  @override
  void dispose() {
    _bhsToken.close();
    _bhsEmpregos.close();
    _countEmpregos.close();
    _bhsMes.close();
    _bhsAno.close();
    _bhsVigencia.close();
    _bhsNavPosition.close();
    _appBarTitle.close();
  }

  void incMes() {
    state.addMes();
    inMes.add(state.mes);
  }

  void decMes() {
    state.decMes();
    inMes.add(state.mes);
  }

  void setAno(int year) {
    state.setAno(year);
    inAno.add(state.ano);
  }

  void setNavPosition(int pos) {
    state.setNavPosition(pos);
    _bhsNavPosition.add(state.navPosition);
  }

  void addEmprego(Empregos emprego) {
    //TODO - implementar
  }

  void removeEmprego(Empregos emprego) {
    //TODO - implementar
  }

  void updateEmprego(Empregos emprego) {
    //TODO - implementar
  }
}
