import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:unmei/app/presentation/app_themes.dart';
import 'package:unmei/logic/cubit/settings/settings_cubit.dart';

class SettingsModalWidget extends StatelessWidget {
  const SettingsModalWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: SnappingSheet(
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 6,
                      height: 6,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  themeCard(
                    context: context,
                    color: Color(0xFFd7d7d7),
                    textColor: Colors.black,
                    theme: AppTheme.values[0],
                    name: 'Light',
                  ),
                  themeCard(
                    context: context,
                    color: Color(0xFF484848),
                    textColor: Colors.white,
                    theme: AppTheme.values[1],
                    name: 'Dark',
                  ),
                  themeCard(
                    context: context,
                    color: Color(0xFF702e2e),
                    textColor: Colors.white,
                    theme: AppTheme.values[2],
                    name: 'RedDark',
                  ),
                  themeCard(
                    context: context,
                    color: Color(0xFF373760),
                    textColor: Colors.white,
                    theme: AppTheme.values[3],
                    name: 'BlueDark',
                  ),
                  themeCard(
                    context: context,
                    color: Color(0xFF395c39),
                    textColor: Colors.white,
                    theme: AppTheme.values[4],
                    name: 'GreenDark',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget themeCard({
    required BuildContext context,
    required AppTheme theme,
    required String name,
    required Color color,
    required Color textColor,
  }) {
    final cubit = context.read<SettingsCubit>();
    return Card(
      elevation: 5,
      color: color,
      child: ListTile(
        onTap: () {
          cubit.changeTheme(theme);
        },
        title: Text(
          name,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
