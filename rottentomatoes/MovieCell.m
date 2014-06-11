//
//  MovieTableViewCell.m
//  rottentomatoes
//
//  Created by Satyajit Rai on 6/5/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@end

@implementation MovieCell

- (void)setMovie:(NSDictionary*)movie {
    self.titleLabel.text = movie[@"title"];
    self.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *thumbUrlString = movie[@"posters"][@"thumbnail"];
    NSURL * thumbUrl = [NSURL URLWithString:thumbUrlString];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [self.posterView setImageWithURLRequest:[NSURLRequest requestWithURL: thumbUrl] placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        NSLog(@"Request Sucessful");
        self.posterView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // TODO: Error handling
        NSLog(@"Request Failed");
    }];
}

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
