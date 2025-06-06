import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: 13,),
              Text(text, style: TextStyle(fontWeight: FontWeight.bold,),),
            ],
          ),
        ),
      ),
    );
  }
}