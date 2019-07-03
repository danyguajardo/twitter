//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface TimelineViewController ()<ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
    @property (strong, nonatomic) NSMutableArray *tweets;
    @property (weak, nonatomic) IBOutlet UITableView *tweetView;
    @property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// getting data from view controller
    self.tweetView.dataSource = self;
    self.tweetView.delegate = self;
//    self.tweetView.rowHeight = 180;
    self.tweets = [[NSMutableArray alloc] init];  //initialize tweet arrays
    
    [self fetchTweets];
    
    
    // initialize UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    // bind action to refresh control
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tweetView insertSubview:self.refreshControl atIndex:0];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // gets cell
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    //  this will help us link each individual tweet with corresponding cell
    Tweet *tweet = self.tweets[indexPath.row];
    [cell setUpCell:tweet];
    return cell;
}

// Makes a network request to get updated data and updates the tableView with the new data
// In this function we begin to get data and set timeline
- (void) fetchTweets {
    // load timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [[NSMutableArray alloc] initWithArray:tweets];
            
            [self.tweetView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            [self.tweetView reloadData];
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



- (void)didTweet:(nonnull Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tweetView reloadData];
}
- (IBAction)logOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

@end
