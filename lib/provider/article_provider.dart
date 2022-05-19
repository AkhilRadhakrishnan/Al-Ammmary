import 'package:al_ammari/Models/media_model.dart';
import 'package:flutter/material.dart';
import '../services/repository.dart';

class AllProvider with ChangeNotifier {
  final _repository = Repository();

  // ArticleModel? _article;
  // ArticleModel? get articles => _article;
  //
  // set articles(ArticleModel? articleModel) {
  //   _article = articleModel;
  //   notifyListeners();
  // }
  //
  // Future<void> fetchArticle() async {
  //   articles = await _repository.fetchArticle();
  //   notifyListeners();
  // }
  MediaModel? _media;
  MediaModel? get media => _media;

  set media(MediaModel? mediaModel) {
    _media = mediaModel;
    notifyListeners();
  }

  Future<void> fetchArticle() async {
    media = await _repository.fetchArticle();
    notifyListeners();
  }

  Future<void> fetchBook() async {
    media = await _repository.fetchBook();
    notifyListeners();
  }
  Future<void> fetchVideo() async {
    media = await _repository.fetchVideo();
    notifyListeners();
  }
  Future<void> fetchAudio() async {
    media = await _repository.fetchAudio();
    notifyListeners();
  }
  Future<void> validateContact() async {
    media =  await _repository.validateContact();
    notifyListeners();
  }
}