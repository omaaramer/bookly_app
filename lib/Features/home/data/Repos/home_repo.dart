import 'package:bookly/Features/home/data/Models/book_model/book_model.dart';
import 'package:bookly/core/errors/failuers.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookModel>>> fetchBestNewestBooks();
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();
}
