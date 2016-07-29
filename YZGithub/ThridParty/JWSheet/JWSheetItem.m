//
//  JWSheetItem.m
//  FMDBDemo
//
//  Created by 郑建文 on 16/6/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

#import "JWSheetItem.h"

@interface JWSheetItem (){
    clickAction block;
    NSInteger index;
}
@end

@implementation JWSheetItem


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title index:(NSInteger)index1 action:(clickAction)action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        block = action;
        index = index1;
        [self createButton:title index:index1];
    }
    return self;
}

- (void)createButton:(NSString *)title index:(NSInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetHeight(self.frame));
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)click:(UIButton *)btn{
    if (block) {
        block(index);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
