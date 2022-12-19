import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakala_app/models/wakala.dart';
import 'package:wakala_app/providers/wakala_provider.dart';

class WakalasScreen extends StatelessWidget{
  const WakalasScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {

    final WakalaProvider wakalaProvider = Provider.of<WakalaProvider>(context);
    int numberOfWakalas = wakalaProvider.listOfWakalas.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Wakalas')),
      backgroundColor: Colors.indigoAccent,
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: numberOfWakalas,
        itemBuilder: (BuildContext context, int index) {
          Wakala wakala = wakalaProvider.listOfWakalas[index];
          return getContainerItem(wakala);
        }
      ),
    );
  }

  Container getContainerItem(Wakala wakala){
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
          style: BorderStyle.solid
        ),
        color: Colors.grey,
      ),
      child: InkWell(
        onTap: () {
          log('Has hecho click en ${wakala.sector}');
        },

        child: Column(
          children: [
            Text("Fecha: ${wakala.sector}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              )
            ),

            Text("Fecha: ${wakala.autor}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              )
            ),

            Text("Fecha: ${wakala.fecha}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500
              )
            ),
          ],
        ),
      ),
    );
  }

}