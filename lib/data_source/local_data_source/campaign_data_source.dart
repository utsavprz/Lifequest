import 'package:lifequest/helper/object_box.dart';
import 'package:lifequest/models/campaign.dart';
import 'package:lifequest/state/objectbox_state.dart';

class CampaignDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  // Future<List<int>> addCampaigns(List<Campaign> campaignlst) async {
  //   try {
  //     return objectBoxInstance.addCampaigns(campaignlst);
  //   } catch (e) {
  //     return [];
  //   }
  // }
  Future<List<int>> addCampaigns(List<Campaign> camaignlst) async {
    try {
      // Get the list of users from ObjectBox
      final campaignList = await getAllCampaigns();

      // Filter the donors list to exclude the users already in ObjectBox
      final newCampaigns = camaignlst
          .where((existingCampaign) => !campaignList
              .any((campaign) => campaign.id == existingCampaign.id))
          .toList();

      // Add the new donors to ObjectBox
      return objectBoxInstance.addCampaigns(newCampaigns);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Campaign>> getAllCampaigns() async {
    try {
      return objectBoxInstance.getAllCampaigns();
    } catch (e) {
      return [];
    }
  }
}
