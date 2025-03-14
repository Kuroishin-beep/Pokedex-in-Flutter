import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import '../../domain/use_case.dart';
import '../../domain/entity/about_entity.dart';

part 'about_state.dart';

@injectable
class AboutCubit extends Cubit<AboutState> {
  AboutCubit(this._useCase) : super(AboutInitialState());
  final AboutUseCase _useCase;

  void requestData(Pokemon pokemon) async {
    emit(AboutLoadingState());
    try {
      emit(AboutSuccessState(await _useCase.getAbout(pokemon)));
    } catch (_) {
      emit(AboutFailureState());
    }
  }
}