//
//  MoviesViewController.h
//  RottenTomatoes
//
//  Created by Dhanya R on 9/15/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;

@end
