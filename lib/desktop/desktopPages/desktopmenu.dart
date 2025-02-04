import 'package:flutter/cupertino.dart';

class Menus extends StatelessWidget {
  final String label;
  final Widget widgets;
  final String urlend;
  const Menus({super.key,
    required this.label,
    required this.widgets,
    required this.urlend
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${label}')
      ],
    );
  }
}
