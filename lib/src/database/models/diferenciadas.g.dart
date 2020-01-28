// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diferenciadas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diferenciadas _$DiferenciadasFromJson(Map<String, dynamic> json) {
  return Diferenciadas(
    id: json['id'] as int,
    emprego_id: json['emprego_id'] as int,
    porc: json['porc'] as int,
    weekday: json['weekday'] as int,
    vigencia: json['vigencia'] as String,
    ativo: intToBool(json['ativo'] as int),
  );
}

Map<String, dynamic> _$DiferenciadasToJson(Diferenciadas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emprego_id': instance.emprego_id,
      'porc': instance.porc,
      'weekday': instance.weekday,
      'vigencia': instance.vigencia,
      'ativo': boolToInt(instance.ativo),
    };
