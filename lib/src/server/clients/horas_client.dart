import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/database/models/horas.dart';
import 'package:marcaii_flutter/src/server/models/delete_dto.dart';
import 'package:marcaii_flutter/src/server/models/update_dto.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'horas_client.g.dart';

@RestApi(baseUrl: '${Api.localhost}/horas')
abstract class HorasClient {
  factory HorasClient(Dio dio) = _HorasClient;

  @GET('/{id}')
  Future<List<Horas>> fetchHoras(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> updateHora(@Path() int id, @Body() Horas model);

  @DELETE('/{id}')
  Future<DeleteDto> deleteHora(@Path() int id);

  @POST('/')
  Future<Horas> insert(@Body() Horas model);
}
