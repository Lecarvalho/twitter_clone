# Feed

Feed is a independent collection that is used to list someone's feed (concerned) on the screen.  
So when someone creates a new tweet, it creates an entry in feed collection for each follower of this person.  
When a follower opens the app, he / whe will see the tweets based on the feed collection. 

The reactions (retweet, like) are also an entry on the feed collection.

## Associative relationship

It is a relationship between many concerned and many tweets:

| TweetId   | ProfileId | 
| :---      | :---      |
| 1         | 35        |
| 1         | 36        |
| 1         | 37        |
...

In this case, the id is composed that way:

1_35  
1_36  
1_37  

It means that one feed entry is **a tweet reference for just one concerned**.

Just to not has a duplicated tweet in the feed, all reactions on a specific tweet is replacing the previous feed registry.

So let's check the life cycle of a feed:  
 
1. Someone create's a tweet one entry per follower is created on the feed collection. Also one entry is created for the creator too.
2. Someone else reacts the tweet (like or retweet): for each follower of the person who reacts the tweet:
    2.1. If there's no feed entry for the specific follower, one entry is created with the reaction.
    2.2. If there's already an entry for the specific follower, the entry is updated with the reaction.
3. If someone else (or even the same person) react again the same tweet: the previous feed is replaced for the new one for each follower
... and so on
4. If a person who reacted undoes the react: remove the feed entry (if there exists) for each follower.

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

***reactedByProfileName***
- **Type:** String
- **Definition:** The name of the person who reacted (like, retweet) the tweet.

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

## Like a tweet

When someone likes a tweet, what happens to feed collection:  
One entry is created *or updated* for each follower on feed collection with:
- **key:** tweetId_profileId where profileId is the follower profile id
- **concernedProfileId:** the profile id of the follower
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above
- **reactedByProfileId:** see definition above
- **reactedByProfileName:** see definition above
- **reactionType:** like

## Unlike a tweet

When someone unlikes a tweet, what happens to feed collection:  
It is basically the undo of the previous action, one entry is removed for each follower on feed collection where:  
> **concernedProfileId** == follower profile id *and*  
> **tweetId** == tweetId *and*  
> **reactedByProfileId** == profile id from the person who is unliking the tweet *and*  
> **reactionType** == like  

## Retweet

When someone retweets a tweet, what happens to feed collection:  
One entry is created for each follower on feed collection with:
- **key:** tweetId_profileId where profileId is the follower profile id
- **concernedProfileId:** the profile id of the follower
- **createdAt:** see definition above
- **creatorTweetProfileId** see definition above
- **tweetId:** see definition above
- **reactedByProfileId:** see definition above
- **reactedByProfileName:** see definition above
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