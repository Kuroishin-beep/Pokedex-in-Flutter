import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_config.dart';

@InjectableInit(asExtension: false)
Future<void> configureDependencies() async => init(GetIt.instance);