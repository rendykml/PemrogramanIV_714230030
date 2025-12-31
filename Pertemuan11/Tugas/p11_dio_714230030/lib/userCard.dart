import 'package:flutter/material.dart';
import 'user.dart';

class UserCard extends StatelessWidget {
  final UserCreate userCreate;
  final bool isUpdate;

  const UserCard({super.key, required this.userCreate, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isUpdate ? Colors.orange[300] : Colors.lightBlue[200],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 70,
                child: Text(
                  'ID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 220, child: Text(': ${userCreate.id}')),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 70,
                child: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 220, child: Text(': ${userCreate.name}')),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 70,
                child: Text(
                  'Job',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 220, child: Text(': ${userCreate.job}')),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  isUpdate ? 'Updated At' : 'Created At',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  ': ${isUpdate ? userCreate.updatedAt : userCreate.createdAt}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
