import 'package:al_ammari/Models/media_model.dart';
import 'api_provider.dart';

class Repository {
  final _apiProvider = ApiProvider();

  Future<MediaModel?> fetchArticle() async {
    return await _apiProvider.getArticle();
  }

  Future<MediaModel?> fetchBook() async {
    return await _apiProvider.getBook();
  }
  Future<MediaModel?> fetchVideo() async {
    return await _apiProvider.getVideo();
  }
  Future<MediaModel?> fetchAudio() async {
    return await _apiProvider.getAudio();
  }
  validateContact({data}) async {
    return await _apiProvider.validateContact(data: data);
  }
}