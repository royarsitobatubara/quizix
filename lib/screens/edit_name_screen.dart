import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/screens/layout/layout_input.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _msg;

  Future<void> _handleEditName() async {
    try{
      final data = await UserService.updateNameUser(_nameController.text);
      if(data == true){
        if(!mounted)return;
        context.read<UserProvider>().loadName();
        context.pop();
        return;
      }
      setState(() {
        _msg = 'failed_to_update';
      });
    }catch(e){
      debugPrint('Terjadi kesalahan pada _handleEditName: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutInput(
      nameScreen: 'edit_name',
      title: 'enter_your_new_name',
      hintText: 'type_your_name',
      controller: _nameController,
      handle: _handleEditName,
      msgError: _msg,
    );
  }
}
