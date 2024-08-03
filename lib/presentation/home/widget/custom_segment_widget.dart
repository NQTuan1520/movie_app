import 'package:flutter/cupertino.dart';

class CustomSegmentedControl extends StatelessWidget {
  final String selectedSegment;
  final Function(String) onSegmentChanged;

  const CustomSegmentedControl({super.key, 
    required this.selectedSegment,
    required this.onSegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(
      children: const {
        'day': Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Day'),
        ),
        'week': Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Week'),
        ),
      },
      onValueChanged: onSegmentChanged,
      groupValue: selectedSegment,
    );
  }
}
