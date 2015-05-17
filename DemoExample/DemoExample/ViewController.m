//
//  ViewController.m
//  DemoExample
//
//  Created by marcelo.perretta@gmail.com on 5/17/15.
//  Copyright (c) 2015 MAWAPE. All rights reserved.
//

#import "ViewController.h"
#import "MWPagerScroll.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MWPagerScroll *pagerImagesView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pagerImagesView.elementsToShow = @[[UIImage imageNamed:@"title1"],
                                            [UIImage imageNamed:@"title2"],
                                            [UIImage imageNamed:@"title3"],
                                            [UIImage imageNamed:@"title4"],];
    self.pagerImagesView.pagerPosition = bottomPosition;
    
    
    MWPagerScroll *pagerText = [[MWPagerScroll alloc] initWithFrame:CGRectMake(10, 250, self.pagerImagesView.frame.size.width, self.pagerImagesView.frame.size.height) elementsToShow:@[@"Text a", @"Another text", @"Fully text"]];
    
    pagerText.backgroundColor = [UIColor redColor];
    pagerText.hasButtons = YES;
    
    [self.view addSubview:pagerText];
                 
                        
                                
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
