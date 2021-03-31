import 'package:doalist/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String? title;

  const CustomCard({Key? key, this.title}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title: Text(this.title!,style: titleStyle,),
      ),
    );
  }

}