import 'package:radio_umsu/common/entities/music_entities.dart';
import 'package:radio_umsu/common/utils/http_utils.dart';

class MusicApi {
  static Future<ResponseApi<List<RadioConfig>>> getRadioConfig() async {
    var response = await HttpUtil().get('radio/config');

    return ResponseApi<List<RadioConfig>>.fromJson(
      response,
      (data) => (data as List).map((x) => RadioConfig.fromJson(x)).toList(),
    );
  }
}
