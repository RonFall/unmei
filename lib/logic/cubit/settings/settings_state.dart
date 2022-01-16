part of 'settings_cubit.dart';

class SettingsState {
  final AppTheme theme;
  final bool newsPush;
  final bool novelsPush;
  final bool updatesPush;

  SettingsState({
    this.theme = AppTheme.dark,
    this.newsPush = false,
    this.novelsPush = false,
    this.updatesPush = false,
  });
}