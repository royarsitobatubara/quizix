import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/models/user_model.dart';
import 'package:quizix/screens/layout/layout_screen.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {

  int? _userId;

  Future<void> initData() async {
    final id = await UserPreferences.getIdUser();
    if (!mounted) return;
    setState(() {
      _userId = id;
    });
    context.read<UserProvider>().loadAllData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      nameScreen: 'swap_account',
      child: Selector<UserProvider, List<UserModel>>(
        selector: (_, prov)=>prov.userList,
        builder: (_, value, _){
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: value.length,
            itemBuilder: (context, index) {
              final user = value[index];
              if (_userId == user.id) {
                return const SizedBox.shrink();
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(user.profile),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text(
                    '${user.gender} | Rank: ${user.rank}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade600,
                  ),
                  onTap: () {
                    context.push('/validate-password', extra: {
                      'email': user.email,
                      'password': user.password
                    });
                  },
                ),
              );
            },
          );
        }
      )
    );
  }
}
