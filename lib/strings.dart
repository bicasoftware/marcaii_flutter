import 'package:flutter/material.dart';

class Strings {
  static const String appName = "Marcaii";
  static const String appDescricao = "Gerenciador de Horas Extras";
  static const String salvar = "Salvar";
  static const String atencao = "Atenção";
  static const String descartar = "Descartar!";
  static const String cancelar = "Cancelar";
  static const String remover = "Remover";

  static const String calendario = "Calendário";
  static const String parciais = "Parciais";
  static const String emprego = "Emprego";
  static const String empregos = "Empregos";
  static const String sair = "Sair";
  static const String adicionar = "Adicionar";
  static const String diferenciada = "diferenciada";
  static const String diferenciadas = "Diferenciadas";
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
  static const String descartarAlteracoes = "Deseja descartar as alterações feitas?";
  static const String removerEmprego = "Confirmar remoção";
  static const String removerEmpregoMessage = "Ao remover nenhum dado poderá ser recuperadas";

  static const String salarios = "Salários";
  static const String salario = "Salário";
  static const String vigencia = "Vigencia";

  static const String inicio = "Início";
  static const String termino = "Término";
  static const String tipoHora = "Tipo hora extra";
  static const String horaNormal = "Hora Extra Normal";
  static const String normais = "Normais";
  static const String horaCompleta = "Hora Extra Feriados";
  static const String feriados = "Feriados";
  static const String horaDiferenciada = "Hora extra Diferenciada";
  static const String totais = "Totais";
  static const String totalReceber = "Total a Receber";
  static const String verTotais = "Ver Totais";
  static const String horasExtras = "Horas Extras";
  static const String das = "Das";
  static const String ate = "Até";
  static const String minutos = "minutos";
  static const String nenhumaHora = "Nenhuma Hora";
}

class Validations {
  static const String porcentagemRequerida = "Porcentagem requerida";
  static const String porcentagemInvalida = "Valores apenas acima de 30%";
  static const String salarioRequerido = "Salário obrigatório";
  static const String salarioZerado = "Salário não pode ser menor que zero";
  static const String fechamentoRequerido = "Dia obrigatório";
  static const String fechamentoInvalido = "Apenas dia entre 1 e 30";
  static const String horariosIguais = "Os horários não podem ser os mesmos";
  static const String horarioInvalido = "A hora de início depois da hora de término";
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

  static const weekdayColors = <Color>[
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.teal,
    Colors.amber,
    Colors.purple,
  ];

  static const cargasHoraria = <int>[
    220,
    200,
    180,
    150,
    120,
  ];

  static const tipoHora = <String>["Normais", "Feriados", "Diferenciadas", "Totais"];

  static const tipoHoraPlural = <String>[
    "Normal",
    "Feriado",
    "Diferenciada",
  ];

  static const horaColor = <Color>[
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.lightBlue,
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

  static const List<Color> empregosColor = [
    Colors.lightBlue,
    Colors.pink,
    Colors.indigo,
    Colors.purple,
    Colors.yellow,
  ];
}

class Maps {
  static const cargaHoraria = <int, Widget>{
    220: Text("220"),
    200: Text("200"),
    180: Text("180"),
    150: Text("150"),
    120: Text("120"),
  };
}

class AppConstants {
  static const Duration animationDuration = Duration(milliseconds: 300);
}
