import 'package:flutter/cupertino.dart';

import '../core/cache_client.dart';

class LocalizationProvider with ChangeNotifier {
  String _local = "en";
  CacheClient _cacheClient = CacheClient();

  String get getLocal => _local;

  bool get isLTR => _local == "en";

  switchLocal(String local) async{
    _local = local;
  await  saveLocalToStorage(local);
    notifyListeners();
  }

  Future<String?> getLocalFromStorage() async {
    String? language =
        await _cacheClient.getString(CashClientKey.language);
    _local = language ??"en";
    notifyListeners();
    return language;
  }

  saveLocalToStorage(String local) async {
    await _cacheClient.putString(CashClientKey.language, local);
  }
}
