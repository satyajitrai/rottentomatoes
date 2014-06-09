//
//  MovieDetailsViewController.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/8/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieDetailsViewController ()
@property (weak, nonatomic) NSDictionary *movie;
@property (weak, nonatomic) IBOutlet UITextView *synopsisTextView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *movieScroll;

@end

@implementation MovieDetailsViewController

- (id)initWithMovie:(NSDictionary *)movie {
    self = [super init];
    self.movie = movie;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *url = self.movie[@"posters"][@"detailed"];
    NSLog(@"Loading url: %@", url);
    
    [self.posterImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.posterImageView.image = image;
    } failure:nil];
    
    self.headerLabel.text = self.movie[@"title"];
    self.synopsisTextView.text = self.movie[@"synopsis"];
    self.movieScroll.delegate = self;
    [self.view addSubview:self.movieScroll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Scroll view scrolled");
    scrollView.scrollEnabled = YES;
}

@end
