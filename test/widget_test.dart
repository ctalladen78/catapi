// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tiffany_cat/main.dart';
import 'package:tiffany_cat/cat_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  testWidgets('Test streambuilder', (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');
    String _uriGif = dotenv.env["URI_GIF"].toString();
    String _uriStatic = dotenv.env["URI_STATIC"].toString();
    CatApi catApi = CatApi(_uriGif, _uriStatic);
    Widget image = catApi.getImage();
    await tester.pumpWidget(image);
    await tester.pump(Duration.zero);
    Widget mockWidget = Center(child:Image.network(_uriStatic));
    expect(find.byWidget(mockWidget), findsOneWidget);
  });

  test('Test api key not null', () async{
    await dotenv.load(fileName: '.env');
    String _uriGif = dotenv.env["URI_GIF"].toString();
    String _uriStatic = dotenv.env["URI_STATIC"].toString();
    expect(_uriGif, "https://cataas.com/c/gif");
    expect(_uriStatic, "https://cataas.com/cat");
  });
}
