import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/data/list_data.dart';
import 'package:quizix/widgets/question_item.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          child: Text(
            "choose_category".tr(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 18, bottom: 5),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: allQuestion.length,
              itemBuilder: (context, index){
                final data = allQuestion[index];
                return QuestionItem(
                    title: data.title,
                    image: data.image,
                    route: data.route
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
