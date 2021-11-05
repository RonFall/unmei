import 'package:flutter_request_bloc/repositories/base.dart';
import 'package:unmei/data/api/API.dart';

class NewsRepository extends BaseRepository<API, dynamic> {
  NewsRepository(API service) : super(service);

  @override
  Future<dynamic> fetchData() async {
    final response = await service.getTodos();
    return response.data;
  }
}