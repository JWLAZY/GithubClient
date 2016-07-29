//
//  NSString+TranToRich.m
//  YZGithub
//
//  Created by 郑建文 on 16/7/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

#import "NSString+TranToRich.h"
#import "AttributedMarkdown/markdown_lib.h"
#import "AttributedMarkdown/markdown_peg.h"


@implementation NSString (TranToRich)

- (NSAttributedString *)richText{
    NSAttributedString *prettyText = markdown_to_attr_string(self,0,nil);
    return prettyText;
}

@end
