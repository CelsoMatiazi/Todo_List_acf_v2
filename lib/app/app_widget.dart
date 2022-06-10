import 'package:flutter/material.dart';
import 'package:todo_acf_v2/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_acf_v2/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_acf_v2/app/modules/auth_module.dart';
import 'package:todo_acf_v2/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}
class _AppWidgetState extends State<AppWidget> {

  final sqliteAdmConnection = SqliteAdmConnection();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }


  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO LIST PROVIDER",
      initialRoute: '/login',
      theme: TodoListUiConfig.theme,
      debugShowCheckedModeBanner: false,
      routes: {
        ...AuthModule().routers
      },
      home: const SplashPage(),
    );
  }
}
