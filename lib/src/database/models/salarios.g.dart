// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salarios.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Salarios _$SalariosFromJson(Map<String, dynamic> json) {
  return Salarios(
    id: json['id'] as int,
    emprego_id: json['emprego_id'] as int,
    valor: double.tryParse(json['valor'] as String),
    vigencia: json['vigencia'] as String,
    ativo: json['ativo'] as bool,
  );
}

Map<String, dynamic> _$SalariosToJson(Salarios instance) => <String, dynamic>{
      'id': instance.id,
      'emprego_id': instance.emprego_id,
      'valor': instance.valor,
      'vigencia': instance.vigencia,
      'ativo': instance.ativo,
    };
