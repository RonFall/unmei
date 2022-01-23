import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:unmei/app/presentation/app_themes.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  @override
  void onChange(Change<SettingsState> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    throw Exception(error);
  }

  void changeTheme(AppTheme theme) {
    emit(SettingsState(theme: theme));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    final theme = json['theme'];

    AppTheme currentTheme = AppTheme.values.firstWhere((e) {
      return e.toString() == theme;
    });

    return SettingsState(theme: currentTheme);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    final theme = {
      'theme': state.theme.toString(),
    };
    return theme;
  }
}
