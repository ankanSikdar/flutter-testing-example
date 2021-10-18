import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screens/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widgets Test', () {
    testWidgets('Test if ListView shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      var totalItems = widgetTester.widgetList(find.byIcon(Icons.close)).length;
      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pumpAndSettle();
      expect(widgetTester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
