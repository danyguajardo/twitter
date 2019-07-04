//
//  DetailsViewController.h
//  twitter
//
//  Created by danyguajiba on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
