import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/database/models/salarios.dart';
import 'package:marcaii_flutter/src/server/models/delete_dto.dart';
import 'package:marcaii_flutter/src/server/models/update_dto.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'salarios_client.g.dart';

@RestApi(baseUrl: '${Api.localhost}/salarios')
abstract class SalariosClient {
  factory SalariosClient(Dio dio) = _SalariosClient;

  @GET('/{id}')
  Future<List<Salarios>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() Salarios model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<Salarios> post(@Body() Salarios model);
}
