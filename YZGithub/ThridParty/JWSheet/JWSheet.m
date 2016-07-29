//
//  JWSheet.m
//  FMDBDemo
//
//  Created by 郑建文 on 16/6/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

#import "JWSheet.h"
#import "JWSheetItem.h"

@interface JWSheet (){
    CGSize size;
}
@property (nonatomic,strong) UIView * sheetView;
@end

@implementation JWSheet


- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items click:(ClickBlock)block{
    self = [super initWithFrame:frame];
    size = [UIScreen mainScreen].bounds.size;
    [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSheet)];
    [self addGestureRecognizer:tap];
    
    [self createSheetItems:items block:block];
    return self;
}
- (void)createSheetItems:(NSArray *)items block:(ClickBlock)block{
    
    self.sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height, size.width, items.count * 50 + 1)];
    self.sheetView.backgroundColor = [UIColor clearColor];
    [self addSubview:_sheetView];
    CGFloat y = 0;
    NSInteger index = 0;
    for (NSString *title in items) {
        __weak typeof(self) weakself = self;
        JWSheetItem *item = [[JWSheetItem alloc] initWithFrame:CGRectMake(0, y, size.width, 50) title:title index:index++ action:^(NSInteger index) {
            if (block) {
                block(index);
                [weakself hiddenSheet];
            }
        }];
        y+=51;
        [self.sheetView addSubview:item];
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _sheetView.frame;
        frame.origin.y -= frame.size.height;
        _sheetView.frame = frame;
    }];
    
}

- (void)hiddenSheet{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _sheetView.frame;
        frame.origin.y += frame.size.height;
        _sheetView.frame = frame;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
