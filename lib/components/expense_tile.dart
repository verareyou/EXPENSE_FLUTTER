import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final int index;
  final String title;
  final String amount;
  final DateTime date;
  void Function(BuildContext)? deletedTapped;

  ExpenseTile(
      {super.key,
      required this.index,
      required this.title,
      required this.amount,
      required this.date,
      required this.deletedTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deletedTapped,
                icon: Icons.delete,
                backgroundColor: Color.fromARGB(255, 253, 87, 76),
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
          child: ListTile(
              textColor: Color.fromARGB(255, 49, 49, 49),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${date.day}/${date.month}/${date.year}'),
              trailing: Text('\$$amount')),
        ),
      ),
    );
  }
}
