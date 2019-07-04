//
//  DetailsViewController.m
//  twitter
//
//  Created by danyguajiba on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Tweet *tweet = self.tweet;
    User *user = tweet.user;
    self.tweet = tweet;
    self.name.text = user.name;
    self.username.text = [@"@" stringByAppendingString:user.screenName];
    self.date.text = tweet.createdAtString;
    self.tweetContent.text = tweet.text;
    //convert integer value to strings to display on our cells
    NSString *retweetCount = [NSString stringWithFormat:@"%i",tweet.retweetCount];
    self.retweetLabel.text = retweetCount;
    NSString *favoriteCount = [NSString stringWithFormat:@"%i",tweet.favoriteCount];
    self.favoriteLabel.text = favoriteCount;

    [self.profilePicture setImageWithURL:user.profileURL];
    //set different images for different states of buttons
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];

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

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

