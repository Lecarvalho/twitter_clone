import 'package:test/test.dart';
import 'package:twitter_clone/models/tweet_model.dart';

main() {
  group("test all possibles short dates", () {
    test("1 day before", () {
      var aDayBefore = DateTime.now().subtract(Duration(days: 1));

      var tweetModel = TweetModel(creationDate: aDayBefore);

      expect(tweetModel.creationDateShort, "1d");
    });

    test("5 days before", () {
      var fiveDaysBefore = DateTime.now().subtract(Duration(days: 5));

      var tweetModel = TweetModel(creationDate: fiveDaysBefore);

      expect(tweetModel.creationDateShort, "5d");
    });

    test("1 hour before", () {
      var anHourBefore = DateTime.now().subtract(Duration(hours: 1));

      var tweetModel = TweetModel(creationDate: anHourBefore);

      expect(tweetModel.creationDateShort, "1h");
    });

    test("5 hours before", () {
      var fiveHoursBefore = DateTime.now().subtract(Duration(hours: 5));

      var tweetModel = TweetModel(creationDate: fiveHoursBefore);

      expect(tweetModel.creationDateShort, "5h");
    });

    test("1 minute before", () {
      var aMinuteBefore = DateTime.now().subtract(Duration(minutes: 1));

      var tweetModel = TweetModel(creationDate: aMinuteBefore);

      expect(tweetModel.creationDateShort, "1m");
    });

    test("5 minutes before", () {
      var fiveMinutesBefore = DateTime.now().subtract(Duration(minutes: 5));

      var tweetModel = TweetModel(creationDate: fiveMinutesBefore);

      expect(tweetModel.creationDateShort, "5m");
    });
  });
}
