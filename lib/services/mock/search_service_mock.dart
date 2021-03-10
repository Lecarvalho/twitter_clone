import 'package:twitter_clone/models/profile_model.dart';

import '../search_service_base.dart';
import 'mock_tools.dart';
import 'service_provider_mock.dart';

class SearchServiceMock extends SearchServiceBase {
  SearchServiceMock(ServiceProviderMock provider) : super(provider);

  @override
  Future<List<ProfileModel>?> searchProfiles(String searchTerm) async {
    var profiles = await MockTools.jsonToModelList<ProfileModel>(
      "assets/json/profiles.json",
      (data) => ProfileModel.fromBasicInfo(data),
    );

    await MockTools.simulateQuickRequestDelay();

    print(searchTerm);

    return profiles
        ?.where(
          (ProfileModel profile) =>
              profile.isProfileComplete &&
              (profile.name.toLowerCase().startsWith(searchTerm) ||
                  profile.nickname!.toLowerCase().startsWith(searchTerm)),
        )
        .toList();
  }
}
