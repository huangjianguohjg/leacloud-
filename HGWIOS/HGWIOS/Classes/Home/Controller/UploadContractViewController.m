//
//  UploadContractViewController.m
//  HGWIOS
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "UploadContractViewController.h"
#import "HXPhotoPicker.h"
#import <MBProgressHUD.h>
#import "BANetManager_OC.h"
#import "WebViewController.h"
#import <QuickLook/QuickLook.h>
@interface UploadContractViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HXPhotoViewDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource>
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;

@property (nonatomic, weak) UILabel * titleLable;

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, strong) NSMutableArray * imageArray;

@property (nonatomic, strong) NSMutableArray * imageIDArray;

@property (nonatomic, assign) NSInteger uploadCount;

@property (nonatomic, copy) NSString * downloadPath;

@property (nonatomic,strong) QLPreviewController *previewVC;

@end

@implementation UploadContractViewController

-(NSMutableArray *)imageIDArray
{
    if (_imageIDArray == nil) {
        _imageIDArray = [NSMutableArray array];
    }
    return _imageIDArray;
}

-(NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = XXJColor(242, 242, 242);
    
    self.navigationItem.title = @"上传合同";
    
    [self setUpUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}



-(void)setUpUI
{
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = XXJColor(242, 242, 242);
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.scrollView = scrollView;
    
    UIButton * downLoadButton = [[UIButton alloc]init];
    [downLoadButton addTarget:self action:@selector(downloadClick) forControlEvents:UIControlEventTouchUpInside];
    [downLoadButton setTitle:@"下载合同模板" forState:UIControlStateNormal];
    [downLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    downLoadButton.backgroundColor = XXJColor(27, 69, 138);
    downLoadButton.layer.cornerRadius = 5;
    downLoadButton.clipsToBounds = YES;
    downLoadButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scrollView addSubview:downLoadButton];
    [downLoadButton makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(scrollView).offset(realW(20));
        make.centerX.equalTo(scrollView);
        make.top.equalTo(scrollView).offset(realH(20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(300)) , realH(100)));
    }];
    
    
    UIButton * checkButton = [[UIButton alloc]init];
    checkButton.alpha = 0;
    [checkButton addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
    [checkButton setTitle:@"预览" forState:UIControlStateNormal];
    [checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkButton.backgroundColor = XXJColor(27, 69, 138);
    checkButton.layer.cornerRadius = 5;
    checkButton.clipsToBounds = YES;
    checkButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scrollView addSubview:checkButton];
    [checkButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(downLoadButton);
        make.left.equalTo(downLoadButton.right).offset(realW(10));
        make.size.equalTo(CGSizeMake( SCREEN_WIDTH - (SCREEN_WIDTH - realW(180)) - realW(50) , realH(100)));
    }];
    
    //数据线连接手机和电脑,打开iTunes,点击手机选择文件共享,点击应用化运网,将contract.docx(合同模板)拖到桌面编辑盖章扫描后提交
    UILabel * remindLable = [UILabel lableWithTextColor:[UIColor lightGrayColor] textFontSize:realFontSize(32) fontFamily:PingFangSc_Regular text:@"下载成功后在查看界面,点击右上角分享,选择微信或者QQ发送到电脑编辑盖章扫描后提交"];
    remindLable.numberOfLines = 0;
    remindLable.lineBreakMode = NSLineBreakByCharWrapping;
    remindLable.textAlignment = NSTextAlignmentCenter;
    [remindLable sizeToFit];
    [scrollView addSubview:remindLable];
    [remindLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(downLoadButton.bottom).offset(realH(10));
        make.centerX.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH - realW(40));
    }];
    
    
    HXPhotoView * photoView = [HXPhotoView photoManager:self.manager];
    //    photoView.frame = CGRectMake(realW(24), realW(24), SCREEN_WIDTH - realW(24) * 2, 100);
    photoView.delegate = self;
    photoView.outerCamera = YES;
    photoView.backgroundColor = XXJColor(242, 242, 242);
    [scrollView addSubview:photoView];
    [photoView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(W(12));
        make.top.equalTo(scrollView.top).offset(H(10) + realH(110) + realH(150));
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - W(24), 0));
    }];
    self.photoView = photoView;
    
    
    
    UILabel * titleLable = [UILabel lableWithTextColor:XXJColor(116, 116, 116) textFontSize:realFontSize(36) fontFamily:PingFangSc_Regular text:@"点击上传合同照片"];
    [titleLable sizeToFit];
    [scrollView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(scrollView.top).offset(realH(280 + 100));
        make.top.equalTo(photoView.bottom).offset(realH(40));
        make.centerX.equalTo(scrollView);
//        make.size.equalTo(CGSizeMake(realW(250), realH(36)));
    }];
    self.titleLable = titleLable;
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"提交" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.backgroundColor = XXJColor(27, 69, 138);
    addButton.layer.cornerRadius = 5;
    addButton.clipsToBounds = YES;
    addButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scrollView addSubview:addButton];
    [addButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.top.equalTo(titleLable.bottom).offset(realH(88));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
}

