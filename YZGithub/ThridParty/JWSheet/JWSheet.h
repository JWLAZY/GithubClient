//
//  JWSheet.h
//  FMDBDemo
//
//  Created by 郑建文 on 16/6/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSInteger index);

@interface JWSheet : UIView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items click:(ClickBlock)block;

@end
