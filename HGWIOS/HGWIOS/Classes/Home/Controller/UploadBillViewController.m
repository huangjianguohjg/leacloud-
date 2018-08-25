//
//  UploadBillViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "UploadBillViewController.h"
#import <GKPhotoBrowser.h>


@interface UploadBillViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKPhotoBrowserDelegate>

@property (nonatomic, weak) UIImageView * imageView;
@property (nonatomic, weak) UIImageView * addImageView;

@property (nonatomic, copy) NSString * imageID;

@property (nonatomic, weak) UIImage * image;



@end

@implementation UploadBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    self.image = nil;
    
    self.navigationItem.title = self.titleStr;
    
    [self setUpUI];
    
    

}



-(void)setUpUI
{
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClick)]];
    imageView.backgroundColor = XXJColor(243, 247, 251);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight + realH(40));
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(realW(280), realH(500)));
    }];
    self.imageView = imageView;
    
    UIImageView * addImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addP"]];
    addImageView.userInteractionEnabled = YES;
    [addImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseClick)]];
    addImageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView addSubview:addImageView];
    [addImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView);
        make.centerX.equalTo(imageView);
        make.size.equalTo(CGSizeMake(realW(120), realH(120)));
    }];
    self.addImageView = addImageView;
    
    UILabel * titleLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:[NSString stringWithFormat:@"点击%@",self.titleStr]];
    [titleLable sizeToFit];
    [self.view addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.bottom).offset(realH(40));
        make.centerX.equalTo(self.view);
    }];
    
 
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"提交" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = XXJColor(27, 69, 138);
    addButton.layer.cornerRadius = 5;
    addButton.clipsToBounds = YES;
    addButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [self.view addSubview:addButton];
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLable.bottom).offset(realH(88));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
}






//选择图片
-(void)chooseClick
{
    
    if (self.image != nil) {
        [self zoomImageView:self.imageView image:self.image];
        return;
    }
    
    
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
            
            if ([dataDict[@"status"] boolValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.imageView setImage:image];
                    self.addImageView.alpha = 0;
                    self.image = image;
                    self.imageID = dataDict[@"id"];
                });
                
                
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = nil;
                    [self.imageView setImage:[UIImage imageNamed:@""]];
                    self.addImageView.alpha = 1;
                });
                
                [self.view makeToast:@"图片上传失败" duration:1.0 position:CSToastPositionCenter];
                
            }
            
            
            
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = nil;
                [self.imageView setImage:[UIImage imageNamed:@""]];
                self.addImageView.alpha = 1;
            });
            
            
            
            [SVProgressHUD showWithStatus:@"图片上传失败"];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }];
}



#pragma mark -- 图片放大
-(void)zoomImageView:(UIImageView *)imageView image:(UIImage *)image
{
    
    
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





-(void)addClick
{
//    if ([self.scoreStr isEqualToString:@"0"]) {
//        [self.view makeToast:@"请选择星星评价" duration:1.0 position:CSToastPositionCenter];
//        return;
//    }
    
    
    [SVProgressHUD show];
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"loading_image\":\"%@\",\"deal_id\":\"%@\",\"type\":\"%@\"",
                                 [UseInfo shareInfo].access_token,
                                 self.imageID,
                                 self.cargo_id,
                                 [self.titleStr isEqualToString:@"上传发货单"] ? @"1" : @"2"
                                 ];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:Upload_invoiceMethod parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
            [self.view makeToast:@"上传成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [self.view makeToast:@"上传失败" duration:1.0 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}










@end
