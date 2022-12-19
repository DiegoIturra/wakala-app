import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wakala_app/models/wakala.dart';

class WakalaProvider extends ChangeNotifier{

  List<Wakala> listOfWakalas = [];
  
  WakalaProvider(){
    getOnDisplayWakalas();
  }

  List<Wakala> _parseWakalas(String body){
    final parsedOutput = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsedOutput.map<Wakala>((json) => Wakala.fromJson(json)).toList();
  }

  getOnDisplayWakalas() async {
    const String getAllWakalasURL = 'https://d22292e4f79c.sa.ngrok.io/api/wuakalasApi/Getwuakalas';
    final response = await http.get(Uri.parse(getAllWakalasURL));

    if(response.statusCode == 200){
      listOfWakalas = _parseWakalas(response.body);
    }
  }

}