import 'package:bookly/Features/home/data/Models/book_model/book_model.dart';
import 'package:bookly/Features/home/data/Repos/home_repo.dart';
import 'package:bookly/core/errors/failuers.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_services.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  HomeRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<BookModel>>> fetchBestNewestBooks() async {
    try {
      var data = await apiService.get(
          endPoint:
              'volumes?Filtering=free-ebooks&Sorting=newest&q=subject:programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() {
    // TODO: implement fetchFeaturedBooks
    throw UnimplementedError();
  }
}
