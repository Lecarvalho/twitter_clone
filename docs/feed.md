# Feed

Feed is a independent collection that is used to list someone's feed (concerned) on the screen.  
So when someone creates a new tweet, it creates an entry in feed collection for each follower of this person.  
When a follower opens the app, he / whe will see the tweets based on the feed collection. 

The reactions (retweet, like) are also an entry on the feed collection.

## Associative relationship

It means that one feed entry is **a tweet reference for just one concerned**.

~~Just to not has a duplicated tweet in the feed, all reactions on a specific tweet is flagging the new feed entry as "last".~~

It is duplicating right now, it's going to be fixed later.

## All possible fields:

***key***
- **Type:** String
- **Definition:** Is composed by tweetId + concernedProfileId. Aka: tweetId_concernedProfileId 

***concernedProfileId***
- **Type:** String
- **Definition:** The profile id from who is interested on this tweet. Aka: who is following the user who posted a tweet, or a user that is following someone that likes or retweeted a post (even if the original creator is not on the concerned list).

***createdAt***
- **Type:** DateTime
- **Definition:** The date where the feed was created (default will be the date where the tweet or reaction (like, retweeet) was created)

***creatorTweetProfileId***
- **Type:** String
- **Definition:** The profile id from the original tweet owner

***tweetId***
- **Type:** String
- **Definition:** The id of the tweet

***reactedByProfileId***
- **Type:** String
- **Definition:** The profile id from the person who reacted (like, retweet) the tweet.

***reactionType***
- **Type:** String
- **Definition:** The type of the tweet: "like" or "retweet"

## Create new Tweet

When someone creates a new tweet, what happens to feed collection:  
One entry is created for each follower on feed collection with:
- **key:** tweetId_profileId where profileId is the follower profile id
- **concernedProfileId:** the profile id of the follower
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above
- **last:** true

## Like a tweet

When someone likes a tweet, what happens to feed collection:  
~~The previous entry is updated and~~ an entry is created for each follower on feed collection with:
- **key:** tweetId_profileId where profileId is the follower profile id
- **concernedProfileId:** the profile id of the follower
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above
- **reactedByProfileId:** see definition above
- **reactionType:** like

## Unlike a tweet

When someone unlikes a tweet, what happens to feed collection:  
It removes the previous action for each follower on feed collection ~~and updates the previous one with the flag last = true~~:  
> **concernedProfileId** == follower profile id *and*  
> **tweetId** == tweetId *and*  
> **reactedByProfileId** == profile id from the person who is unliking the tweet *and*  
> **reactionType** == like  

## Retweet

When someone retweets a tweet, what happens to feed collection:  
~~The previous entry is updated and~~ an entry is created for each follower on feed collection with:
- **key:** tweetId_profileId where profileId is the follower profile id
- **concernedProfileId:** the profile id of the follower
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above
- **reactedByProfileId:** see definition above
- **reactionType:** retweet

## Follow someone else *(also known as "other")*

*Just to be easy to understand, will say "my or me" for the person who started the action to follow someone's else, and "other" the person who "me" is starting following.*

When someone follows someone's else, what happens to feed collection:  
Will create two entries on "*my*" feed from the "*other*" tweet (only if **key** doesn't already exists on the collection).

- **key:** tweetId_profileId where profileId is *my* profileId
- **concernedProfileId:** is *my* profileId
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above

## Unfollow 

When someone stop following someone's else, what happens to feed collection:  
**Nothing!**