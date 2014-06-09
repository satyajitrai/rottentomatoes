//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/3/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSString *apiURL;
@end

@implementation MoviesViewController

static NSString * const MovieCellClass = @"MovieCell";

-(id) initWithURL:(NSString *)url {
    self = [super init];
    self.apiURL = url;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self apiURL]]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (connectionError) {
            NSLog(@"Failed getting data: %@", connectionError);
        }
        else {
            NSLog(@"Succesfully fetched data from: %@", self.apiURL);
        }
        
        self.movies = object[@"movies"];
        
        [self.tableView reloadData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:MovieCellClass bundle:nil] forCellReuseIdentifier:MovieCellClass];
    
    self.tableView.rowHeight = 120;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Sender is : %@", sender);
}

#pragma mark  - Table view methods

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"Cell for row at index path: %d", indexPath.row);
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MovieCellClass];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *thumbUrlString = movie[@"posters"][@"thumbnail"];
    NSURL * thumbUrl = [NSURL URLWithString:thumbUrlString];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [cell.posterView setImageWithURLRequest:[NSURLRequest requestWithURL: thumbUrl] placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        NSLog(@"Request Sucessfull");
        cell.posterView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // TODO: Error handling
        NSLog(@"Request Failed");
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    NSDictionary *selectedMovie = self.movies[indexPath.row];
    MovieDetailsViewController *mdvc = [[MovieDetailsViewController alloc]initWithMovie:selectedMovie];
    [self.navigationController pushViewController:mdvc animated:YES];
}
@end
