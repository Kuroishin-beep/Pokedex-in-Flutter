import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import '../../domain/entity/evolution_entity.dart';
import '../../domain/evolution_use_case.dart';

part 'evolution_state.dart';

@injectable
class EvolutionCubit extends Cubit<EvolutionState> {
  EvolutionCubit(this._useCase) : super(EvolutionInitialState());

  final EvolutionUseCase _useCase;

  void requestEvolutionChain(Pokemon pokemon) async {
    emit(EvolutionLoadingState());
    try {
      final evolutionChain = await _useCase.getEvolutions(pokemon);
      if (evolutionChain.evolutions.isEmpty) {
        emit(NoEvolutionState(pokemon));
      } else {
        emit(EvolutionSuccessState(evolutionChain));
      }
    } catch (_) {
      emit(EvolutionFailureState());
    }
  }
}