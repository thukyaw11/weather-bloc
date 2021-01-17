import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/network/model/models.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://www.metaweather.com/api/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    return ApiService(dio);
  }

  @GET("location/{locationId}")
  Future<WeathersModel> getWeather(@Path() int locationId);

  @GET("location/search/")
  Future<List<CityModel>> getCities(@Query("query") String keyword);

}
