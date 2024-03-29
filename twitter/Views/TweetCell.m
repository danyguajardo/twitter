//
//  TweetCell.m
//  twitter
//
//  Created by danyguajiba on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setUpCell: (Tweet *)tweet {
    self.tweet = tweet;
    self.name.text = tweet.user.name;
    self.username.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.date.text = tweet.createdAtString;
    self.tweetContent.text = self.tweet.text;

    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profileURL];
    
    [self refreshData];
}

- (IBAction)didTapFavorite:(id)sender {
    NSString *fav;
    self.tweet.favorited = !self.tweet.favorited;
    if(self.tweet.favorited){
        self.tweet.favoriteCount += 1;
        fav = @"create";
    }
    else{
        self.tweet.favoriteCount -= 1;
        fav = @"destroy";

    }
    
    [self refreshData];  //in order to refresh UI
    
    [[APIManager shared] favorite:self.tweet do: fav completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error %@ tweet: %@", fav, error.localizedDescription);
        }
        else{
            NSLog(@"Successfully %@ the following Tweet: %@", fav, tweet.text);
        }
    }];
    

}
- (IBAction)didTapRetweet:(id)sender {
    NSString *rt;
    self.tweet.retweeted = !self.tweet.retweeted;
    if(self.tweet.retweeted){
        self.tweet.retweetCount += 1;
        rt = @"retweet";
    }
    else{
        self.tweet.retweetCount -= 1;
        rt = @"unretweet";
    }

    [self refreshData]; //in order to refresh UI
    
    [[APIManager shared] retweet:self.tweet do: rt completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error %@ tweet: %@", rt, error.localizedDescription);
        }
        else{
            NSLog(@"Successfully %@ the following Tweet: %@", rt, tweet.text);
        }
    }];
}

- (void)refreshData {
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if (self.tweet.favorited){
        NSLog (@"Favorited");
        [self.favoriteButton setSelected: YES];
    }
    else{
        NSLog (@"Not Favorited");
        [self.favoriteButton setSelected: NO];
    }

    if (self.tweet.retweeted){
        [self.retweetButton setSelected: YES];
    }
    else{
        [self.retweetButton setSelected: NO];
    }

}

@end
