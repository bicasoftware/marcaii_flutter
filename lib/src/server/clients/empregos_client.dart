import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/database/models/empregos.dart';
import 'package:marcaii_flutter/src/server/models/delete_dto.dart';
import 'package:marcaii_flutter/src/server/models/update_dto.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:retrofit/retrofit.dart';

part 'empregos_client.g.dart';

@RestApi(baseUrl: '${Api.localhost}/empregos')
abstract class EmpregosClient {
  factory EmpregosClient(Dio dio) = _EmpregosClient;

  @GET('/{id}')
  Future<Empregos> fetchById();

  @GET('/{id}')
  Future<List<Empregos>> fetch();

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() Empregos model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<Empregos> post(@Body() Empregos model);
}