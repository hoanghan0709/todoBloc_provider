import 'package:flutter_todo/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future setupLocator() async {
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  
}
