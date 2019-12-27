// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platformgame.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PlatformGameBean implements Bean<PlatformGame> {
  final gameId = IntField('game_id');
  final platformId = IntField('platform_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        gameId.name: gameId,
        platformId.name: platformId,
      };
  PlatformGame fromMap(Map map) {
    PlatformGame model = PlatformGame();
    model.gameId = adapter.parseValue(map['game_id']);
    model.platformId = adapter.parseValue(map['platform_id']);

    return model;
  }

  List<SetColumn> toSetColumns(PlatformGame model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(gameId.set(model.gameId));
      ret.add(platformId.set(model.platformId));
    } else if (only != null) {
      if (only.contains(gameId.name)) ret.add(gameId.set(model.gameId));
      if (only.contains(platformId.name))
        ret.add(platformId.set(model.platformId));
    } else /* if (onlyNonNull) */ {
      if (model.gameId != null) {
        ret.add(gameId.set(model.gameId));
      }
      if (model.platformId != null) {
        ret.add(platformId.set(model.platformId));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(gameId.name,
        foreignTable: gameBean.tableName,
        foreignCol: gameBean.id.name,
        isNullable: false);
    st.addInt(platformId.name,
        foreignTable: platformBean.tableName,
        foreignCol: platformBean.id.name,
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PlatformGame model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<PlatformGame> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PlatformGame model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<PlatformGame> models,
      {bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<PlatformGame> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<PlatformGame>> findByGame(int gameId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.gameId.eq(gameId));
    return findMany(find);
  }

  Future<List<PlatformGame>> findByGameList(List<Game> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Game model in models) {
      find.or(this.gameId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByGame(int gameId) async {
    final Remove rm = remover.where(this.gameId.eq(gameId));
    return await adapter.remove(rm);
  }

  void associateGame(PlatformGame child, Game parent) {
    child.gameId = parent.id;
  }

  Future<int> detachGame(Game model) async {
    final dels = await findByGame(model.id);
    if (dels.isNotEmpty) {
      await removeByGame(model.id);
      final exp = Or();
      for (final t in dels) {
        exp.or(platformBean.id.eq(t.platformId));
      }
      return await platformBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Platform>> fetchByGame(Game model) async {
    final pivots = await findByGame(model.id);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(platformBean.id.eq(t.platformId));
    }
    return await platformBean.findWhere(exp);
  }

  Future<List<PlatformGame>> findByPlatform(int platformId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.platformId.eq(platformId));
    return findMany(find);
  }

  Future<List<PlatformGame>> findByPlatformList(List<Platform> models,
      {bool preload = false, bool cascade = false}) async {
// Return if models is empty. If this is not done, all the records will be returned!
    if (models == null || models.isEmpty) return [];
    final Find find = finder;
    for (Platform model in models) {
      find.or(this.platformId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByPlatform(int platformId) async {
    final Remove rm = remover.where(this.platformId.eq(platformId));
    return await adapter.remove(rm);
  }

  void associatePlatform(PlatformGame child, Platform parent) {
    child.platformId = parent.id;
  }

  Future<int> detachPlatform(Platform model) async {
    final dels = await findByPlatform(model.id);
    if (dels.isNotEmpty) {
      await removeByPlatform(model.id);
      final exp = Or();
      for (final t in dels) {
        exp.or(gameBean.id.eq(t.gameId));
      }
      return await gameBean.removeWhere(exp);
    }
    return 0;
  }

  Future<List<Game>> fetchByPlatform(Platform model) async {
    final pivots = await findByPlatform(model.id);
// Return if model has no pivots. If this is not done, all records will be removed!
    if (pivots.isEmpty) return [];
    final exp = Or();
    for (final t in pivots) {
      exp.or(gameBean.id.eq(t.gameId));
    }
    return await gameBean.findWhere(exp);
  }

  Future<dynamic> attach(Platform one, Game two, {bool upsert = false}) async {
    final ret = PlatformGame();
    ret.platformId = one.id;
    ret.gameId = two.id;
    if (!upsert) {
      return insert(ret);
    } else {
      return this.upsert(ret);
    }
  }

  GameBean get gameBean;
  PlatformBean get platformBean;
}
