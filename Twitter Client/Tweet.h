//
//  Tweet.h
//  Twitter Client
//
//  Created by Cameron Barrie on 6/10/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *tweeterName;
@property (nonatomic, strong) NSURL *tweeterImage;

- (instancetype)initWithTweet:(NSDictionary *)tweet;


@end
