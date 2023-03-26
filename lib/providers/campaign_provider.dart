import 'package:lifequest/models/campaign.dart';
import 'package:riverpod/riverpod.dart';

final campaignProvider = StateNotifierProvider<CampaignState, List<Campaign>>(
  (ref) => CampaignState(),
);

class CampaignState extends StateNotifier<List<Campaign>> {
  CampaignState() : super([]);

  void updateCampaignList(List<Campaign> value) {
    state = value;
  }
}
