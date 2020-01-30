import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/database/models/diferenciadas.dart';
import 'package:marcaii_flutter/src/server/models/delete_dto.dart';
import 'package:marcaii_flutter/src/server/models/update_dto.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'diferenciadas_client.g.dart';

@RestApi(baseUrl: '${Api.localhost}/diferencidas')
abstract class DiferenciadasClient {
  factory DiferenciadasClient(Dio dio) = _DiferenciadasClient;

  @GET('/{id}')
  Future<List<Diferenciadas>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() Diferenciadas model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<Diferenciadas> post(@Body() Diferenciadas model);
}
