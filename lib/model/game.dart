import 'dart:async';
import 'package:gamelibrary2/model/platform.dart';
import 'package:gamelibrary2/model/platformgame.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
// import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

import 'platform.dart';
import 'platformgame.dart';
part 'game.jorm.dart';

// The model
class Game {
  Game();

  Game.make(this.id, this.title, this.completed, this.platforms);

  @PrimaryKey()
  int id;

  @Column(isNullable: false)
  String title;

  @Column(isNullable: true)
  bool completed;

  @ManyToMany(PlatformGameBean, PlatformBean)
  List<Platform> platforms;

  String toString() =>
      'Game(id: $id, title: $title, completed: $completed, platforms: $platforms)';
}

@GenBean()
class GameBean extends Bean<Game> with _GameBean {
  GameBean(Adapter adapter)
      : platformBean = PlatformBean(adapter),
        platformGameBean = PlatformGameBean(adapter),
        super(adapter);

  final PlatformBean platformBean;
  final PlatformGameBean platformGameBean;

  Future<int> updateCompletedField(int id, bool completed) async {
    Update st = updater.where(this.id.eq(id)).set(this.completed, completed);
    return adapter.update(st);
  }

  final String tableName = "games";
}
