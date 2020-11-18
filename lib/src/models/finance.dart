import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:ferbsystem/src/services/api.dart';

class Finance {
  final int id;
  final String description;
  final String type;
  final String value;

  Finance({this.id, this.description, this.type, this.value});

  factory Finance.fromJson(Map<String, dynamic> json) {
    return Finance(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      value: json['value'],
    );
  }
}

Future<List<Finance>> fetchDataHttp() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    'https://ferbs89.herokuapp.com/api/users/1/finances',
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Finance.fromJson(item)).toList();

  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<List<Finance>> fetchData() async {
  final api = new Api();

  Response response = await api.dio.get("/users/1/finances");
  List data = response.data;

  return data.map((item) => new Finance.fromJson(item)).toList();
}