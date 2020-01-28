// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Horas _$HorasFromJson(Map<String, dynamic> json) {
  return Horas(
    emprego_id: json['emprego_id'] as int,
    data: json['data'] == null ? null : DateTime.parse(json['data'] as String),
    id: json['id'] as int,
    tipo: json['tipo'] as int,
    inicio: json['inicio'] as String,
    termino: json['termino'] as String,
  );
}

Map<String, dynamic> _$HorasToJson(Horas instance) => <String, dynamic>{
      'id': instance.id,
      'emprego_id': instance.emprego_id,
      'tipo': instance.tipo,
      'inicio': instance.inicio,
      'termino': instance.termino,
      'data': instance.data?.toIso8601String(),
    };
