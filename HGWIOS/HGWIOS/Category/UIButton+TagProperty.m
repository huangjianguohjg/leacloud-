//
//  UIButton+TagProperty.m
//  funsole
//
//  Created by gagakj on 2017/12/22.
//  Copyright © 2017年 gagakj. All rights reserved.
//

#import "UIButton+TagProperty.h"

#import <objc/message.h>

@implementation UIButton (TagProperty)

-(void)setChooseTag:(NSString *)chooseTag
{
    objc_setAssociatedObject(self, @"chooseTag", chooseTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(NSString *)chooseTag
{
    return objc_getAssociatedObject(self, @"chooseTag");
}

@end
