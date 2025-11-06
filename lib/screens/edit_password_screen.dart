import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/screens/layout/layout_input.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String? _msg;

  Future<void> _handleEditPassword() async {
    try{
      final data = await UserService.updatePasswordUser(_passwordController.text);
      if(data == true){
        if(!mounted)return;
        context.pop();
        return;
      }
      setState(() {
        _msg = "failed_to_update";
      });
    }catch(e){
      debugPrint('Terjadi kesalahan pada _handleEditPassword: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutInput(
      handle: _handleEditPassword,
      controller: _passwordController,
      nameScreen: 'edit_password',
      hintText: 'type_your_password',
      title: 'enter_your_new_password',
      msgError: _msg,
    );
  }
}
