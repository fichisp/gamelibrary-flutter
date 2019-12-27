import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'game.dart';
import 'platformgame.dart';

part 'platform.jorm.dart';

// The model
class Platform {
  Platform();

  Platform.make(this.id, this.name);

  @PrimaryKey()
  int id;

  @Column(isNullable: true)
  String name;

  @ManyToMany(PlatformGameBean, GameBean)
  List<Game> posts;
}

@GenBean()
class PlatformBean extends Bean<Platform> with _PlatformBean {
  PlatformBean(Adapter adapter) : super(adapter);

  PlatformGameBean _platformGameBean;
  GameBean _gameBean;

  GameBean get gameBean {
    _gameBean ??= new GameBean(adapter);
    return _gameBean;
  }

  PlatformGameBean get platformGameBean {
    _platformGameBean ??= new PlatformGameBean(adapter);
    return _platformGameBean;
  }

  final String tableName = 'platforms';
}