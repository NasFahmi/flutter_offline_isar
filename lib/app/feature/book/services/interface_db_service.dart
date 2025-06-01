abstract class InterfaceDbService<T> {
  Future<List<T>> getAllData();
  Future<T?> getDataById(int id);
  Future<void> createData(T data);
  Future<void> updateData(T data);
  Future<void> saveData(List<T> data);
  Future<void> clearData();

}
