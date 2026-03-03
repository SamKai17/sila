import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  const InformationCard(
      {super.key, required Map<String, String> this.information});
  final Map<String, String> information;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      // color: AppPallete.surface,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
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
            ).toList()
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Client'),
            //     Text('Oussama'),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Paid'),
            //     Text(''),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Total items'),
            //     Text(''),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Total'),
            //     Text(''),
            //   ],
            // ),
            ),
      ),
    );
  }
}
