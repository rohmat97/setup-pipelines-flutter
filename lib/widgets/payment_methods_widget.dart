import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentMethodsWidget extends StatelessWidget {
  const PaymentMethodsWidget({Key? key, required this.name, required this.paths, required this.onTap, required this.selectedIndex,}) : super(key: key);

  final String name;
  final String paths;
  final VoidCallback onTap;
  final bool selectedIndex;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        selected: selectedIndex,
        selectedTileColor: Colors.blueAccent,
        selectedColor: Colors.white,
        leading: Image.asset(
          paths,
          fit: BoxFit.cover,
        ),
        title: Text(name),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}