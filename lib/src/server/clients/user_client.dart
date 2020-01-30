import 'package:dio/dio.dart';
import 'package:marcaii_flutter/src/server/models/refresh_token_dto.dart';
import 'package:marcaii_flutter/src/server/models/refresh_token_result_dto.dart';
import 'package:marcaii_flutter/src/server/models/user_dto.dart';
import 'package:marcaii_flutter/strings.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_data_dto.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: '${Api.localhost}/auth')
abstract class UserClient {
  factory UserClient(Dio dio) = _UserClient;

  @POST('/authenticate')
  Future<UserDataDto> authenticate(@Body() UserDto model);

  @POST('/register')
  Future<UserDataDto> register(@Body() UserDto model);

  @POST('/unregister')
  Future<void> unregister();

  @POST('/refresh')
  Future<RefreshTokenResultDto> refreshToken(@Body() RefreshTokenDto refreshToken);
}
