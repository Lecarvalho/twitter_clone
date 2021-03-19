import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/models/model_base.dart';
import 'service_provider_base.dart';

class DatabaseProvider extends ServiceProviderBase {
  late FirebaseFirestore firestore;
  late Collections collections;

  @override
  Future<void> init() async {
    firestore = FirebaseFirestore.instance;
    collections = Collections(firestore);
  }
}

class Collections {
  FirebaseFirestore _firestore;
  Collections(this._firestore);

  /// Collection with all the profiles. ProfileId is the key
  CollectionReference get profiles => _firestore.collection('profiles');

  /// Collection with all the tweets. TweetId is the key
  CollectionReference get tweets => _firestore.collection('tweets');

  /// Collection with all the profiles ids that a user is following. ProfileId is the key
  CollectionReference get following => _firestore.collection('following');

  /// Collection with all the profiles ids that follows a user. ProfileId is the key
  CollectionReference get followers => _firestore.collection("followers");

  /// Collection with all the tweetIds for profilesIds (many to many) so we can catch the tweetId where
  /// profileId = mine then finally get the tweets. 
  /// 
  /// The key is tweetId_concernedProfileId_reactionType
  /// 
  /// document fields:
  /// 
  /// - concernedProfileId
  /// - createdAt
  /// - creatorTweetProfileId
  /// - tweetId
  /// - reactedByProfileId
  /// - reactionType
  CollectionReference get feed => _firestore.collection("feed");
  
  /// A like or a retweet. The key is tweetId_reactedByProfileId.
  /// 
  /// document fields:  
  /// 
  /// - createdAt: the date where the tweet was reacted.
  /// - reactionType: like or retweet
  /// - tweetId
  /// - reactedByProfileId
  CollectionReference get reactions => _firestore.collection("reactions");

  static Map<String, dynamic> parseDataToPrimitiveTypes(
      Map<String, dynamic> firebaseData) {
    if (firebaseData[Fields.createdAt] != null) {
      firebaseData[Fields.createdAt] =
          firebaseData[Fields.createdAt].toDate().toString();
    }

    return firebaseData;
  }

  String toReactionKey(String tweetId, String reactedByProfileId, String reactionType) => "${tweetId}_${reactedByProfileId}_$reactionType";
  String toFeedKey(String tweetId, String concernedProfileId) => "${tweetId}_$concernedProfileId";
  
}

class Fields {
  Fields._();
  static String get id => "id";
  static String get profileId => "profileId";
  static String get likeCount => "likeCount";
  static String get retweetCount => "retweetCount";
  static String get tweetId => "tweetId";
  static String get concernedProfileId => "concernedProfileId";
  static String get creatorTweetProfileId => "creatorTweetProfileId";
  static String get followingCount => "followingCount";
  static String get followerCount => "followerCount";
  static String get reactionType => "reactionType";
  static String get reactedByProfileName => "reactedByProfileName";
  static String get reactedByProfileId => "reactedByProfileId";
  static String get createdAt => "createdAt";
  static String get nameSearch => "nameSearch";
}

class ReactionTypes {
  ReactionTypes._();
  static const retweet = "retweet";
  static const like = "like";
}

extension DocQueryExtension on Query {
  Future<List<Model>> toModelList<Model extends ModelBase>(
      Function(Map<String, dynamic> data) fromMap) async {
    var snapshot = await this.get();
    var iterable = snapshot.docs.map((doc) {
      var data = doc.data()!;
      data.putIfAbsent(Fields.id, () => doc.id);
      return fromMap(Collections.parseDataToPrimitiveTypes(data));
    });
    return List<Model>.from(iterable);
  }

  Future<List<Map<String, dynamic>>>
      toMapList<Model extends ModelBase>() async {
    var snapshot = await this.get();
    return List.from(snapshot.docs.map(
      (doc) => Collections.parseDataToPrimitiveTypes(doc.data()!),
    ));
  }
}

extension DocumentRefExtension on DocumentReference {
  Future<Model?> toModel<Model extends ModelBase>(
    Function(Map<String, dynamic> data) fromMap,
  ) async {
    var data = await this.toMap();
    if (data == null) return null;

    data.putIfAbsent(Fields.id, () => this.id);

    return fromMap(Collections.parseDataToPrimitiveTypes(data));
  }

  Future<Map<String, dynamic>?> toMap() async {
    var snapshot = await this.get();
    var data = snapshot.data();
    return data;
  }
}

extension DistinctExtension on List {
  void distinct(Function(dynamic field) expression) {
    final uniqueFields = this.map(expression).toSet();

    this.retainWhere((myFeed) => uniqueFields.remove(myFeed[Fields.tweetId]));
  }
}
