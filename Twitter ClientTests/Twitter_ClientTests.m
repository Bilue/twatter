//
//  Twitter_ClientTests.m
//  Twitter ClientTests
//
//  Created by Cameron Barrie on 29/09/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Tweet.h"

@interface Twitter_ClientTests : XCTestCase
@property NSDictionary* tweetDict;
@end

@implementation Twitter_ClientTests

- (void)setUp {
    [super setUp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
    NSDate *date = [dateFormatter dateFromString:@"Thu Oct 02 08:26:48 +0000 2014"];
    _tweetDict = @{@"user" : @{@"screen_name" : @"@TonyBalony", @"profile_image_url" : @"http://goo.gl/lu4dxT"}, @"text" : @"Blag blag blag", @"created_at" : date};
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTweet {
    // This is an example of a functional test case.
    XCTAssert([[Tweet alloc] init] != nil, @"Pass");
}

- (void)testTweetMessage {
    XCTAssert([[[Tweet alloc] initWithTweet:_tweetDict].message isEqualToString:@"Blag blag blag"], @"Pass");
}

- (void)testTweetTime {
    Tweet *tweet = [[Tweet alloc] initWithTweet:_tweetDict];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
    NSDate *date = [dateFormatter dateFromString:@"Thu Oct 02 08:26:48 +0000 2014"];
    NSLog(@"%@", date);
    
    XCTAssert([tweet.date isEqualToDate:date], @"Pass");
}

- (void)testTweetersName {
    Tweet *tweet = [[Tweet alloc] initWithTweet:_tweetDict];
    XCTAssert([tweet.tweeterName isEqualToString:@"@TonyBalony"], @"Pass");
}

- (void)testTweetersImage {
    Tweet *tweet = [[Tweet alloc] initWithTweet:_tweetDict];
    NSURL *url = [NSURL URLWithString:@"http://goo.gl/lu4dxT"];
    XCTAssert([tweet.tweeterImage isEqual:url], @"Pass");
}

@end
