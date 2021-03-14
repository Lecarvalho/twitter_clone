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

  /// Collection with the likes by tweet. TweetId is the key
  CollectionReference get likes => _firestore.collection('likes');

  CollectionReference get retweets => _firestore.collection('retweets');

  CollectionReference get following => _firestore.collection('following');

  CollectionReference get followers => _firestore.collection("followers");

  CollectionReference get feed => _firestore.collection("feed");

  DocumentReference getProfileRef(String profileId) {
    return profiles.doc(profileId);
  }

  Future<Map<String, dynamic>?> getProfileMap(String profileId) async {
    return (await getProfileRef(profileId).get()).data();
  }
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
  static String get profileName => "profileName";
  static String get reactedByProfileId => "reactedByProfileId";
}

class ReactionTypes {
  ReactionTypes._();
  static const retweet = "retweet";
  static const like = "like";
}

extension DocQueryExtension on Query {
  Future<List<Model>?> toModelList<Model extends ModelBase>(
    Function(Map<String, dynamic> data) fromMap,
  ) async {
    var snapshot = await this.get();
    var iterable = snapshot.docs.map((doc) => fromMap(doc.data()!));
    return List<Model>.from(iterable);
  }

  Future<List<Map<String, dynamic>>?>
      toMapList<Model extends ModelBase>() async {
    var snapshot = await this.get();
    return List.from(snapshot.docs.map((doc) => doc.data()!));
  }
}

extension DocSnapshotExtension on DocumentReference {
  Future<Model?> toModel<Model extends ModelBase>(
    Function(Map<String, dynamic> data) fromMap,
  ) async {
    var map = await this.toMap();
    if (map == null) return null;

    return fromMap(map);
  }

  Future<Map<String, dynamic>?> toMap() async {
    var snapshot = await this.toSnapshot();
    var map = snapshot.data();
    return map;
  }

  Future<DocumentSnapshot> toSnapshot() async {
    var document = this;
    var snapshot = await document.get();
    return snapshot;
  }
}