import 'package:flutter/material.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/state/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:marcaii_flutter/helpers.dart';

class BlocEmprego with BaseBloc {
  BlocEmprego({
    this.emprego,
  }) {
    _inNome.add(emprego.nome ?? "");
    _inPorcNormal.add(emprego.porc);
    _inPorcCompleta.add(emprego.porc_completa);
    _inFechamento.add(emprego.fechamento);
    _inBancoHoras.add(emprego.banco_horas);
    _inCargaHoraria.add(emprego.carga_horaria);
    _inAtivo.add(emprego.ativo);
    _inSaida.add(emprego.saida);
    _fillDiferenciadas();
    _oldEmprego = emprego.copyWith();
  }

  Empregos emprego, _oldEmprego;
  List<Diferenciadas> _diferenciadas;

  Empregos resultEmprego() {
    final actualDif = _diferenciadas.where((d) => d.porc != 0).toList();
    return emprego.copyWith(
      diferenciadas: actualDif,
    );
  }

  bool didChange() {
    return !_oldEmprego.equals(emprego);
  }

  _fillDiferenciadas() {
    _diferenciadas = <Diferenciadas>[];
    for (int dia = 0; dia <= 6; dia++) {
      final Diferenciadas dif = emprego.diferenciadas?.firstWhere(
        (d) => d.weekday == dia,
        orElse: () => null,
      );

      if (dif != null) {
        _diferenciadas.add(dif.copyWith());
      } else {
        _diferenciadas.add(
          Diferenciadas(
            weekday: dia,
            porc: 0,
          ),
        );
      }
    }

    _inDiferenciadas.add(_diferenciadas);
  }

  final BehaviorSubject<String> _bhsDesc = BehaviorSubject<String>();
  Stream<String> get nome => _bhsDesc.stream;
  get _inNome => _bhsDesc.sink;

  final BehaviorSubject<int> _bhsPorcNormal = BehaviorSubject<int>();
  Stream<int> get porcNormal => _bhsPorcNormal.stream;
  get _inPorcNormal => _bhsPorcNormal.sink;

  final BehaviorSubject<int> _bhsPorcCompleta = BehaviorSubject<int>();
  Stream<int> get porcCompleta => _bhsPorcCompleta.stream;
  get _inPorcCompleta => _bhsPorcCompleta.sink;

  final BehaviorSubject<int> _bhsFechamento = BehaviorSubject<int>();
  Stream<int> get fechamento => _bhsFechamento.stream;
  get _inFechamento => _bhsFechamento.sink;

  final BehaviorSubject<bool> _bhsBancoHoras = BehaviorSubject<bool>();
  Stream<bool> get bancoHoras => _bhsBancoHoras.stream;
  get _inBancoHoras => _bhsBancoHoras.sink;

  final BehaviorSubject<String> _bhsSaida = BehaviorSubject<String>();
  Stream<String> get saida => _bhsSaida.stream;
  get _inSaida => _bhsSaida.sink;

  final BehaviorSubject<int> _bhsCarga = BehaviorSubject<int>();
  Stream<int> get cargaHoraria => _bhsCarga.stream;
  get _inCargaHoraria => _bhsCarga.sink;

  final BehaviorSubject<bool> _bhsAtivo = BehaviorSubject<bool>();
  Stream<bool> get ativo => _bhsAtivo.stream;
  get _inAtivo => _bhsAtivo.sink;

  final _bhsDiferenciadas = BehaviorSubject<List<Diferenciadas>>();
  Stream<List<Diferenciadas>> get outDiferenciadas => _bhsDiferenciadas.stream;
  get _inDiferenciadas => _bhsDiferenciadas.sink;

  @override
  void dispose() {
    _bhsDesc.close();
    _bhsPorcNormal.close();
    _bhsPorcCompleta.close();
    _bhsFechamento.close();
    _bhsBancoHoras.close();
    _bhsSaida.close();
    _bhsCarga.close();
    _bhsAtivo.close();
    _bhsDiferenciadas.close();
  }

  void setNome(String nome) {
    emprego = emprego.copyWith(nome: nome);
    _bhsDesc.sink.add(nome);
  }

  void setPorcNormal(int porc) {
    emprego = emprego.copyWith(porc: porc);
    _bhsPorcNormal.sink.add(porc);
  }

  void setPorcCompleta(int porc) {
    emprego = emprego.copyWith(porc_completa: porc);
    _bhsPorcCompleta.sink.add(porc);
  }

  void setFechamento(int f) {
    emprego = emprego.copyWith(fechamento: f);
    _bhsFechamento.sink.add(f);
  }

  void setBancoHora(bool b) {
    emprego = emprego.copyWith(banco_horas: b);
    _bhsBancoHoras.sink.add(b);
  }

  void setSaida(TimeOfDay s) {
    emprego = emprego.copyWith(saida: s.toShortString());
    _bhsSaida.sink.add(s.toShortString());
  }

  void setCargaHoraria(int carga) {
    emprego = emprego.copyWith(carga_horaria: carga);
    _bhsCarga.sink.add(carga);
  }

  void setAtivo(bool b) {
    emprego = emprego.copyWith(ativo: b);
    _bhsAtivo.sink.add(b);
  }

  void setDiferenciada(Diferenciadas dif, int newPorc) {
    final index = _diferenciadas.indexOf(dif);
    _diferenciadas[index] = _diferenciadas[index].copyWith(porc: newPorc);
    _inDiferenciadas.add(_diferenciadas);
  }
}
