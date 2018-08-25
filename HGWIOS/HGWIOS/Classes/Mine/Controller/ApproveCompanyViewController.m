//
//  ApproveCompanyViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/15.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "ApproveCompanyViewController.h"

#import "ApproveMessageView.h"
#import <GKPhotoBrowser.h>
@interface ApproveCompanyViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,GKPhotoBrowserDelegate>

@property (nonatomic, weak) ApproveMessageView * nameView;

@property (nonatomic, weak) ApproveMessageView * phoneView;

@property (nonatomic, weak) ApproveMessageView * licenseView;

@property (nonatomic, weak) ApproveMessageView * transportView;

@property (nonatomic, weak) UIButton * commitButton;

@property (nonatomic, assign) BOOL licenceTag;

@property (nonatomic, assign) BOOL transportTag;

@property (nonatomic, copy) NSString * licence_id;

@property (nonatomic, copy) NSString * transport_license_id;

//长按图片保存用
@property (nonatomic, weak) UIImage * image;

@property (nonatomic, weak) UILabel * alreadyLable;

@property (nonatomic, strong) NSDictionary * infoDict;

@end

@implementation ApproveCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.licenceTag = NO;
    self.transportTag = NO;
    
    [self setUpNav];
    
    [self setUpUI];
    
    [self getCompanyInfoRequest];
}


