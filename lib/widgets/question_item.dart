import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionItem extends StatelessWidget {
  final String title;
  final String image;
  final String route;
  final bool? isPopular;
  const QuestionItem({super.key, required this.title, required this.image, required this.route, this.isPopular = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>context.push(route),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .5),
              offset: Offset(0, 8),
              blurRadius: 8
            )
          ]
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(image),
              ),
            ),
            if (isPopular == true)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                      )
                  ),
                  child: Text('popular'.tr(), style:const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12
                  ),),
                ),
              ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  )
                ),
                child: Text(title.tr(), style:const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
