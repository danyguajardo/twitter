//
//  Tweet.m
//  twitter
//
//  Created by danyguajiba on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self){
    // retweet caregory starts here
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
    
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        
        // TODO: initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        // TODO: Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        
        //convert string to date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        // Here I will begin to convert time tweeted to time ago relative to now
        [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
        NSDate *newDate = [formatter dateFromString:createdAtOriginalString];
        NSDate *today = [NSDate date];
        double time = [newDate timeIntervalSinceDate:today];
        time *= -1;
        
        if (time < 60) {
            int diff = time;
            self.createdAtString = [NSString stringWithFormat:@"%ds", diff];
        } else if (time < 3600) {
            int diff = round(time / 60);
            self.createdAtString = [NSString stringWithFormat:@"%dm", diff];
        } else if (time < 86400) {
            int diff = round(time / 60 / 60);
            self.createdAtString = [NSString stringWithFormat:@"%dh", diff];
        } else if (time < 2629743) {
            int diff = round(time / 60 / 60 / 24);
            self.createdAtString = [NSString stringWithFormat:@"%dd", diff];
        } else {
            self.createdAtString = [formatter stringFromDate:date];
        }
    }
    // convertion ends
    return self;
    
}


// this returns an array of tweet dictionaries,
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end

