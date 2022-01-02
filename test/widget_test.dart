// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:themoviedb/main.dart';
import 'package:themoviedb/services/movies_client.dart';

void main() {
  NetworkClient client = NetworkClient();
  group("Network client testing", () {
    test("Testing discovery fetch", () {
      client.fetchDiscover(
        onSuccess: (movies) {
          if (movies != null) {
            for (var element in movies) {
              debugPrint("${element.id}: ${element.originalTitle}");
            }
          }
        },
        onError: (error) {
          debugPrint("$error");
        },
      );
    });
  });
}
