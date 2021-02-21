// import 'package:twitter_clone/models/tweet_model.dart';

// import 'get_tweets_service_base.dart';
// import 'service_base.dart';

// class GetTweetsService extends ServiceBase implements GetTweetsServiceBase {

//   @override
//   Future<List<TweetModel>> getTweets() async {
//     var ref = await firestore.collection("tweet").get();

//     var tweets = ref.docs.map(
//       (doc) => TweetModel.fromMap(doc.data()),
//     );

//     return List<TweetModel>.from(tweets);
//   }

// }
