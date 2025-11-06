import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/data/provider/data_provider.dart';
import 'package:quizix/data/provider/history_provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/screens/layout/layout_input.dart';

class ValidatePasswordScreen extends StatefulWidget {
  final String email;
  final String password;
  const ValidatePasswordScreen({
    super.key,
    required this.email,
    required this.password
  });

  @override
  State<ValidatePasswordScreen> createState() => _ValidatePasswordScreenState();
}

class _ValidatePasswordScreenState extends State<ValidatePasswordScreen> {
  String? _msg;
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _validatePasswordHandle() async {
    try{
      if(_passwordController.text.trim() == widget.password.trim()){
        final data = await UserService.getUserByEmailPassword(email: widget.email.trim(), password: _passwordController.text.trim());
        if(data == null){
          debugPrint('login: $data');
          setState(() {
            _msg = 'wrong_password';
          });
          return;
        }
        await UserPreferences.setIdUser(data.id!);
        await UserPreferences.setDataLogin(value: true);
        if(!mounted) return;
        context.read<UserProvider>().loadAllData();
        context.read<HistoryProvider>().loadAllHistory();
        context.read<DataProvider>().loadAll();
        context.go('/splash');
        return;
      }
      setState(() {
        _msg = 'wrong_password';
      });
    }catch(e){
      debugPrint('Terjadi kesalahan pada _validatePassword: $e');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutInput(
      handle: _validatePasswordHandle,
      controller: _passwordController,
      nameScreen: 'confirm_account',
      hintText: 'enter_password_this_account',
      title: 'enter_password',
      msgError: _msg,
    );
  }
}
