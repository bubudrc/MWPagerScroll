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
    self.pagerImagesView.hasButtons = YES;
    self.pagerImagesView.pagerPosition = topPosition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
