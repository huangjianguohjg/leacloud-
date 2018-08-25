//
//  CargoCancelCell.h
//  haoyunhl
//
//  Created by lianghy on 16/7/22.
//  Copyright © 2016年 haoyunhanglian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CargoCancelCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *chooseImage;
@property(nonatomic,strong)UILabel *showContent;
@property(nonatomic,strong)NSString *cellkey;
-(void)setContent:(NSString *)key Desc:(NSString *)desc;
@end
