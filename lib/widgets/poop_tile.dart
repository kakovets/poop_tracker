import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../objects.dart';

class PoopTile extends StatelessWidget {
  const PoopTile({super.key, required Poop poop}) : _poop = poop;
  final Poop _poop;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text('Doggie pooped at: ${_getPoopTime()}.'),
            const SizedBox(height: 4,),
            Text('Mass was ${_poop.weight} kg and color was ${_poop.color}!'),
          ],
        ),
      ),
    );
  }

  String _getPoopTime() {
    String poopTime = DateFormat('yyyy-MM-dd – kk:mm').format(_poop.dateTime);
    return poopTime;
  }
}
