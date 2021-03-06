import 'package:test/test.dart';
import 'package:twitter_clone/models/as_tweet_model_base.dart';

main() {

  var now = DateTime.now();

  group("test all possibles short dates", () {
    test("1 day before", () {
      var aDayBefore = DateTime.now().subtract(Duration(days: 1));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(aDayBefore, now);

      expect(creationTimeAgo, "1d");
    });

    test("5 days before", () {
      var fiveDaysBefore = DateTime.now().subtract(Duration(days: 5));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(fiveDaysBefore, now);

      expect(creationTimeAgo, "5d");
    });

    test("1 hour before", () {
      var anHourBefore = DateTime.now().subtract(Duration(hours: 1));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(anHourBefore, now);

      expect(creationTimeAgo, "1h");
    });

    test("5 hours before", () {
      var fiveHoursBefore = DateTime.now().subtract(Duration(hours: 5));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(fiveHoursBefore, now);

      expect(creationTimeAgo, "5h");
    });

    test("1 minute before", () {
      var aMinuteBefore = DateTime.now().subtract(Duration(minutes: 1));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(aMinuteBefore, now);

      expect(creationTimeAgo, "1m");
    });

    test("5 minutes before", () {
      var fiveMinutesBefore = DateTime.now().subtract(Duration(minutes: 5));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(fiveMinutesBefore, now);

      expect(creationTimeAgo, "5m");
    });

    test("30 seconds before", () {
      var fiveMinutesBefore = DateTime.now().subtract(Duration(seconds: 30));

      var creationTimeAgo = AsTweetModelBase.getTimeAgoToNow(fiveMinutesBefore, now);

      expect(creationTimeAgo, "30s");
    });
  });
}
