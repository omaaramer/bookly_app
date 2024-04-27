import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/Models/book_model/book_model.dart';
import '../../../data/Repos/home_repo.dart';

part 'featured_bookes_state.dart';

class FeaturedBookesCubit extends Cubit<FeaturedBookesState> {
  FeaturedBookesCubit(this.homeRepo) : super(FeaturedBookesInitial());
  final HomeRepo homeRepo;
  Future<void> featchFeaturedBooks() async {
    emit(FeaturedBookesLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold((failure) {
      emit(FeaturedBookesFailure(errorMessage: failure.errormessage));
    }, (books) {
      emit(FeaturedBookesSuccess(books: books));
    });
  }
}
