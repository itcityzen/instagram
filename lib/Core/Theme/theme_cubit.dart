import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedPreferences/CachHelper.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    getThemeFromShared();
  }

  void getThemeFromShared() async {
    bool isDark = await SharedPreferencesHelper.getTheme();
    print('Get is $isDark ');
    if (isDark) {
      emit(ThemeisDark());
    } else {
      emit(ThemeisLight());
    }
  }

  void ToggleTheme() async {
    if (state is ThemeisDark) {
      emit(ThemeisLight());
      await SharedPreferencesHelper.setTheme(false);
      print('Switched Light');
    } else {
      emit(ThemeisDark());
      await SharedPreferencesHelper.setTheme(true);
      print('Switched Dark');
    }
  }
}
