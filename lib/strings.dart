import 'package:flutter/material.dart';

class Strings {
  static const String appName = "Marcaii";
  static const String salvar = "Salvar";


  static const String calendario = "Calendário";
  static const String parciais = "Parciais";
  static const String emprego = "Emprego";
  static const String empregos = "Empregos";
  static const String sair = "Sair";
  static const String adicionar = "Adicionar";
  static const String diferenciada = "diferenciada";
  static const String diferenciadas = "Horas Diferenciadas";
  static const String diaSemana = "Dia da Semana";
  static const String porcentagem = "Porcentagem";

  static const String descricao = "Descrição";
  static const String porc = "% Normal";
  static const String porcCompleta = "% Feriados";
  static const String porcDifer = "% Diferenciada";
  static const String fechamento = "Dia Fechamento";
  static const String bancoHoras = "Banco Horas";
  static const String saida = "Saída";
  static const String cargaHoraria = "Carga Horaria";
  static const String ativo = "Ativo";
  static const String atual = "Emprego Atual";
}

class Api {
  static const String url = "https://marcaii.herokuapp.com";
  // static const String url = "http://192.168.15.3:3000";
  static const String localhost = "http://localhost:3000";
}

class Consts {
  static const List<String> weekDay = [
    "DOM",
    "SEG",
    "TER",
    "QUA",
    "QUI",
    "SEX",
    "SAB",
  ];
  static const List<String> weekDayShort = [
    "D",
    "S",
    "T",
    "Q",
    "Q",
    "S",
    "S",
  ];
  static const List<String> weekDayExtenso = [
    "Domingo",
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
  ];

  static const cargasHoraria = <int>[
    220,
    200,
    180,
    150,
    120,
  ];

  static const tipoHora = <String>[
    "Normal",
    "Feriado",
    "Diferenciada",
  ];

  static const horaColor = <Color>[
    Colors.green,
    Colors.indigo,
    Colors.red,
  ];

  static const meses = <String>[
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  static const appBarTitles = [
    Strings.empregos,
    Strings.calendario,
    Strings.parciais,
  ];
}
