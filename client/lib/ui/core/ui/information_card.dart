import 'package:client/ui/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
    required Map<String, String> this.information,
    bool this.isSelected = false,
    bool this.selectedMode = false,
  });
  final Map<String, String> information;
  final bool isSelected;
  final bool selectedMode;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      color: isSelected ? AppPallete.selectedBackground : AppPallete.surface,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          spacing: 10.0,
          children: [
            if (selectedMode)
              Icon(
                isSelected
                    ? Icons.check_box
                    : Icons.check_box_outline_blank_outlined,
              ),
            Expanded(
              child: Column(
                  spacing: 12.0,
                  children: information.entries.map(
                    (e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key),
                          Text(e.value),
                        ],
                      );
                    },
                  ).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
