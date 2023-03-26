import 'package:lifequest/app/network_connectivity.dart';
import 'package:lifequest/data_source/local_data_source/campaign_data_source.dart';
import 'package:lifequest/main.dart';
import 'package:lifequest/models/campaign.dart';
import 'package:lifequest/providers/campaign_provider.dart';
import '../data_source/remote_data_source/campaign_data_source.dart';

abstract class CampaignRepository {
  Future<List<Campaign>> getUserCampaign();
}

class CampaignRepositoryImpl extends CampaignRepository {
  @override
  Future<List<Campaign>> getUserCampaign() async {
    if (await NetworkConnectivity.isOnline()) {
      return CampaignRemoteDataSource().getUserCampaign();
    } else {
      List<Campaign> campaignLst = [];
      CampaignDataSource().getAllCampaigns().then((value) {
        container.read(campaignProvider.notifier).updateCampaignList(value);
        campaignLst = value;
      });
      return campaignLst;
    }
  }
}
