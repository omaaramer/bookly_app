import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/data/Repos/home_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../data/Models/book_model/book_model.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

  final HomeRepo homeRepo;
  Future<void> featchFeaturedBooks() async {
    emit(NewestBooksLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold((failure) {
      emit(NewestBooksFailure(errorMessage: failure.errormessage));
    }, (books) {
      emit(NewestBooksSuccess(books: books));
    });
  }
}
