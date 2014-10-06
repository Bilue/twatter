//
//  MasterViewController.m
//  Twitter Client
//
//  Created by Cameron Barrie on 29/09/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Tweet.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];


    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTweet:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                
                NSURL *timelineURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:timelineURL parameters:@{@"count" : @200}];
                twitterInfoRequest.account = twitterAccount;
                
                // Making the request
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    // Why would we possible need to do this???
//                    dispatch_async(dispatch_get_main_queue(), ^{
                    

                        NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
                    
                        // Check if we reached the reate limit
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit reached");
                            return;
                        }
                        
                        // Check if there was an error
                        
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        
                        // Check if there is some response data
                        
                        if (responseData) {
                            
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                            NSLog(@"\n\n\n%@", [TWData lastObject]);
                            self.objects = [NSMutableArray arrayWithCapacity:200];
                            for (NSDictionary *tweetDict in TWData) {
                                [self.objects addObject:[[Tweet alloc] initWithTweet:tweetDict]];
                            }
                            [self.tableView reloadData];
                            // Filter the preferred data
                            
//                            NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
//                            NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
//                            
//                            int followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
//                            int following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
//                            int tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
//                            
//                            NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
//                            NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                            
                            
                            // Update the interface with the loaded data
                            
//                            nameLabel.text = name;
//                            usernameLabel.text= [NSString stringWithFormat:@"@%@",screen_name];
//                            
//                            tweetsLabel.text = [NSString stringWithFormat:@"%i", tweets];
//                            followingLabel.text= [NSString stringWithFormat:@"%i", following];
//                            followersLabel.text = [NSString stringWithFormat:@"%i", followers];
//                            
//                            NSString *lastTweet = [[(NSDictionary *)TWData objectForKey:@"status"] objectForKey:@"text"];
//                            lastTweetTextView.text= lastTweet;
                            
                            
                            
                            // Get the profile image in the original resolution
                            
//                            profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
//                            [self getProfileImageForURLString:profileImageStringURL];
                            
                            
                            // Get the banner image, if the user has one
                            
//                            if (bannerImageStringURL) {
//                                NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
//                                [self getBannerImageForURLString:bannerURLString];
//                            } else {
//                                bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
//                            }
                        }
//                    });
                }];
            }
        } else {
            NSLog(@"No access granted BOOOO!");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)composeTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Poopin'"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)insertNewObject:(id)sender {
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Tweet *object = self.objects[indexPath.row];
    cell.textLabel.text = object.message;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
