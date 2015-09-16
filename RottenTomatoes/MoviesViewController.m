//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Dhanya R on 9/15/15.
//  Copyright © 2015 Dhanya R. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"


@interface MoviesViewController ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSMutableArray *movies;
- (void)onRefresh;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Getting refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.movieTableView insertSubview:self.refreshControl atIndex:0];
    [self onRefresh];
   
    self.movieTableView.dataSource = self;
    self.movieTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailTableIdentifier = @"com.dhanyakr.moviesTableViewCell";
    
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTableIdentifier];
    
    if (cell == nil) {
        cell = [[MoviesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailTableIdentifier];
    }
    cell.titleLabel.text = self.movies[indexPath.row][@"title"];
    cell.synopsisLabel.text = self.movies[indexPath.row][@"synopsis"];
    
    NSString *imageUrl = self.movies[indexPath.row][@"posters"][@"thumbnail"];
    NSRange range = [imageUrl rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        imageUrl = [imageUrl stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    
    NSLog(@"image %@", self.movies[indexPath.row][@"posters"][@"thumbnail"]);
    [cell.posterView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"test.png"]];
    
    return cell;
}

- (void)onRefresh {
    // Showing a loading state while waiting for movies API
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];

    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"];
    
    NSLog(@"Response %@", url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = responseDictionary[@"movies"];
        [self.movieTableView reloadData];
        
        // End refreshing control
        [self.refreshControl endRefreshing];
        
        // Stop the loading animation
        [spinner stopAnimating];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"openMovieDetailView"]) {
        MovieDetailViewController *movieDetailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.movieTableView indexPathForSelectedRow];
        
        movieDetailViewController.selectedMovie = self.movies[indexPath.row];
        
        // [self.tableView setAllowsSelection:YES];
    }
}


@end
