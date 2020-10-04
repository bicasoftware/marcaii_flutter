import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/connection/dio_provider.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/database/models/insert_result.dart';
import 'package:marcaii_flutter/src/services/client/service_horas_impl.dart';
import 'package:marcaii_flutter/strings.dart';

class ServiceHoras implements ServiceHorasImpl {
  @override
  Future<List<Horas>> fetchHora(int empregoId) async {
    final url = "${Strings.baseUrl}/horas/$empregoId";
    final result = await provideDio().get<List<Object>>(url);
    return Horas.fromJsonList(result.data);
  }

  @override
  Future<InsertResult> post(Horas hora) async {
    const url = "${Strings.baseUrl}/horas";
    final Response<Object> result = await provideDio().post<Object>(
      url,
      data: hora.toJson(),
    );

    print(result.data);
    return InsertResult.fromJson(result.data);
  }
}
