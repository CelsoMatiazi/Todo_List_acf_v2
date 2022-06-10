
import 'package:provider/provider.dart';
import 'package:todo_acf_v2/app/core/modules/todo_list_module.dart';
import 'package:todo_acf_v2/app/modules/auth/login/login_controller.dart';
import 'package:todo_acf_v2/app/modules/auth/login/login_page.dart';
import 'package:todo_acf_v2/app/modules/auth/register/register_contoller.dart';
import 'package:todo_acf_v2/app/modules/auth/register/register_page.dart';

class AuthModule extends TodoListModule{
  AuthModule() : super(
    bindings: [
      ChangeNotifierProvider(create: (_) => LoginController()),
      ChangeNotifierProvider(create: (_) => RegisterController()),
    ],
    routers: {
      '/login' : (context) => const LoginPage(),
      '/register' : (context) => const RegisterPage(),
    }
  );

}