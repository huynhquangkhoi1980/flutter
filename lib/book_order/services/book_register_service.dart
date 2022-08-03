import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/book_order/models/book.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

import 'package:dio/dio.dart';
import 'package:mevn_app/app/utils/services/app_service_provider.dart';
import 'package:mevn_app/kickoff/local/pref_provider.dart';

class BookRegisterService extends AppServiceProvider {
  BookRegisterService(Dio _dio) : super(_dio);

  Future<bool> registerBook(Book book) async {
    // print(book.kind);
    print('ak477777');
    //bool res = await dioHelper.get(route: '/config/register_book');
    // return res;
    final response = await dioHelper.post(
      route: '/book-register',
      requestBody: book.toJson(),
    );

    return true;
  }
}
