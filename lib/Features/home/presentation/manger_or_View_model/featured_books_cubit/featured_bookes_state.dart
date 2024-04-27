part of 'featured_bookes_cubit.dart';

sealed class FeaturedBookesState extends Equatable {
  const FeaturedBookesState();

  @override
  List<Object> get props => [];
}

final class FeaturedBookesInitial extends FeaturedBookesState {}

final class FeaturedBookesLoading extends FeaturedBookesState {}

final class FeaturedBookesSuccess extends FeaturedBookesState {
  final List<BookModel> books;

  const FeaturedBookesSuccess({required this.books});
}

final class FeaturedBookesFailure extends FeaturedBookesState {
  final String errorMessage;

  const FeaturedBookesFailure({required this.errorMessage});
}
