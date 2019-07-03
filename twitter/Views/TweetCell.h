//
//  TweetCell.h
//  twitter
//
//  Created by danyguajiba on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UIImageView *repliesImage;
@property (weak, nonatomic) IBOutlet UIImageView *directMessageImage;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *repliesLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (strong, nonatomic) Tweet *tweet;

-(void)setUpCell: (Tweet *) tweet;

@end

NS_ASSUME_NONNULL_END
