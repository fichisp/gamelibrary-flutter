// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _GameBean implements Bean<Game> {
  final id = IntField('id');
  final title = StrField('title');
  final completed = BoolField('completed');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        title.name: title,
        completed.name: completed,
      };
  Game fromMap(Map map) {
    Game model = Game();
    model.id = adapter.parseValue(map['id']);
    model.title = adapter.parseValue(map['title']);
    model.completed = adapter.parseValue(map['completed']);

    return model;
  }

  List<SetColumn> toSetColumns(Game model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(title.set(model.title));
      ret.add(completed.set(model.completed));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(title.name)) ret.add(title.set(model.title));
      if (only.contains(completed.name))
        ret.add(completed.set(model.completed));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.title != null) {
        ret.add(title.set(model.title));
      }
      if (model.completed != null) {
        ret.add(completed.set(model.completed));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(title.name, isNullable: false);
    st.addBool(completed.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Game model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Game newModel;
      if (model.platforms != null) {
        newModel ??= await find(model.id);
        for (final child in model.platforms) {
          await platformBean.insert(child, cascade: cascade);
          await platformGameBean.attach(child, newModel);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Game> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = models
          .map((model) =>
              toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(Game model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    var retId;
    if (isForeignKeyEnabled) {
      final Insert insert = Insert(tableName, ignoreIfExist: true)
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.insert(insert);
      if (retId == null) {
        final Update update = updater
            .where(this.id.eq(model.id))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Game newModel;
      if (model.platforms != null) {
        newModel ??= await find(model.id);
        for (final child in model.platforms) {
          await platformBean.upsert(child, cascade: cascade);
          await platformGameBean.attach(child, newModel, upsert: true);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Game> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    if (cascade || isForeignKeyEnabled) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model,
            cascade: cascade, isForeignKeyEnabled: isForeignKeyEnabled));
      }
      await Future.wait(futures);
      return;
    } else {
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
  }

  Future<int> update(Game model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Game newModel;
      if (model.platforms != null) {
        for (final child in model.platforms) {
          await platformBean.update(child,
              cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Game> models,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Game> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Game model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, {bool cascade = false}) async {
    if (cascade) {
      final Game newModel = await find(id);
      if (newModel != null) {
        await platformGameBean.detachGame(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Game> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Game> preload(Game model, {bool cascade = false}) async {
    model.platforms = await platformGameBean.fetchByGame(model);
    return model;
  }

  Future<List<Game>> preloadAll(List<Game> models,
      {bool cascade = false}) async {
    for (Game model in models) {
      var temp = await platformGameBean.fetchByGame(model);
      if (model.platforms == null)
        model.platforms = temp;
      else {
        model.platforms.clear();
        model.platforms.addAll(temp);
      }
    }
    return models;
  }

  PlatformGameBean get platformGameBean;

  PlatformBean get platformBean;
}
