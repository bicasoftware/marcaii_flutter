import 'package:marcaii_flutter/src/connection/dio_provider.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/services/client/service_emprego_impl.dart';
import 'package:marcaii_flutter/strings.dart';

class ServiceEmprego implements ServiceEmpregoImpl {
  @override
  Future<List<Empregos>> fetchEmpregos() async {
    const url = '${Strings.baseUrl}/empregos';
    final result = await provideDio().get<List<dynamic>>(url);
    return Empregos.fromJsonList(result.data);
  }
}
