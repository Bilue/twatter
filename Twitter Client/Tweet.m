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
    if (self = [super init]) {
        self.message = @"A tweet message from the dictionary";
        self.date    = [NSDate date];
        self.tweeterName = @"whalec";
        self.tweeterImage = [NSURL URLWithString:@"https://pbs.twimg.com/profile_images/458746713629401088/T069aCrN_normal.jpeg"];
    }

    return self;
}

@end
