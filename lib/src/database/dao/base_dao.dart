import 'package:marcaii_flutter/src/database/models/model.dart';

abstract class BaseDao<M extends Model> {
  Future<List<M>> fetchAll();
  Future<M> fetchById(int id);
  Future<M> insert(M model);
  Future<void> update(M model);
  Future<void> delete(int i);
}
