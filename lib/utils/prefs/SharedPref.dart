
import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  String _FIRST_SYNC_COMPLETE = 'FIRST_SYNC_COMPLETE';
  String _LAST_SYNC_DATE = 'LAST_SYNC_DATE';
  String _MAX_TIMESTAMP = 'MAX_TIMESTAMP';

  var _pref = GetIt.instance<SharedPreferences>();
  SharedPreferences? _prefs = null;

  SharedPref() {
    this._prefs = _pref;
  }

  dynamic _getData(String key) {
    var value = _prefs?.get(key);
    return value;
  }

  void _saveData(String key, dynamic value) {
    if (value is String) {
      _prefs?.setString(key, value);
    } else if (value is int) {
      _prefs?.setInt(key, value);
    } else if (value is double) {
      _prefs?.setDouble(key, value);
    } else if (value is bool) {
      _prefs?.setBool(key, value);
    } else if (value is List<String>) {
      _prefs?.setStringList(key, value);
    }
  }

  bool get firstSyncComplete => _getData(_FIRST_SYNC_COMPLETE) ?? false;
       set firstSyncComplete(bool value) => _saveData(_FIRST_SYNC_COMPLETE, value);

  int get lastSyncTime => _getData(_LAST_SYNC_DATE) ?? '';
         set lastSyncTime(int value) => _saveData(_LAST_SYNC_DATE, value);

  int? get maxTimestamp => _getData(_MAX_TIMESTAMP);
         set maxTimestamp(int? value) => _saveData(_MAX_TIMESTAMP, value);
}