-(void)addClick
{
    [self.imageIDArray removeAllObjects];
    self.uploadCount = 0;
    
    for (UIImage * image in self.imageArray) {
        
        [self UploaImage:image];
    }
    
}




- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = NO;
        [_manager setOriginal:YES];
        _manager.original = YES;
        _manager.configuration.photoMaxNum = 99;
        _manager.configuration.videoMaxNum = 0;
        _manager.configuration.maxNum = 10;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = NO;
        //        _manager.configuration.reverseDate = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        //        _manager.configuration.rowCount = 3;
        //        _manager.configuration.movableCropBox = YES;
        //        _manager.configuration.movableCropBoxEditSize = YES;
        //        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        
        __weak typeof(self) weakSelf = self;
        //        _manager.configuration.replaceCameraViewController = YES;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}



//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//        [picker dismissViewControllerAnimated:YES completion:nil];
//
//        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//        HXPhotoModel *model;
//        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
//            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//            model = [HXPhotoModel photoModelWithImage:image];
//            if (self.manager.configuration.saveSystemAblum) {
//                [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:model.thumbPhoto];
//            }
//        }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
//            NSURL *url = info[UIImagePickerControllerMediaURL];
//            NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
//                                                             forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
//            AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
//            float second = 0;
//            second = urlAsset.duration.value/urlAsset.duration.timescale;
//            model = [HXPhotoModel photoModelWithVideoURL:url videoTime:second];
//            if (self.manager.configuration.saveSystemAblum) {
//                [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url];
//            }
//        }
//        if (self.manager.configuration.useCameraComplete) {
//            self.manager.configuration.useCameraComplete(model);
//        }
//}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
    
    
    __weak typeof(self) weakSelf = self;
    [self.toolManager writeSelectModelListToTempPathWithList:photos requestType:YES success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
        NSSLog(@"\nall : %@ \nimage : %@ \nvideo : %@",allURL,photoURL,videoURL);
//        NSURL *url = photoURL.firstObject;
        
        [weakSelf.imageArray removeAllObjects];
        for (NSURL * url in photoURL) {
            if (url) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                NSSLog(@"%@",image);
                
                [weakSelf.imageArray addObject:image];
            }
        }
        
        
//        [weakSelf.view handleLoading];
    } failed:^{
//        [weakSelf.view handleLoading];
//        [weakSelf.view showImageHUDText:@"写入失败"];
        NSSLog(@"写入失败");
    }];
    
    
    
    

}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + realH(80) + realH(150 + 88 + 60));
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.titleLable updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(CGRectGetMaxY(frame) + realH(80));
        }];
        
        [self.scrollView layoutIfNeeded];
    }];
    
    
}

- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}

#pragma mark -- 上传图片
-(void)UploaImage:(UIImage *)image
{
//    [SVProgressHUD showWithStatus:@"正在上传..."];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在上传";
    NSData *imageData = UIImagePNGRepresentation(image);
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: [UseInfo shareInfo].access_token,@"access_token",@"/boat/",@"folder",@"boat.jpg",@"realName", nil];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [HttpHelper post:UpLoadImage RequestMethod:UpLoadImageMethod RequestParams:parameters FileStream:imageData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError == nil) {
                NSLog(@"上传结束");
                //            [SVProgressHUD dismiss];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
                
                NSDictionary * dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                XXJLog(@"%@",dataDict);
                
                if ([dataDict[@"status"] boolValue]) {
                    
                    [self.imageIDArray addObject:dataDict[@"id"]];
                    
                    if (self.imageIDArray.count == self.imageArray.count) {
                        NSString  * strID = @"";
                        for (NSString * str in self.imageIDArray) {
                            
                            strID = [strID stringByAppendingFormat:@",%@",str];
                            
                        }
                        
                        strID = [strID substringFromIndex:1];
                        
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self commitImage:strID];
                        });
                        
                        
                    }
                }
                else
                {
                    [self.view makeToast:@"图片上传失败" duration:1.0 position:CSToastPositionCenter];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
                [self.view makeToast:@"图片上传失败" duration:1.0 position:CSToastPositionCenter];
                //            [SVProgressHUD dismiss];
            }
        }];
        
        
    });
    
    
}





-(void)commitImage:(NSString *)imageID
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"正在上传";
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"access_token\":\"%@\",\"business_type\":\"%@\",\"file_id\":\"%@\",\"deal_id\":\"%@\"",
                                 [UseInfo shareInfo].access_token,
                                 [[UseInfo shareInfo].identity isEqualToString:@"船东"] ? @"1" : @"2",
                                 imageID,
                                 self.cargo_id
                                 ];
    
    [XXJNetManager requestPOSTURLString:TransportDeal URLMethod:sign_contract parameters:parameterstring finished:^(id result) {
        [SVProgressHUD dismiss];
        
        XXJLog(@"%@",result)
        
        if ([result[@"result"][@"status"] boolValue]) {
//            self.uploadCount++;
            
//            if (self.uploadCount == self.imageIDArray.count) {
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hideAnimated:YES];
                });
                
                
                
                [self.view makeToast:@"上传成功" duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
//            }
            
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
            [self.view makeToast:@"上传失败" duration:1.0 position:CSToastPositionCenter];
        }
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:1.0 position:CSToastPositionCenter];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    }];
}



