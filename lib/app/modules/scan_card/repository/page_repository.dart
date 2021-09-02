import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/scanbot_sdk.dart';


class PageRepository {
  static final PageRepository _instance = PageRepository._internal();

  factory PageRepository() => _instance;

  PageRepository._internal() {
    // init some stuff here
  }

  final List<c.Page> _pages = <c.Page>[];
  final page = ''.val('page');

  List<c.Page> get pages => _pages.toList();

  Future<void> removePage(c.Page pageToRemove) async {
    _pages.remove(pageToRemove);
    await _storePages();
  }

  Future<void> addPages(List<c.Page> newPages) async {
    _pages.addAll(newPages);
    await _storePages();
  }

  Future<void> clearPages() async {
    _pages.clear();
    await _storePages();
  }

  Future<void> updatePage(c.Page page) async {
    _pages.removeWhere((e) => page.pageId == e.pageId);
    _pages.add(page);
    await _storePages();
  }

  Future<void> addPage(c.Page page) async {
    _pages.add(page);
    await _storePages();
  }

  Future<void> loadPages() async {
    final db = ReadWriteValue('pages', MyPref);
    var pagesJsonString = db.toString();
    if (pagesJsonString == null) {
      return;
    }
    List<dynamic> pagesJson = jsonDecode(pagesJsonString);
    final loadedPages = pagesJson
        .map((p) => c.Page.fromJson(p as Map<String, dynamic>))
        .toList();
    _pages.clear();
    if (loadedPages.isNotEmpty) {
      var refreshPages = await ScanbotSdk.refreshImageUris(loadedPages);
      _pages.addAll(refreshPages);
    }
  }

  Future<void> _storePages()  async {
    final db = Get.find<MyPref>().page;
    return db.printInfo();
  }

}

class MyPref {
  static final box = () => GetStorage('MyPref');

  final page = ReadWriteValue("page", box);
  final storageDirectory = ReadWriteValue("storageDirectory", box);
  final extStorageDirectory = ReadWriteValue("extStorageDirectory", box);

}