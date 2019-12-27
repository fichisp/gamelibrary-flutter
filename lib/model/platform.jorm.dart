// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PlatformBean implements Bean<Platform> {
  final id = IntField('id');
  final name = StrField('name');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
      };
  Platform fromMap(Map map) {
    Platform model = Platform();
    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);

    return model;
  }

  List<SetColumn> toSetColumns(Platform model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.name != null) {
        ret.add(name.set(model.name));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(name.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Platform model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Platform newModel;
      if (model.posts != null) {
        newModel ??= await find(model.id);
        for (final child in model.posts) {
          await gameBean.insert(child, cascade: cascade);
          await platformGameBean.attach(newModel, child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Platform> models,
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

  Future<dynamic> upsert(Platform model,
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
      Platform newModel;
      if (model.posts != null) {
        newModel ??= await find(model.id);
        for (final child in model.posts) {
          await gameBean.upsert(child, cascade: cascade);
          await platformGameBean.attach(newModel, child, upsert: true);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Platform> models,
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

  Future<int> update(Platform model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    final ret = adapter.update(update);
    if (cascade) {
      Platform newModel;
      if (model.posts != null) {
        for (final child in model.posts) {
          await gameBean.update(child, cascade: cascade, associate: associate);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Platform> models,
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

  Future<Platform> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Platform model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(int id, {bool cascade = false}) async {
    if (cascade) {
      final Platform newModel = await find(id);
      if (newModel != null) {
        await platformGameBean.detachPlatform(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Platform> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Platform> preload(Platform model, {bool cascade = false}) async {
    model.posts = await platformGameBean.fetchByPlatform(model);
    return model;
  }

  Future<List<Platform>> preloadAll(List<Platform> models,
      {bool cascade = false}) async {
    for (Platform model in models) {
      var temp = await platformGameBean.fetchByPlatform(model);
      if (model.posts == null)
        model.posts = temp;
      else {
        model.posts.clear();
        model.posts.addAll(temp);
      }
    }
    return models;
  }

  PlatformGameBean get platformGameBean;

  GameBean get gameBean;
}
