import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:ferbsystem/src/services/api.dart';

class Wishlist {
  final int id;
  final String name;
  final String description;
  final String value;

  Wishlist({this.id, this.name, this.description, this.value});

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      value: json['value'],
    );
  }
}

Future<List<Wishlist>> fetchDataHttp() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    'https://ferbs89.herokuapp.com/api/users/1/wishlist',
    headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Wishlist.fromJson(item)).toList();

  } else {
    throw Exception(json.decode(response.body));
  }
}

Future<List<Wishlist>> fetchData() async {
  final api = new Api();

  Response response = await api.dio.get("/users/1/wishlist");
  List data = response.data;

  return data.map((item) => new Wishlist.fromJson(item)).toList();
}