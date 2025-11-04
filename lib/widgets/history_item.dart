import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/data/list_data.dart';
import 'package:quizix/models/history_model.dart';
import 'package:quizix/utils/app_images.dart';

class HistoryItem extends StatelessWidget {
  final HistoryModel history;

  const HistoryItem({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final image = allQuestion.any((itm) => itm.title == history.lesson)
        ? allQuestion.firstWhere((itm) => itm.title == history.lesson).image
        : AppImages.anchor;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push(
        '/detail-history',
        extra: {
          'historyId': history.id.toString(),
          'image': image,
          'lesson': history.lesson
        },
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              (history.level=='easy'?Colors.greenAccent:(history.level=='medium'?Colors.orangeAccent:Colors.redAccent)),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .07),
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            // gambar
            Hero(
              tag: "${history.id}-img",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // judul
            Expanded(
              child: Text(
                history.lesson.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
                softWrap: true,
                maxLines: 2,
              ),
            ),

            const SizedBox(width: 10),

            // score badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_fire_department_sharp,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    history.point.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