-(void)setUpNav
{
    self.navigationItem.title = @"企业认证";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    
    
    
    UIButton * leftButton = [[UIButton alloc]init];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arrow-appbar-left"] forState:UIControlStateNormal];
    [leftButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:realW(10)];
    [leftButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
}

-(void)leftItem
{
//    if ([self.infoDict[@"review"] isEqualToString:@"2"] || [self.infoDict[@"review"] isEqualToString:@"1"])
//    {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else
//    {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    
    
    //复制就能用
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
    
    
    
}



-(void)setUpUI
{
    //实名认证
    UIButton * nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [nameButton setTitleColor:XXJColor(99, 99, 99) forState:UIControlStateNormal];
    [nameButton setImage:[UIImage imageNamed:@"ins_number_01"] forState:UIControlStateNormal];
    [nameButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(20)];
    nameButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [nameButton sizeToFit];
    [self.view addSubview:nameButton];
    [nameButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(100) + kStatusBarHeight + kNavigationBarHeight);
        make.right.equalTo(self.view.centerX).offset(realW(-80));
    }];
    
    //企业认证
    UIButton * companyButton = [[UIButton alloc]init];
    [companyButton setTitle:@"企业认证" forState:UIControlStateNormal];
    [companyButton setTitleColor:XXJColor(99, 99, 99) forState:UIControlStateNormal];
    //    [companyButton setImage:[UIImage imageNamed:@"ins_number_02g"] forState:UIControlStateNormal];
    [companyButton setImage:[UIImage imageNamed:@"ins_number_02"] forState:UIControlStateNormal];
    [companyButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:realH(20)];
    companyButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [companyButton sizeToFit];
    [self.view addSubview:companyButton];
    [companyButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(realH(100) + kStatusBarHeight + kNavigationBarHeight);
        make.left.equalTo(self.view.centerX).offset(realW(80));
    }];
    
    UIView * centerLine = [[UIView alloc]init];
    centerLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:centerLine];
    [centerLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(nameButton);
        make.size.equalTo(CGSizeMake(realW(100), realH(1)));
    }];
    
    UIView * bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = XXJColor(245, 245, 245);
    [self.view addSubview:bottomLine];
    [bottomLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(nameButton.bottom).offset(realH(80));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - realW(100), realH(1)));
    }];
    
    
    
    //公司名称
    ApproveMessageView * nameView = [[ApproveMessageView alloc]init];
    nameView.leftLable.text = @"公司名称";
    nameView.textField.placeholder = @"请填写您的公司名称";
    [self.view addSubview:nameView];
    [nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.bottom).offset(realH(40));
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.nameView = nameView;
    
    //公司电话
    ApproveMessageView * phoneView = [[ApproveMessageView alloc]init];
    phoneView.leftLable.text = @"公司电话";
    phoneView.textField.placeholder = @"请填写您的公司电话";
    phoneView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.phoneView = phoneView;
    
    __weak typeof(self) weakSelf = self;
    //营业执照副本
    ApproveMessageView * licenseView = [[ApproveMessageView alloc]init];
    licenseView.leftLable.text = @"营业执照副本";
    licenseView.textField.alpha = 0;
    licenseView.uploadButton.alpha = 1;
    licenseView.uploadBlock = ^{
        //上传营业执照副本
        [weakSelf photoPick];
        weakSelf.licenceTag = YES;
    };
    licenseView.imageTapBlock = ^(UIImage *image) {
        [weakSelf zoomImageView:weakSelf.licenseView.imageview image:image];
    };
    
    [self.view addSubview:licenseView];
    [licenseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.licenseView = licenseView;
    
    //水路运输许可证
    ApproveMessageView * transportView = [[ApproveMessageView alloc]init];
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        transportView.alpha = 1;
    }
    else
    {
        transportView.alpha = 0;
    }
    transportView.leftLable.text = @"水路运输许可证";
    transportView.textField.alpha = 0;
    transportView.uploadButton.alpha = 1;
    transportView.uploadBlock = ^{
        //上传水路运输许可证
        [weakSelf photoPick];
        weakSelf.transportTag = YES;
    };
    transportView.imageTapBlock = ^(UIImage *image) {
        [weakSelf zoomImageView:weakSelf.transportView.imageview image:image];
    };
    [self.view addSubview:transportView];
    [transportView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(licenseView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(realH(100));
    }];
    self.transportView = transportView;
    
    
    UILabel * alreadyLable = [UILabel lableWithTextColor:[UIColor blackColor] textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"已认证\n恭喜您,企业认证已通过!"];
    alreadyLable.textAlignment = NSTextAlignmentCenter;
    alreadyLable.alpha = 0;
    alreadyLable.numberOfLines = 0;
    [alreadyLable sizeToFit];
    [self.view addSubview:alreadyLable];
    [alreadyLable makeConstraints:^(MASConstraintMaker *make) {
        if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
            make.top.equalTo(transportView.bottom).offset(realW(60));
        }
        else
        {
            make.top.equalTo(licenseView.bottom).offset(realW(60));
        }
        
        make.centerX.equalTo(self.view);
        make.height.equalTo(realH(130));
        make.width.equalTo(SCREEN_WIDTH);
    }];
    self.alreadyLable = alreadyLable;
    
    
    //提交
    UIButton * commitButton = [[UIButton alloc]init];
    [commitButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.backgroundColor = XXJColor(27, 69, 138);
    commitButton.layer.cornerRadius = 5;
    commitButton.clipsToBounds = YES;
    commitButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
            make.top.equalTo(transportView.bottom).offset(realW(40));
        }
        else
        {
            make.top.equalTo(licenseView.bottom).offset(realW(40));
        }
        
//        make.top.equalTo(transportView.bottom).offset(realH(40));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    self.commitButton = commitButton;
}


#pragma mark -- 建成日期选择
-(void)photoPick
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开相册
        [weakSelf openAlbum];
        
    }];
    [alertController addAction:moreAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开照相机
        [weakSelf openCamera];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#pragma mark -- 打开相册
- (void)openAlbum
{
    
    // UIImagePickerControllerSourceTypeSavedPhotosAlbum : 从Moments相册中选一张图片
    
    
    // UIImagePickerControllerSourceTypePhotoLibrary : 从所有相册中选一张图片
    
    
    // UIImagePickerControllerSourceTypeCamera : 利用照相机中拍一张图片
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}



#pragma mark -- 打开照相机
- (void)openCamera
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    // 显示选择的图片
    
    
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    image = [UIImage fixOrientation:image];
    image =[UIImage scaleToTargetSize:image];
    //上传图片
    [self UploaImage:image];
}


