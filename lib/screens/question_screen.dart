import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/db_service.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/models/detail_history_model.dart';
import 'package:quizix/models/history_model.dart';
import 'package:quizix/models/question_model.dart';
import 'package:quizix/services/screen_service.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';
import 'package:quizix/widgets/answer_item.dart';
import 'package:quizix/widgets/progress_bar.dart';

class QuestionScreen extends StatefulWidget {
  final String lesson;
  final String level;
  const QuestionScreen({super.key, required this.lesson, required this.level});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentIndex = 0;
  int timeProgress = 0;
  int maxTime = 60;
  int? _selectedAnswer;
  bool _isActive = true;
  bool _isEnable = true;
  List<QuestionModel> _question = [];
  final Map<int, int> _answer = {};


  // FUNCTION NAVIGASI PERTANYAAN
  void handleSwapQuestion(String handle) {
    setState(() {
      _selectedAnswer = null;
      if (handle == 'next') {
        if (currentIndex < _question.length - 1) {
          currentIndex++;
        }
      }else if (handle == 'prev'){
        if (currentIndex > 0) {
          currentIndex--;
        }
      }else if (handle == 'send'){
        showPopUpInfo(context: context,title: 'are_you_sure_you_want_to_save_it', btn1: 'cancel', btn2: 'yes', image: AppImages.sure, onClick: ()=>_submitAnswers());
        return;
      }
      _selectedAnswer = _answer[currentIndex];
    });
  }

  // FUNCTION JAWABAN
  void _handleAnswer(int index) {
    setState(() {
      _selectedAnswer = index;
      _answer[currentIndex] = index;
    });
  }

  // FUNCTION BUAT MENYELESAIKAN SOAL
  Future<void> _submitAnswers() async {
    int correct = 0;
    int wrong = 0;
    int skip = 0;
    for (int i=0; i < _question.length; i++){
      final userAnswer = _answer[i];
      final correctAnswer = _question[i].correctIndex;

      if(userAnswer == correctAnswer){
        correct++;
      }else if(userAnswer == null){
        skip++;
      }else{
        wrong++;
      }
    }
    final score = correct * 10;
    final userProvider = context.read<UserProvider>();
    await userProvider.addPoint(score);
    await userProvider.addProgressDaily(1);
    final newHistory = HistoryModel(lesson: widget.lesson, level: widget.level, point: score);
    final historyId = await userProvider.addHistory(newHistory);
    for(int i=0; i<_question.length; i++){
      final q = _question[i];
      final userAnswer = _answer[i];
      final isCorrect = userAnswer == q.correctIndex ? 1 : 0;
      final answerText = userAnswer != null ? q.options[userAnswer] : '';
      await insertDetailHistory(DetailHistoryModel(
          historyId: historyId,
          question: q.question,
          answer: answerText,
          isCorrect: isCorrect)
      );
    }

    if (!mounted) return;
    context.push('/result', extra: {
      'correct': correct,
      'wrong': wrong,
      'skip': skip,
      'score': score,
    });
  }


  // FUNCTION WAKTU
  void _startTimer() async {
    timeProgress = 0;
    for (int i = 0; i <= maxTime; i++) {
      if(!_isActive) return;
      await Future.delayed(const Duration(seconds: 1));
      if(!_isActive) return;
      setState(() {
        timeProgress = i;
      });

      if (i >= maxTime) {
        setState(() {
          _isEnable = false;
        });
        if(!mounted) return;
        showPopUpInfo(context: context, title: 'times_up', btn1: 'close', btn2: 'save', image: AppImages.timer, onClick: _submitAnswers);
      }
    }
  }

  // FUNCTION INISIALISASI
  void _loadData() {
    final data = getQuestion(widget.lesson, widget.level);
    setState(() {
      _question = data;
      debugPrint('data: $_question');
    });
    _startTimer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _isActive = false;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: (){
              showPopUpInfo(context: context, title: 'if_you_exit_the_points_will_not_be_saved', btn1: 'cancel', btn2: 'yes', image: AppImages.sure, onClick: (){
                context.pop();
                context.pop();
              });
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title: Text(
          '${(currentIndex + 1).toString()}/${_question.length.toString()}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.deepBlue.withValues(alpha: .9),
              AppColors.lightBlue.withValues(alpha: .9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // <---------------- QUESTION CARD ---------------->
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(25),
                        border:
                        Border.all(color: Colors.white.withValues(alpha: .2)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _question[currentIndex].question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Text("Time",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ProgressBar(
                                  progress: timeProgress,
                                  max: maxTime,
                                  heightBar: 8,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(timeProgress ~/ 60).toString().padLeft(2, '0')}:${(timeProgress % 60).toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // <---------------- ANSWER LIST ---------------->
                Expanded(
                  child: _question.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _question[currentIndex].options.length,
                    itemBuilder: (context, index) {
                      final order = String.fromCharCode(65 + index).toUpperCase();
                      final answer = _question[currentIndex].options[index];
                      return AnswerItem(
                          answer: answer,
                          order: order,
                          onTap: ()=> _handleAnswer(index),
                          isTrue: _selectedAnswer == index,
                          isEnable: _isEnable,
                      );
                    },
                  ),
                ),


                const SizedBox(height: 10),

                // <---------------- NAVIGATION BUTTONS ---------------->
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navButton(Icons.arrow_left, "prev", Colors.orange, () => handleSwapQuestion("prev")),
                    _navButton(Icons.arrow_right, currentIndex == 9? "send" : "next", Colors.greenAccent, () => handleSwapQuestion(currentIndex == 9? "send" : "next")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 30),
      label: Text(
        label.tr(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: .8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 6,
        shadowColor: color.withValues(alpha: .5),
      ),
    );
  }
}
