//
//  MoviesViewController.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/3/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSString *apiURL;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
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
    
    // Table view delegates
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadMovies];
    [self.tableView registerNib:[UINib nibWithNibName:MovieCellClass bundle:nil] forCellReuseIdentifier:MovieCellClass];
    self.tableView.rowHeight = 120;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void) loadMovies {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self apiURL]]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Failed getting data: %@", connectionError);
            self.errorLabel.hidden = NO;
        }
        else {
            NSLog(@"Succesfully fetched data from: %@", self.apiURL);
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = object[@"movies"];
            self.errorLabel.hidden = YES;
            [self.tableView reloadData];
        }
    }];
}

- (void)refreshTable:(UIRefreshControl*) refresh {
    [self loadMovies];
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - Table view methods

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Creating cell for index %d", indexPath.row);
    NSDictionary *movie = self.movies[indexPath.row];
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MovieCellClass];
    [cell setMovie:movie];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    NSDictionary *selectedMovie = self.movies[indexPath.row];
    DetailsViewController *mdvc = [[DetailsViewController alloc]initWithMovie:selectedMovie];
    [self.navigationController pushViewController:mdvc animated:YES];
}
@end