#pragma mark -- 下载合同模板
-(void)downloadClick
{
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:path];
//    NSString * hetongpath;
//    BOOL result2 = NO;
//    while ((hetongpath = [dirEnum nextObject]) != nil) {
//        if ([hetongpath isEqualToString:@"contract.docx"]) {
//            result2 = YES;
//            break;
//        }
//    }
    
    /*! 查找路径中是否存在"半塘.mp4"，是，返回真；否，返回假。 */
//    BOOL result2 = [self.downloadPath hasSuffix:@"contract.docx"];
//    NSLog(@"%d", result2);
    /*!
     下载前先判断该用户是否已经下载，目前用了两种方式：
     1、第一次下载完用变量保存，
     2、查找路径中是否包含改文件的名字
     如果下载完了，就不要再让用户下载，也可以添加alert的代理方法，增加用户的选择！
     */
//    if (result2)
//    {
//        [self.view makeToast:@"合同模块已下载" duration:0.5 position:CSToastPositionCenter];
//        return;
//    }

    //下载之前先清除之前的
    if (self.downloadPath) {
        NSFileManager *fileManager =[NSFileManager defaultManager];
        [fileManager removeItemAtPath:self.downloadPath error:NULL];

    }
    
    
    
    NSString *path1 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/contract.docx"]];
    //    NSString *path2 = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/image123.mp3"]];
    
    NSLog(@"路径：%@", path1);
    
    
    
    
    
    [SVProgressHUD showWithStatus:@"正在下载..."];
    
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    fileEntity.urlString = @"http://www.e-huayun.com/zyhl/Public/template/Template.docx";
    fileEntity.filePath = path1;
    
    [BANetManager ba_downLoadFileWithEntity:fileEntity successBlock:^(id response) {
        [SVProgressHUD dismiss];
        self.downloadPath = path1;
        [self.view makeToast:@"合同模板下载成功" duration:1.0 position:CSToastPositionCenter];
        NSLog(@"下载完成，路径为：%@", response);
        
        self.previewVC = [[QLPreviewController alloc] init];
        self.previewVC.dataSource = self;
        [self presentViewController:self.previewVC animated:YES completion:nil];
        
        
        
//        [self checkClick];
//        self.downloadLabel.text = @"下载完成";
//        isFinishDownload = YES;
//        [downloadBtn setTitle:@"下载完成" forState:UIControlStateNormal];
//        [downloadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        BAKit_ShowAlertWithMsg(@"视频下载完成！");
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        /*! 封装方法里已经回到主线程，所有这里不用再调主线程了 */
//        self.downloadLabel.text = [NSString stringWithFormat:@"下载进度：%.2lld%%",100 * bytesProgress/totalBytesProgress];
//        [downloadBtn setTitle:@"下载中..." forState:UIControlStateNormal];
    }];
}


//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    if (self.downloadPath) {
//        NSFileManager *fileManager =[NSFileManager defaultManager];
//        [fileManager removeItemAtPath:self.downloadPath error:NULL];
//
//    }
//
//}


-(void)checkClick
{
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:path];
//    NSString * hetongpath;
//    BOOL result2 = NO;
//    while ((hetongpath = [dirEnum nextObject]) != nil) {
//        if ([hetongpath isEqualToString:@"contract.docx"]) {
//            result2 = YES;
//            break;
//        }
//    }
    
    BOOL result2 = [self.downloadPath hasSuffix:@"contract.docx"];
    if (!result2) {
        [self.view makeToast:@"请先下载合同" duration:0.5 position:CSToastPositionCenter];
        return;
    }

    WebViewController * webVc = [[WebViewController alloc]init];
    webVc.filePath = self.downloadPath;
    webVc.hidesBottomBarWhenPushed = YES;
    webVc.titleStr = @"合同模板";
    [self.navigationController pushViewController:webVc animated:YES];
    
//    UIDocumentInteractionController *doc= [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.downloadPath]];
////    XXJLog(@"%@===%@",[UseInfo shareInfo].hetongPath,[NSURL fileURLWithPath:[UseInfo shareInfo].hetongPath])
//    doc.delegate = self;
//    [doc presentPreviewAnimated:YES];
    
    
    
}


#pragma mark - UIDocumentInteractionControllerDelegate
//必须实现的代理方法 预览窗口以模式窗口的形式显示，因此需要在该方法中返回一个view controller ，作为预览窗口的父窗口。如果你不实现该方法，或者在该方法中返回 nil，或者你返回的 view controller 无法呈现模式窗口，则该预览窗口不会显示。

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    
    return self;
}

- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller {
    
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    
    return CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT);
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    //这个是加载的本地的pdf的文件，doc的同理
    NSURL *url = [NSURL fileURLWithPath:self.downloadPath];
    return url;
}



@end
