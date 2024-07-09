import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GPTResponse {
Future<Map<String, String?>> askQuestion(String? input) async {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String X='';
  String responseText = '';

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $X',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": 'HELLO AI, '
              '${input}',
            },],}),);

      if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final responseContent = responseBody['choices'][0]['message']['content'];
      // Accessing nested keys
      //final Map<String, dynamic> contentJson = jsonDecode(responseContent);
      // final String? DestPlacegpt = contentJson['DESTINATION PLACE'];
        responseText = responseContent;

        //RETURN the responseText
              return {'responseText': responseText};

    } else {
          responseText = 'Error: ${response.statusCode}';

        }
      

        //IF ANY ERROR OCCURS RETURN NULL VALUES
        return {'responseText': responseText};
}}



