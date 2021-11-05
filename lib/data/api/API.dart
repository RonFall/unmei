import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/services/base.dart';
import 'package:unmei/data/model/app_model.dart';

var mapKeys = {
  -1: "Одно из полей пустое!",
  1: "Неверный логин и/или пароль!",
  2: 'Проверка ReCaptcha не пройдена!',
  4: "Нет доступа!",
  5: "Аккаунт уже активирован! Вы будете перенаправлены на главную через 3 секунды.",
  6: "Токен истек!",
  8: "Новый и старый пароли совпадают!",
  9: "Необходима проверка ReCaptcha",
  10: "Неверно указан старый E-Mail",
  11: "Неверно указан старый пароль",
  100: "Не найдено!",
};

class API extends BaseService<Dio> {
  final url = "https://jsonplaceholder.typicode.com/todos/1";

  API(Dio client) : super(client) {
    client.options = BaseOptions(
      baseUrl: url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
  }

  Future<Response> getTodos() async {
    return client.get('https://jsonplaceholder.typicode.com/todos/1');
  }

  T convertData<T extends StringResponse>({required T cls, required dynamic data}) {
    return cls.fromJson(data);
  }

  Future<T> getNetworkData<T extends DataResponse>({required T cls, required String type}) async {
    final response = await client.get(type);
    final completer = new Completer<T>();
    if (response.statusCode == 200) {
      cls.fromJson(response.data);
      completer.complete(cls);
      return completer.future;
    } else {
      print("Error from getting Data: ${response.data}");
      throw Exception('Failed to load data');
    }
  }

  // Future<T> getUser<T extends DataResponse>({
  //   required T cls,
  //   required String type,
  // }) async {
  //   try {
  //     var token = await HiveStorage().get('token');
  //     final response = await client.get(
  //       type,
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );
  //     final completer = Completer<T>();
  //     if (response.statusCode == 200) {
  //       cls.fromJson(response.data);
  //       completer.complete(cls);
  //       return completer.future;
  //     }
  //   } on DioError catch (e, s) {
  //     if (e.response != null) {
  //       print("BODY ERROR: ${e.response!.data}");
  //     }
  //   } catch (e, s) {
  //     print("Error: $e\nTrace: $s");
  //   }
  //   throw Exception('Failed to load data');
  // }

  // Future onLogin({required String login, required String pass}) async {
  //   try {
  //     final Map<String, String> formData = {
  //       "login": login,
  //       "password": pass,
  //     };
  //     Response response = await client.post('auth/login?auth_type=token', data: formData);
  //     var respData = response.data;
  //     if (response.statusCode == 200) {
  //       print('Response body on 200: $respData');
  //       return respData;
  //     } else {
  //       return respData;
  //     }
  //   } on DioError catch (e, s) {
  //     if (e.response != null) {
  //       if (e.response!.statusCode == 401) {
  //         client.interceptors.requestLock.lock();
  //         client.interceptors.responseLock.lock();
  //         RequestOptions requestOptions = e.requestOptions;
  //         var token = await HiveStorage().get('token');
  //         final opts = Options(method: requestOptions.method);
  //         client.options.headers["Authorization"] = "Bearer " + token;
  //         client.options.headers["Accept"] = "*/*";
  //         client.interceptors.requestLock.unlock();
  //         client.interceptors.responseLock.unlock();
  //         final response = await client.request(
  //           requestOptions.path,
  //           options: opts,
  //           cancelToken: requestOptions.cancelToken,
  //           onReceiveProgress: requestOptions.onReceiveProgress,
  //           data: requestOptions.data,
  //           queryParameters: requestOptions.queryParameters,
  //         );
  //         return response.data;
  //       } else {
  //         return e.response!.data;
  //       }
  //     } else {
  //       return "Request options: ${e.requestOptions}\nError message: ${e.message}";
  //     }
  //   } catch (error, stacktrace) {
  //     return "Exception occurred: $error stackTrace: $stacktrace";
  //   }
  // }

  String onBodyError(int n) {
    switch (n) {
      case 1:
        return "Неверный логин и/или пароль!";
      case 2:
        return 'Проверка ReCaptcha не пройдена!';
      case 4:
        return "Нет доступа!";
      case 5:
        return "Аккаунт уже активирован! Вы будете перенаправлены на главную через 3 секунды.";
      case 6:
        return "Токен истек!";
      case 8:
        return "Новый и старый пароли совпадают!";
      case 9:
        return "Необходима проверка ReCaptcha";
      case 10:
        return "Неверно указан старый E-Mail";
      case 11:
        return "Неверно указан старый пароль";
      case 100:
        return "Не найдено!";
      default:
        return "Неизвестная ошибка!";
    }
  }
}
