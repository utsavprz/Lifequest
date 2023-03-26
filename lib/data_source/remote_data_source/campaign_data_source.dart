import 'package:dio/dio.dart';
import 'package:lifequest/app/constants.dart';
import 'package:lifequest/data_source/remote_data_source/response/campaign_request_response.dart';
import 'package:lifequest/helper/http_service.dart';
import 'package:lifequest/helper/shared_preferences.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/campaign.dart';
import 'package:lifequest/providers/campaign_provider.dart';

class CampaignRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Campaign>> getUserCampaign() async {
    try {
      Response response =
          await _httpServices.get('${Constant.campaignURL}/get_user_campaigns',
              options: Options(
                headers: {
                  "Authorization":
                      "Bearer ${await SharedPref.getTokenFromPrefs()}",
                },
              ));

      if (response.statusCode == 200) {
        CampaignRequestResponse campaignRequestResponse =
            CampaignRequestResponse.fromJson(response.data);
        container
            .read(campaignProvider.notifier)
            .updateCampaignList(campaignRequestResponse.data!);

        // ? Campaign Request sent success
        return campaignRequestResponse.data!;
      } else {
        // ? Internal server error
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
