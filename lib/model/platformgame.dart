import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'game.dart';
import 'platform.dart';

part 'platformgame.jorm.dart';

// The model
class PlatformGame {
  PlatformGame();

  @BelongsTo.many(GameBean)
  int gameId;

  @BelongsTo.many(PlatformBean)
  int platformId;
}

@GenBean()
class PlatformGameBean extends Bean<PlatformGame> with _PlatformGameBean {
  PlatformGameBean(Adapter adapter) : super(adapter);

  GameBean _gameBean;
  PlatformBean _platformBean;

  GameBean get gameBean {
    _gameBean ??= new GameBean(adapter);
    return _gameBean;
  }

  PlatformBean get platformBean {
    _platformBean ??= new PlatformBean(adapter);
    return _platformBean;
  }

  final String tableName = 'platformgame';
}