#pragma mark -- 上传图片
-(void)UploaImage:(UIImage *)image
{
    [SVProgressHUD showWithStatus:@"正在上传..."];
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: [UseInfo shareInfo].access_token,@"access_token",@"/boat/",@"folder",@"boat.jpg",@"realName", nil];
    
    
    [HttpHelper post:UpLoadImage RequestMethod:UpLoadImageMethod RequestParams:parameters FileStream:imageData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            NSLog(@"上传结束");
            [SVProgressHUD dismiss];
            
            NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            XXJLog(@"%@",dataDict);
            
            if (self.licenceTag)
            {
                //主要项目
                self.licence_id = dataDict[@"id"];

                [self.licenseView.imageview updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(60));
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.licenseView.imageview setImage:image];
                });


            }
            else if (self.transportTag)
            {
                //营运证书
                self.transport_license_id = dataDict[@"id"];

                [self.transportView.imageview updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(60));
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.transportView.imageview setImage:image];
                });

            }
            
        }
        else
        {
            [SVProgressHUD showWithStatus:@"上传失败"];
            [SVProgressHUD dismissWithDelay:1.0];
            
            if (self.licenceTag)
            {
                //主要项目
                self.licence_id = nil;
                [self.licenseView.imageview updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(0));
                }];
            }
            else if (self.transportTag)
            {
                //营运证书
                self.transport_license_id = nil;
                [self.transportView.imageview updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(0));
                }];
            }
            
        }
        
        self.licenceTag = NO;
        self.transportTag = NO;
        
    }];
    
    
    
}


#pragma mark -- 图片放大
-(void)zoomImageView:(UIImageView *)imageView image:(UIImage *)image
{
    //用来下面长按图片保存用
    self.image = image;
    
    NSMutableArray *photos = [NSMutableArray new];
    GKPhoto *photo = [GKPhoto new];
    photo.image = image;
    photo.sourceImageView = imageView;
    
    [photos addObject:photo];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle           = GKPhotoBrowserShowStyleZoom;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomScale;
    browser.loadStyle           = GKPhotoBrowserLoadStyleIndeterminateMask;
    
    browser.delegate = self;
    
    [browser showFromVC:self];
}


#pragma mark - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index {
    
    
    UIView *actionSheet = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, realH(200))];
    actionSheet.backgroundColor = [UIColor whiteColor];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, realH(100))];
    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = [UIColor whiteColor];
    [actionSheet addSubview:saveBtn];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, realH(100))];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [actionSheet addSubview:cancelBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [actionSheet addSubview:lineView];
    
    
    
    [GKCover coverFrom:browser.contentView
           contentView:actionSheet
                 style:GKCoverStyleTranslucent
             showStyle:GKCoverShowStyleBottom
             animStyle:GKCoverAnimStyleBottom
              notClick:NO
             showBlock:nil
             hideBlock:^{
             }];
}

#pragma mark -- 图片保存
- (void)saveBtnClick:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
#pragma mark -- 取消保存
- (void)cancelBtnClick:(id)sender {
    [GKCover hideView];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
        [GKCover hideView];
    }
    [SVProgressHUD dismissWithDelay:1.0];
}


