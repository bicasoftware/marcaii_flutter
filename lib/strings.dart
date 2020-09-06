import 'package:flutter/material.dart';

class Strings {
  static const String appName = "Marcaii";
  static const String appDescricao = "Gerenciador de Horas Extras";
  static const String salvar = "Salvar";
  static const String cancelar = "Cancelar";
  static const String remover = "Remover";
  static const String adicionar = "Adicionar";

  static const String calendario = "Calendário";
  static const String empregos = "Empregos";
  static const String diferenciadas = "Diferenciadas";
  static const String porcentagem = "Porcentagem";

  static const String descricao = "Descrição";
  static const String porcentagemNormal = "% Normal";
  static const String porcentagemCompleta = "% Feriados";
  static const String porcentagemDiferencial = "% Diferenciada";
  static const String fechamento = "Dia Fechamento";
  static const String bancoHoras = "Banco Horas";
  static const String saida = "Saída";
  static const String cargaHoraria = "Carga Horaria";
  static const String atual = "Emprego Atual";
  static const String removerEmprego = "Confirmar remoção";
  static const String removerEmpregoMessage = "Ao remover nenhum dado poderá ser recuperadas";

  static const String salarios = "Salários";
  static const String salario = "Salário";
  static const String vigencia = "Vigencia";

  static const String inicio = "Início";
  static const String termino = "Término";
  static const String tipoHora = "Tipo hora extra";
  static const String totalReceber = "Total a Receber";
  static const String horasExtras = "Horas Extras";
  static const String novaHorasExtra = "Nova hora extra";
  static const String das = "Das";
  static const String ate = "Até";
  static const String nenhumaHora = "Nenhuma Hora";
}

class Validations {
  static const String porcentagemRequerida = "Porcentagem requerida";
  static const String porcentagemInvalida = "Valores apenas acima de 30%";
  static const String salarioRequerido = "Salário obrigatório";
  static const String fechamentoRequerido = "Dia obrigatório";
  static const String fechamentoInvalido = "Apenas dia entre 1 e 30";
}

class Consts {
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

  static const tipoHoraSingular = <String>[
    "Normal",
    "Feriado",
    "Diferenciada",
  ];

  static const tipoHoraPlural = <String>["Normais", "Feriados", "Diferenciadas", "Totais"];

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

  static const cargaHoraria = <int, Widget>{
    220: Text("220"),
    200: Text("200"),
    180: Text("180"),
    150: Text("150"),
    120: Text("120"),
  };

  static const Duration animationDuration = Duration(milliseconds: 300);
}