//
//  TweetCell.m
//  twitter
//
//  Created by danyguajiba on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

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
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    [self refreshData];
    // TODO: Update cell UI
    
    // TODO: Send a POST request to the POST favorites/create endpoint
}
- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    [self refreshData];
}

- (void)refreshData {
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if (self.tweet.favorited){
        [self.favoriteButton setSelected: YES];
    }
    else{
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
