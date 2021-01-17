part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class CityEmptyState extends SearchState {}

class CityLoadingState extends SearchState {}

class CityLoadedState extends SearchState {
  final List<CityModel> cityModels;
  CityLoadedState({@required this.cityModels}):assert(cityModels != null);

  List<Object> get props => [cityModels];

}

class CityNoResultState extends SearchState{

}


class CityErrorState extends SearchState {
  final String error;
  CityErrorState({@required this.error}):assert(error != null);

}