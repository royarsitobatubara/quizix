import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/data/database/db_service.dart';
import 'package:quizix/models/detail_history_model.dart';
import 'package:quizix/screens/layout/layout_screen.dart';

class DetailHistoryScreen extends StatefulWidget {
  final String historyId;
  final String image;
  final String lesson;
  const DetailHistoryScreen({
    super.key,
    required this.historyId,
    required this.image,
    required this.lesson
  });

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {

  List<DetailHistoryModel> _data = [];
  
  Future<void> getData() async {
    try{
      final data = await getAllDetailHistory(historyId: int.parse(widget.historyId));
      setState(() {
        _data = data;
      });
    }catch(e){
      debugPrint('Gagal mengambil data: $e');
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        nameScreen: 'detail_history',
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(widget.image, width: 200, height: 200,),
              ),
              Text(widget.lesson.tr(), style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
              ),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('list'.tr(), textAlign: TextAlign.start,style:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                  ),),
                  Text('point'.tr(), textAlign: TextAlign.start,style:const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                  ),),
                ],
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                itemCount: _data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  final item = _data[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: item.answer.isEmpty
                                    ? Colors.orangeAccent.withValues(alpha: .2)
                                    : (item.isCorrect == 1
                                    ? Colors.greenAccent.withValues(alpha: .25)
                                    : Colors.redAccent.withValues(alpha: .2)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item.answer.isEmpty
                                    ? Icons.question_mark
                                    : (item.isCorrect == 1 ? Icons.check : Icons.close),
                                size: 24,
                                color: item.answer.isEmpty
                                    ? Colors.orange
                                    : (item.isCorrect == 1 ? Colors.green : Colors.red),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // isi teks Q & A
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Q: ${item.question}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    softWrap: true,
                                    maxLines: null,
                                  ),

                                  const SizedBox(height: 6),

                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: item.isCorrect == 1
                                          ? Colors.greenAccent.withValues(alpha: .12)
                                          : Colors.redAccent.withValues(alpha: .12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'A: ${item.answer.isNotEmpty ? item.answer : '-'}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[800],
                                      ),
                                      softWrap: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 10),

                            // poin
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '🔥',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '${item.isCorrect == 1 ? 10 : 0}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        )
    );
  }
}