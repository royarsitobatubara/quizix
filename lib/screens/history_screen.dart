import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/widgets/history_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "history".tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: ['easy', 'medium', 'hard'].map((itm){
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: itm == 'easy'? Colors.greenAccent : (itm == 'medium' ? Colors.orangeAccent : Colors.red)
                ),
                child: Text(itm.tr(), style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
              );
            }).toList()
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                final historyList = userProvider.history.reversed.toList();
                if(historyList.isEmpty){
                  return Center(
                    child: Text('no_history'.tr(), style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                  );
                }
                return ListView.builder(
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    return HistoryItem(history: historyList[index]);
                  },
                );
              },
            ),
          )

        ],
      ),
    );
  }
}
