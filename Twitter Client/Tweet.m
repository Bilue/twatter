//
//  Tweet.m
//  Twitter Client
//
//  Created by Cameron Barrie on 6/10/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (instancetype)initWithTweet:(NSDictionary *)tweet {
    if ((self = [super init])) {
        self.message = tweet[@"text"];
        self.date = [NSDate date];
        self.tweeterName = tweet[@"user"][@"screen_name"];
        self.tweeterImage = [NSURL URLWithString:tweet[@"user"][@"profile_image_url"]];
    }

    return self;
}

@end
