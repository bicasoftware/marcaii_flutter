// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empregos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Empregos _$EmpregosFromJson(Map<String, dynamic> json) {
  return Empregos(
    nome: json['nome'] as String,
    id: json['id'] as int,
    porc: json['porc'] as int,
    porc_completa: json['porc_completa'] as int,
    fechamento: json['fechamento'] as int,
    banco_horas: intToBool(json['banco_horas'] as int),
    saida: json['saida'] as String,
    carga_horaria: json['carga_horaria'] as int,
    ativo: intToBool(json['ativo'] as int),
  );
}

Map<String, dynamic> _$EmpregosToJson(Empregos instance) => <String, dynamic>{
      'nome': instance.nome,
      'saida': instance.saida,
      'id': instance.id,
      'porc': instance.porc,
      'porc_completa': instance.porc_completa,
      'fechamento': instance.fechamento,
      'carga_horaria': instance.carga_horaria,
      'banco_horas': boolToInt(instance.banco_horas),
      'ativo': boolToInt(instance.ativo),
    };
