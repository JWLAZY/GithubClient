//
//  JWSheetItem.h
//  FMDBDemo
//
//  Created by 郑建文 on 16/6/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickAction)(NSInteger index);

@interface JWSheetItem : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title index:(NSInteger)index action:(clickAction)action;

@end
