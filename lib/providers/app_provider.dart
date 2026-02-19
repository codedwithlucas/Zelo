import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/record.dart';

class RecordsNotifier extends StateNotifier<List<CareRecord>> {
  RecordsNotifier() : super([]) {
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = prefs.getStringList('records') ?? [];
    state = recordsJson.map((e) => CareRecord.fromJson(jsonDecode(e))).toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addRecord(CareRecord record) async {
    state = [record, ...state];
    _saveRecords();
  }

  Future<void> deleteRecord(String id) async {
    state = state.where((r) => r.id != id).toList();
    _saveRecords();
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsJson = state.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('records', recordsJson);
  }
}

final recordsProvider =
    StateNotifierProvider<RecordsNotifier, List<CareRecord>>((ref) {
      return RecordsNotifier();
    });
