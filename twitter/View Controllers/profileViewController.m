//
//  profileViewController.m
//  twitter
//
//  Created by danyguajiba on 7/5/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

//#import "TimelineViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "profileViewController.h"
#import "APIManager.h"
#import "Tweet.h"


@interface profileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tweetView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageGrande;
@property (weak, nonatomic) IBOutlet UILabel *nameGrande;
@property (weak, nonatomic) IBOutlet UILabel *usernameGrande;

@end


@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.tweetView.dataSource = self;
    self.tweetView.delegate = self;
    
    [self fetchTweets];
    
}


- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getUsernameWithCompletion:^(NSString *username, NSError *error) {
        if (username) {
            NSLog(@"😎😎😎 Successfully got username");
            [[APIManager shared] getUserTimelineWithUsername:username withCompletion:^(NSArray *tweetsAPI, NSError *error) {
                if (tweetsAPI) {
                    self.tweets = [[NSMutableArray alloc] initWithArray:tweetsAPI];
                    
                    Tweet *tweetIndividual = [self.tweets objectAtIndex:0];
                    User *user = tweetIndividual.user;
                    self.usernameGrande.text = username;
                    [self.tweetView reloadData];
                }
            }];
            [self.tweetView reloadData];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    
    [cell setUpCell:tweet];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}



@end




