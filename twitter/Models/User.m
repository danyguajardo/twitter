//
//  User.m
//  twitter
//
//  Created by danyguajiba on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self){
    self.name = dictionary[@"name"];
    self.screenName = dictionary[@"screen_name"];
    self.profileURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
    self.friends = dictionary[@"friends_count"];
    self.followers = dictionary[@"followers_count"];
    }
return self;
}

@end
