import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


final getIt = GetIt.instance;
void setupGetIt() {
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance());
  // getIt.registerSingleton(UserData());
}
