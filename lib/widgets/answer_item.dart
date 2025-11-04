import 'package:flutter/material.dart';

class AnswerItem extends StatelessWidget {
  final VoidCallback onTap;
  final String answer;
  final String order;
  final bool isTrue;
  final bool isEnable;
  const AnswerItem({
    super.key,
    required this.answer,
    required this.order,
    required this.onTap,
    required this.isTrue,
    required this.isEnable
  });

  @override
  Widget build(BuildContext context,) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isTrue ? Colors.greenAccent : Colors.white12,
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 8),
              blurRadius: 10
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // -------- ORDER --------
            Text('$order.', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isTrue ? Colors.black : Colors.white
            ),),
            const SizedBox(width: 10,),
            // -------- ANSWER --------
            Flexible(
              child: Text(
                answer,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isTrue ? Colors.black : Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