#pragma mark -- 获取用户企业认证信息
-(void)getCompanyInfoRequest
{
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\"",[UseInfo shareInfo].access_token];
    
    [XXJNetManager requestPOSTURLString:GetCompanyInfo URLMethod:GetCompanyInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if (result != nil) {
            
            if ([result[@"result"][@"status"] boolValue]) {
                NSDictionary * infoDict = result[@"result"][@"enterprise"];
                
                if (infoDict != nil) {
                    
                    self.infoDict = infoDict;
                    
                    if ([infoDict[@"review"] isEqualToString:@"1"]) {
                        //待审核
//                        [self.view makeToast:@"正在审核中..." duration:1.0 position:CSToastPositionCenter];
                        self.commitButton.alpha = 0;
                        self.alreadyLable.alpha = 1;
                        self.alreadyLable.text = @"正在审核中...";
                        
                        self.nameView.textField.text = infoDict[@"name"];
                        self.nameView.textField.userInteractionEnabled = NO;
                        self.phoneView.textField.text = infoDict[@"contact_mobile"];
                        self.phoneView.textField.userInteractionEnabled = NO;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.licenseView.imageview sd_setImageWithURL:infoDict[@"licence_url"]];
                            [self.licenseView.imageview updateConstraints:^(MASConstraintMaker *make) {
                                make.width.equalTo(realW(60));
                            }];
                            
                            [self.transportView.imageview sd_setImageWithURL:infoDict[@"licence_url"]];
                            [self.transportView.imageview updateConstraints:^(MASConstraintMaker *make) {
                                make.width.equalTo(realW(60));
                            }];
                            
                        });
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"2"])
                    {
                        //成功
                        //            self.commitButton.userInteractionEnabled = NO;
                        //            [self.view makeToast:@"企业认证已通过" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                        //                [self.navigationController popToRootViewControllerAnimated:YES];
                        //            }];
                        
                        self.commitButton.alpha = 0;
                        self.alreadyLable.alpha = 1;
                        self.nameView.textField.text = infoDict[@"name"];
                        self.nameView.textField.userInteractionEnabled = NO;
                        self.phoneView.textField.text = infoDict[@"contact_mobile"];
                        self.phoneView.textField.userInteractionEnabled = NO;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.licenseView.imageview sd_setImageWithURL:infoDict[@"licence_url"]];
                            [self.licenseView.imageview updateConstraints:^(MASConstraintMaker *make) {
                                make.width.equalTo(realW(60));
                            }];
                            self.licenseView.uploadButton.userInteractionEnabled = NO;
                            
                            [self.transportView.imageview sd_setImageWithURL:infoDict[@"transport_url"]];
                            [self.transportView.imageview updateConstraints:^(MASConstraintMaker *make) {
                                make.width.equalTo(realW(60));
                            }];
                            self.transportView.uploadButton.userInteractionEnabled = NO;
                            
                        });
                        
                        
                    }
                    else if ([infoDict[@"review"] isEqualToString:@"3"])
                    {
                        //失败
                        [self.view makeToast:@"企业认证失败，请重新认证" duration:1.0 position:CSToastPositionCenter];
                    }
                    
                    
                    
                    
                }
            }
            
            
            
        }
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    
}




#pragma mark -- 提交企业认证
-(void)commitClick
{
    if (self.nameView.textField.text.length == 0) {
        [self.view makeToast:@"请填写公司名称" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if (self.phoneView.textField.text.length == 0) {
        [self.view makeToast:@"请填写公司电话" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    
    if (self.licence_id == nil) {
        [self.view makeToast:@"请上传营业执照副本" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    if ([[UseInfo shareInfo].identity isEqualToString:@"船东"]) {
        if (self.transport_license_id == nil) {
            [self.view makeToast:@"请上传水路运输许可证" duration:0.5 position:CSToastPositionCenter];
            return;
        }
    }
    else
    {
        self.transport_license_id = @"";
    }
    
    
    
    
    
    
    
    //提交请求成功后
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"licence_id\":\"%@\",\"name\":\"%@\",\"contat_mobile\":\"%@\",\"transport_license_id\":\"%@\"",[UseInfo shareInfo].access_token,self.licence_id,self.nameView.textField.text,self.phoneView.textField.text,self.transport_license_id];
    
    [XXJNetManager requestPOSTURLString:SubmitCompanyInfo URLMethod:SubmitCompanyInfoMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        [self.view makeToast:result[@"result"][@"msg"] duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            if ([result[@"result"][@"msg"] isEqualToString:@"信息提交成功，请等待审核"]) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
    

}






@end
