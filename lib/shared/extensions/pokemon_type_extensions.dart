import 'package:pokedex/pokedex.dart';
import '../../designs/constants/pokedex_type_color.dart';
import '../../designs/extension/design_string_extensions.dart';

extension PokemonTypeExtensions on PokemonType {
  PokedexTypeColor get color => type.name.pokemonColor;
}