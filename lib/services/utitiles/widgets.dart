import 'package:flutter/material.dart';

class ReuseableRow extends StatelessWidget {
  final String title, data;
  const ReuseableRow({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * .02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(data)],
          )
        ],
      ),
    );
  }
}
