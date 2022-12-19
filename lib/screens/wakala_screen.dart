import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wakala_app/models/wakala.dart';

class WakalaScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Wakala;

    return Scaffold(
      appBar: AppBar(title: Text(args.sector)),
    );
  }

}