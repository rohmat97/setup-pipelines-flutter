import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SeatPassengerCard extends StatelessWidget {
  const SeatPassengerCard({Key? key, this.name, this.seatClass, this.seatNum, required this.onTap, this.color}) : super(key: key);

  final String? name;
  final String? seatClass;
  final String? seatNum;
  final VoidCallback? onTap;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Card(
          shape: RoundedRectangleBorder(  
            borderRadius: BorderRadius.circular(10.0),  
          ),
          color: color,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '$name',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '$seatClass',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    '$seatNum',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}