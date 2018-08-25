//
//  HLPhoneInfoController.h
//  HLPhoneInfoController
//
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDimensStyle.h"
#import "CommonFontColorStyle.h"

#import "CargoCancelCell.h"
#import "UIImage+Extend.h"
#import "BaseViewController.h"
@interface HLPhoneInfoController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic,nullable)UIImageView *fahuoImageView;
@property (strong, nonatomic,nullable)UIView *cancleView;
@property (strong, nonatomic,nullable)UICollectionView *cancelCollection;
@property (strong, nonatomic,nullable)UIButton *closeBt;
@property NSInteger logId;
@property int appLogEvent;

@end
