// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'model/game.dart';
import 'model/platform.dart';
import 'model/platformgame.dart';

/// The adapter
SqfliteAdapter _adapter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sqflite.devSetDebugModeOn(true);
  var sb = StringBuffer();
  sb.writeln("Jaguar ORM showcase:");

  sb.writeln('--------------');
  sb.write('Connecting ...');
  var dbPath = await getDatabasesPath();
  _adapter = SqfliteAdapter(path.join(dbPath, "test.db"));

  try {
    await _adapter.connect();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    final gameBean = GameBean(_adapter);
    final platformBean = PlatformBean(_adapter);
    final platformGameBean = PlatformGameBean(_adapter);

    // Delete tables
    await gameBean.drop();
    await platformBean.drop();
    await platformGameBean.drop();

    sb.write('Creating table ...');
    await gameBean.createTable();
    await platformBean.createTable();
    await platformGameBean.createTable();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Delete all
    sb.write('Removing old rows (if any) ...');
    await gameBean.removeAll();
    sb.writeln(' successful!');
    sb.writeln('--------------');

    // Insert some games
    sb.writeln('Inserting sample rows ...');
    var game = new Game.make(1, 'Game 1', false, [
      new Platform.make(1, 'Platform 1'),
      new Platform.make(2, 'Platform 2')
    ]);
    int id1 = await gameBean.insert(game, cascade: true);
    sb.writeln(
        'Inserted successfully row with id: $id1 and one to many relation!');

    sb.writeln('--------------');

    // Find one post
    sb.writeln('Reading row with id $id1 with one to one relation...');
    Game game1 = await gameBean.find(id1, preload: true);
    sb.writeln(game1);
    sb.writeln('--------------');

    sb.writeln('Removing row with id $id1 ...');
    await gameBean.remove(id1);
    sb.writeln('--------------');

    sb.write('Closing the connection ...');
    await _adapter.close();
    sb.writeln(' successful!');
    sb.writeln('--------------');
  } finally {
    print(sb.toString());
  }

  runApp(SingleChildScrollView(
      child: Text(sb.toString(), textDirection: TextDirection.ltr)));
}
