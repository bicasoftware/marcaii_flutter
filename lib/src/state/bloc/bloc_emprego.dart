import 'package:flutter/material.dart';
import 'package:marcaii_flutter/helpers.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/state/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocEmprego with BaseBloc {
  BlocEmprego({
    @required this.emprego,
  }) {
    _inNome.add(emprego.nome ?? "");
    _inPorcNormal.add(emprego.porc);
    _inPorcCompleta.add(emprego.porc_completa);
    _inFechamento.add(emprego.fechamento ?? 25);
    _inBancoHoras.add(emprego.banco_horas);
    _inCargaHoraria.add(emprego.carga_horaria);
    _inAtivo.add(emprego.ativo);
    _inSaida.add(emprego.saida);
    _oldEmprego = emprego.copyWith();
    _fillDiferenciadas();
    _fillSalarios();
  }

  Empregos emprego, _oldEmprego;
  List<Diferenciadas> _diferenciadas;
  List<Salarios> _salarios;
  double _salarioInicial;

  bool didChange() {
    if (emprego.id == null) {
      return true;
    } else {
      return !_oldEmprego.equals(
        emprego,
        _salarios,
        _diferenciadas.where((d) => d.porc != 0).toList()
          ..sort((a, b) => a.weekday.compareTo(b.weekday)),
      );
    }
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

  _fillSalarios() {
    if (emprego.id == null) {
      _salarioInicial = 998.00;
      _inInitSalario.add(_salarioInicial);
    } else {
      _salarios = <Salarios>[]..addAll(emprego.salarios ?? []);
      _inSalarios.add(_salarios);
    }
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

  final BehaviorSubject<List<Salarios>> _bhsSalarios = BehaviorSubject<List<Salarios>>();
  Stream<List<Salarios>> get salarios => _bhsSalarios.stream;
  Sink<List<Salarios>> get _inSalarios => _bhsSalarios.sink;

  final BehaviorSubject<double> _bhsinitSalario = BehaviorSubject<double>();
  Stream<double> get initSalario => _bhsinitSalario.stream;
  Sink<double> get _inInitSalario => _bhsinitSalario.sink;

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
    _bhsSalarios.close();
    _bhsinitSalario.close();
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

  void addSalario({String vigencia, double valor}) {
    _salarios.add(
      Salarios(
        valor: valor,
        vigencia: vigencia,
        ativo: true,
        emprego_id: emprego.id,
      ),
    );
    _inSalarios.add(_salarios);
  }

  void deleteSalario(Salarios sal) {
    _salarios.remove(sal);
    _inSalarios.add(_salarios);
  }

  void updateSalario({
    @required Salarios salario,
    @required String vigencia,
    @required double valor,
  }) {
    final index = _salarios.indexOf(salario);
    _salarios[index] = _salarios[index].copyWith(
      vigencia: vigencia,
      valor: valor,
    );

    _inSalarios.add(_salarios);
  }

  void setSalarioInit(double s) {
    _salarioInicial = s;
    _inInitSalario.add(_salarioInicial);
  }

  List<Diferenciadas> getValidDiferenciadas() {
    return _diferenciadas.where((d) => d.porc != 0).toList();
  }

  Empregos provideResult() {
    if (emprego.id == null) {
      return emprego.copyWith(
        salarios: [
          Salarios(
            valor: _salarioInicial,
            vigencia: "01/2010",
            ativo: true,
          ),
        ],
        diferenciadas: getValidDiferenciadas(),
      );
    } else {
      return emprego.copyWith(
        salarios: _salarios,
        diferenciadas: getValidDiferenciadas(),
      );
    }
  }
}
