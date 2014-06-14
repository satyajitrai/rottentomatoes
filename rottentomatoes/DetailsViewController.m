//
//  DetailsViewController.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/13/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "DetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailsScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSDictionary *movie;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@end

@implementation DetailsViewController

-(id)initWithMovie:(NSDictionary *)movie {
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
    NSLog(@"Loading movie image from url: %@", url);
    
    [self.movieImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.movieImageView.image = image;
    } failure:nil];
    
    self.detailsScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"synopsis"];
    [self.descriptionLabel sizeToFit];
    
    float width = self.detailsScrollView.frame.size.width;
    float totalHeight = self.titleLabel.frame.size.height + self.descriptionLabel.frame.size.height + 60;
    [self.containerView setFrame:CGRectMake(0, 0, width, totalHeight)];
    
    [self.detailsScrollView addSubview: self.containerView];
    self.detailsScrollView.contentInset = UIEdgeInsetsMake(400, 0, 0, 0);
    self.detailsScrollView.contentSize = CGSizeMake(width, totalHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
