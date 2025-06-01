import 'package:isar/isar.dart';
import 'package:offline_mode/app/database/database_service.dart';
import 'package:offline_mode/app/feature/book/services/interface_db_service.dart';

import '../models/book_model.dart';

class BookDbService implements InterfaceDbService<BookModel> {

  
  @override
  Future<void> clearData() async{
     await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookModels.clear();
    });
  }
  
  @override
  Future<void> createData(BookModel data)async {
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookModels.put(data);
    });
  }
  
  @override
  Future<List<BookModel>> getAllData()async {
    return await DatabaseService.db.bookModels.where().findAll();
  }
  
  @override
  Future<BookModel?> getDataById(int id) async{
    return await DatabaseService.db.bookModels.get(id);
  }
  
  @override
  Future<void> saveData(List<BookModel> data) async{
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookModels.putAll(data);
    });
  }
  
  @override

  Future<void> updateData(BookModel data) async{
    await DatabaseService.db.writeTxn(() async {
      await DatabaseService.db.bookModels.put(data);
    });
  }
}
