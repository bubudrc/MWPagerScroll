//
//  MWPagerScroll.m
//  SHINE
//
//  Created by marcelo.perretta@gmail.com on 5/4/15.
//  Copyright (c) 2015 Devige. All rights reserved.
//

#import "MWPagerScroll.h"


@interface MWPagerScroll()

@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;


@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;



@end

@implementation MWPagerScroll


- (instancetype)initWithFrame:(CGRect)frame {

    return [self initWithFrame:frame elementsToShow:@[[self createDefaultView]]];
}

- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements{

    return [self initWithFrame:frame elementsToShow:elements inPosition:nonePosition];
}


- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements inPosition:(UIControlPosition) position{
    
    return [self initWithFrame:frame elementsToShow:elements inPosition:position andHasButtons:NO];
    
}


- (instancetype) initWithFrame:(CGRect)frame elementsToShow:(NSArray *) elements inPosition:(UIControlPosition) position andHasButtons:(BOOL) hasButtons{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.elementsToShow = elements;
        self.pagerPosition = position;
        self.hasButtons = hasButtons;
    }
    return self;
}




- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.elementsToShow = @[[self createDefaultView]];
        self.pagerPosition = nonePosition;
        self.hasButtons = NO;
    }
    return self;
}

-(UILabel *) createDefaultView{
    
    CGRect frame = self.scrollView.bounds;
    frame.origin.x = frame.size.width;
    frame.origin.y = 0.0f;
    
    UILabel *defaultLabel = [[UILabel alloc]initWithFrame:frame];
    defaultLabel.text = @"There any data to show";
    defaultLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    defaultLabel.numberOfLines = 0;
    defaultLabel.lineBreakMode = NSLineBreakByWordWrapping;
    defaultLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    defaultLabel.adjustsFontSizeToFitWidth = YES;
    defaultLabel.minimumScaleFactor = 10.0f/12.0f;
    defaultLabel.clipsToBounds = YES;
    defaultLabel.backgroundColor = [UIColor whiteColor];
    defaultLabel.textColor = [UIColor blackColor];
    defaultLabel.textAlignment = NSTextAlignmentCenter;
    
    return defaultLabel;
}


-(void) setElementsToShow:(NSArray *)elementsToShow{
    
    if(_elementsToShow != elementsToShow){
        _elementsToShow = @[];
        _elementsToShow = elementsToShow;
        
        
        [_scrollView removeFromSuperview];
        [self createScrollView];
        
    }
}

-(void) setPagerPosition:(NSUInteger)pagerPosition{
    if(_pagerPosition != pagerPosition){
        _pagerPosition = pagerPosition;
        
        [_pageControl removeFromSuperview];
        [self createPageControlInPosition:pagerPosition];
    }
}


-(void) setHasButtons:(BOOL)hasButtons{
    if(_hasButtons != hasButtons){
        _hasButtons = hasButtons;
        
        
        [_leftButton removeFromSuperview];
        [_rightButton removeFromSuperview];
        
        [self createButtons];
    }
}

-(void) createScrollView{

    CGFloat scrollX = 0;
    CGFloat scrollY = 0;
    CGFloat scrollWidth = self.frame.size.width;
    CGFloat scrollHeight = self.frame.size.height;

    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX, scrollY, scrollWidth, scrollHeight)];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    NSInteger pageCount = self.elementsToShow.count;
    
    
    
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    

    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
    [self addSubview:self.scrollView];
    
    [self loadVisiblePages];
}


-(void) createPageControlInPosition:(UIControlPosition) position{
    
    if(position != nonePosition){
        CGFloat yPos = 0;
        if(position == bottomPosition){
            yPos = self.frame.size.height - 20;
        }
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, yPos, self.frame.size.width, 20)];
        self.pageControl.numberOfPages = self.elementsToShow.count;
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
    }
}


-(void) createButtons{

    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, self.frame.size.height)];
    self.leftButton.tag = 100;
    [self.leftButton addTarget:self
               action:@selector(buttonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setTitle:@"<" forState:UIControlStateNormal];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, 0, 20, self.frame.size.height)];
    self.rightButton.tag = 101;

    [self.rightButton addTarget:self
                        action:@selector(buttonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitle:@">" forState:UIControlStateNormal];
    
    
    self.leftButton.backgroundColor = self.rightButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65f];

    
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    
}


-(void) buttonPressed:(UIButton *) sender{
    
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    float newPosition = 0;
    
    switch (sender.tag) {
        case 100://leftButton
            if(self.pageControl.currentPage > 0){
                newPosition = self.scrollView.contentOffset.x-width;
            }
            break;
        case 101://rightButton
            if(self.pageControl.currentPage < (self.pageControl.numberOfPages - 1)){
                newPosition = self.scrollView.contentOffset.x+width;
            }
            break;
            
        default:
            NSLog(@"BUTTON TAG UNKNOW");
            break;
    }
    
    CGRect toVisible = CGRectMake(newPosition, 0, width, height);
    
    [self.scrollView scrollRectToVisible:toVisible animated:YES];
}


- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
    // Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
    // Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.elementsToShow.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.elementsToShow.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    

    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        
        if([[self.elementsToShow objectAtIndex:page] isKindOfClass:[UIImage class]]){
            UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.elementsToShow objectAtIndex:page]];
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.frame = frame;
            [self.scrollView addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        } else if([[self.elementsToShow objectAtIndex:page] isKindOfClass:[UILabel class]]){
            
            UILabel *newPageView = [self createDefaultView];
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.frame = frame;
            [self.scrollView addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];

        } else if([[self.elementsToShow objectAtIndex:page] isKindOfClass:[NSString class]]){
            
            UILabel *newPageView = [self createDefaultView];
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.frame = frame;
            newPageView.text = [self.elementsToShow objectAtIndex:page];
            [self.scrollView addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        } else if([[self.elementsToShow objectAtIndex:page] isKindOfClass:[UIView class]]){
            
            
            UIView *newPageView = [self.elementsToShow objectAtIndex:page];
            newPageView.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.frame = frame;
            [self.scrollView addSubview:newPageView];
            [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
            
        } else {
            NSLog(@"The type of object is unknow");
        }
        
    }
}


- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.elementsToShow.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}


@end
