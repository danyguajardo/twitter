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

-(void)configureCell: (Tweet *)tweet {
    self.tweet = tweet;
    self.name.text = tweet.user.name;
    self.name.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.date.text = tweet.createdAtString;
    self.tweetContent.text = self.tweet.text;
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profileURL];
    
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweeted];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favorited];
}

@end
