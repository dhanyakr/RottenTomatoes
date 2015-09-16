//
//  MoviesTableViewCell.h
//  RottenTomatoes
//
//  Created by Dhanya R on 9/15/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;


@end
