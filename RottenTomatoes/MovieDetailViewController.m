//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Dhanya R on 9/15/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.selectedMovie[@"title"];
    self.synopsisLabel.text = self.selectedMovie[@"synopsis"];
    
    NSString *imageUrl = self.selectedMovie[@"posters"][@"thumbnail"];
    NSRange range = [imageUrl rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        imageUrl = [imageUrl stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"test.png"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
