//
//  MovieDetailsViewController.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/8/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) NSString * description;

@end

@implementation MovieDetailsViewController

-(id) initWithDescription:(NSString *)description {
    self = [super init];
    self.description = description;
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
    // Do any additional setup after loading the view from its nib.
    self.descriptionLabel.text = self.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
