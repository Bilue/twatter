//
//  DetailViewController.h
//  Twitter Client
//
//  Created by Cameron Barrie on 29/09/2014.
//  Copyright (c) 2014 Cameron Barrie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

