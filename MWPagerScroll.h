//
//  MWPagerScroll.h
//  SHINE
//
//  Created by marcelo.perretta@gmail.com on 5/4/15.
//  Copyright (c) 2015 Devige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWPagerScroll : UIView <UIScrollViewDelegate>

typedef NS_ENUM(NSInteger, UIControlPosition) {
    nonePosition,
    topPosition,
    bottomPosition
};


- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements;
- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements inPosition:(UIControlPosition) position;
- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements inPosition:(UIControlPosition) position andHasButtons:(BOOL) hasButtons;


@property (nonatomic, strong) NSArray *elementsToShow;
@property (nonatomic) BOOL hasButtons;

@property (nonatomic) NSUInteger pagerPosition;


@end
