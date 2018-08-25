//
//  AddBoatViewController.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "AddBoatViewController.h"

#import "AddBoatView.h"
#import "TypeView.h"

#import "MyBoatModel.h"

#import <BRDatePickerView.h>
#import <BRStringPickerView.h>
#import <GKPhotoBrowser.h>
#import "ChooseApproveViewController.h"
@interface AddBoatViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKPhotoBrowserDelegate>

@property (nonatomic, weak) AddBoatView * nameView;

@property (nonatomic, weak) AddBoatView * mssiView;

@property (nonatomic, weak) AddBoatView * typeView;

@property (nonatomic, weak) AddBoatView * areaView;

@property (nonatomic, weak) AddBoatView * weightView;

@property (nonatomic, weak) AddBoatView * volumeView;

@property (nonatomic, weak) AddBoatView * lengthView;

@property (nonatomic, weak) AddBoatView * widthView;

@property (nonatomic, weak) AddBoatView * deepView;

@property (nonatomic, weak) AddBoatView * checkView;

@property (nonatomic, weak) AddBoatView * dateView;

@property (nonatomic, weak) AddBoatView * projectView;

@property (nonatomic, weak) AddBoatView * serviceView;

@property (nonatomic, weak) AddBoatView * installView;

@property (nonatomic, weak) TypeView * popView;

@property (nonatomic, weak) UIView * coverView;

@property (nonatomic, strong) NSDictionary * shipTypeDict;

@property (nonatomic, copy) NSString * shipID;

@property (nonatomic, strong) NSArray * checkShipArray;

/**
 主要项目
 */
@property (nonatomic, assign) BOOL cerTag;
@property (nonatomic, copy) NSString * certificate_file_id;

/**
 营运证书
 */
@property (nonatomic, assign) BOOL fileTag;
@property (nonatomic, copy) NSString * inspect_file_id;

/**
 适装证书
 */
@property (nonatomic, assign) BOOL installTag;
@property (nonatomic, copy) NSString * install_file_id;


//记录保存的图片
@property (nonatomic, weak) UIImage * image;

@end

@implementation AddBoatViewController

-(NSArray *)checkShipArray
{
    if (_checkShipArray == nil) {
        _checkShipArray = [NSArray array];
    }
    return _checkShipArray;
}

-(NSDictionary *)shipTypeDict
{
    if (_shipTypeDict == nil) {
        _shipTypeDict = [NSDictionary dictionary];
    }
    return _shipTypeDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXJColor(235, 240, 246);
    
    self.cerTag = NO;
    self.fileTag = NO;
    

    self.navigationItem.title = @"添加船舶";
    
    [self setUpUI];
    
    //检查类型的弹窗
    [self creatPopView];
    
    
    [self.nameView.textField becomeFirstResponder];
    
}






-(void)setUpUI
{
    CGFloat margin = 0;
    if (isIPHONEX) {
        margin = 34;
    }
    
    __weak typeof(self) weakSelf = self;
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.userInteractionEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarHeight + kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    //船舶名称
    AddBoatView * nameView = [[AddBoatView alloc]init];
    nameView.starLable.alpha = 1;
    nameView.textField.alpha = 1;
    nameView.leftLable.text = @"船舶名称";
    nameView.textField.placeholder = @"请填写船舶名称";
    [scrollView addSubview:nameView];
    [nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.nameView = nameView;
    
    //MMSI
    AddBoatView * mssiView = [[AddBoatView alloc]init];
    mssiView.starLable.alpha = 1;
    mssiView.textField.alpha = 1;
    mssiView.leftLable.text = @"MMSI";
    mssiView.textField.placeholder = @"请填写MMSI";
    [scrollView addSubview:mssiView];
    [mssiView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.mssiView = mssiView;
    
    
    //船舶类型
    AddBoatView * typeView = [[AddBoatView alloc]init];
    typeView.chooseBlock = ^{
        
        [weakSelf.mssiView.textField resignFirstResponder];
        [weakSelf.nameView.textField resignFirstResponder];
        [weakSelf.weightView.textField resignFirstResponder];
        [weakSelf.volumeView.textField resignFirstResponder];
        [weakSelf.lengthView.textField resignFirstResponder];
        [weakSelf.widthView.textField resignFirstResponder];
        [weakSelf.deepView.textField resignFirstResponder];
        

        [weakSelf shipTypeRequest];
        
    };
    typeView.starLable.alpha = 1;
    typeView.chooseButton.alpha = 1;
    typeView.leftLable.text = @"船舶类型";
    [typeView.chooseButton setTitle:@"请选择船舶类型" forState:UIControlStateNormal];
    [typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:typeView];
    [typeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mssiView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.typeView = typeView;
    
    
    //船舶航区
    AddBoatView * areaView = [[AddBoatView alloc]init];
    areaView.chooseBlock = ^{
        //航区选择
        [weakSelf.mssiView.textField resignFirstResponder];
        [weakSelf.nameView.textField resignFirstResponder];
        [weakSelf.weightView.textField resignFirstResponder];
        [weakSelf.volumeView.textField resignFirstResponder];
        [weakSelf.lengthView.textField resignFirstResponder];
        [weakSelf.widthView.textField resignFirstResponder];
        [weakSelf.deepView.textField resignFirstResponder];
        
        [BRStringPickerView showStringPickerWithTitle:@"船舶航区" dataSource:@[@"内河船",@"沿海船"] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            [weakSelf.areaView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [weakSelf.areaView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
    };
    areaView.starLable.alpha = 1;
    areaView.chooseButton.alpha = 1;
    areaView.leftLable.text = @"船舶航区";
    [areaView.chooseButton setTitle:@"请选择船舶航区" forState:UIControlStateNormal];
    [areaView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:areaView];
    [areaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.areaView = areaView;
    
    
    
    //参考重量
    AddBoatView * weightView = [[AddBoatView alloc]init];
    weightView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    weightView.starLable.alpha = 1;
    weightView.textField.alpha = 1;
    weightView.leftLable.text = @"参考重量(吨)";
    weightView.textField.placeholder = @"请填写参考重量";
    [scrollView addSubview:weightView];
    [weightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.weightView = weightView;
    
    
    //船舶舱容
    AddBoatView * volumeView = [[AddBoatView alloc]init];
    volumeView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    volumeView.starLable.alpha = 1;
    volumeView.textField.alpha = 1;
    volumeView.leftLable.text = @"船舶舱容(立方米)";
    volumeView.textField.placeholder = @"请填写船舶舱容";
    [scrollView addSubview:volumeView];
    [volumeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weightView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.volumeView = volumeView;
    
    
    
    
    
    
    //船舶总长
    AddBoatView * lengthView = [[AddBoatView alloc]init];
    lengthView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    lengthView.starLable.alpha = 1;
    lengthView.textField.alpha = 1;
    lengthView.leftLable.text = @"船舶总长(米)";
    lengthView.textField.placeholder = @"请填写船舶总长";
    [scrollView addSubview:lengthView];
    [lengthView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(volumeView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.lengthView = lengthView;
    
    //船舶总宽
    AddBoatView * widthView = [[AddBoatView alloc]init];
    widthView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    widthView.starLable.alpha = 1;
    widthView.textField.alpha = 1;
    widthView.leftLable.text = @"船舶总宽(米)";
    widthView.textField.placeholder = @"请填写船舶总宽";
    [scrollView addSubview:widthView];
    [widthView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lengthView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.widthView = widthView;
    
    
    //满载吃水
    AddBoatView * deepView = [[AddBoatView alloc]init];
    deepView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    deepView.starLable.alpha = 1;
    deepView.textField.alpha = 1;
    deepView.leftLable.text = @"满载吃水(米)";
    deepView.textField.placeholder = @"请填写船舶满载吃水";
    [scrollView addSubview:deepView];
    [deepView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(widthView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.deepView = deepView;
    
    
    
    //船舶检查类型
    AddBoatView * checkView = [[AddBoatView alloc]init];
    checkView.chooseBlock = ^{
        [weakSelf.mssiView.textField resignFirstResponder];
        [weakSelf.nameView.textField resignFirstResponder];
        [weakSelf.weightView.textField resignFirstResponder];
        [weakSelf.volumeView.textField resignFirstResponder];
        [weakSelf.lengthView.textField resignFirstResponder];
        [weakSelf.widthView.textField resignFirstResponder];
        [weakSelf.deepView.textField resignFirstResponder];
        //检查类型
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.popView.alpha = 1;
            
            weakSelf.coverView.alpha = 0.3;
        }];
        
        [weakSelf shipCheckRequest];
        
    };
    checkView.starLable.alpha = 1;
    checkView.chooseButton.alpha = 1;
    checkView.leftLable.text = @"船舶检查类型";
    [checkView.chooseButton setTitle:@"请检查船舶检查类型" forState:UIControlStateNormal];
    [checkView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
    [scrollView addSubview:checkView];
    [checkView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deepView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.checkView = checkView;
    
    
    //建成日期
    AddBoatView * dateView = [[AddBoatView alloc]init];
    dateView.dateBlock = ^{
        [weakSelf.mssiView.textField resignFirstResponder];
        [weakSelf.nameView.textField resignFirstResponder];
        [weakSelf.weightView.textField resignFirstResponder];
        [weakSelf.volumeView.textField resignFirstResponder];
        [weakSelf.lengthView.textField resignFirstResponder];
        [weakSelf.widthView.textField resignFirstResponder];
        [weakSelf.deepView.textField resignFirstResponder];
        //选择日期
        [BRDatePickerView showDatePickerWithTitle:@"选择日期" dateType:BRDatePickerModeDate defaultSelValue:nil resultBlock:^(NSString *selectValue) {
            
            NSString * currentDate = [weakSelf getCurrentTime];
            
            CGFloat aa = [weakSelf compareDate:currentDate withDate:selectValue];
            
            if (aa == 1) {
                [weakSelf.view makeToast:@"请重新选择日期" duration:0.5 position:CSToastPositionCenter];
                return ;
            }
            
            weakSelf.dateView.timeLable.text = selectValue;
            
        }];
    };
    dateView.starLable.alpha = 1;
    dateView.frameView.alpha = 1;
    dateView.timeLable.alpha = 1;
    dateView.leftLable.text = @"建成日期";
    [scrollView addSubview:dateView];
    [dateView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.dateView = dateView;
    
    //船舶主要项目
    AddBoatView * projectView = [[AddBoatView alloc]init];
    projectView.chooseBlock = ^{
        //主要项目
        [weakSelf photoPick];
        weakSelf.cerTag = YES;
    };
    projectView.imageBlock = ^(UIImage *image) {
        //图片放大
        [weakSelf zoomImageView:weakSelf.projectView.imageView image:image];
    };
    projectView.starLable.alpha = 1;
    projectView.uploadButton.alpha = 1;
    projectView.leftLable.text = @"船舶主要项目";
    [scrollView addSubview:projectView];
    [projectView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
    }];
    self.projectView = projectView;
    
    
    //船舶营运证书
    AddBoatView * serviceView = [[AddBoatView alloc]init];
    serviceView.chooseBlock = ^{
        //营运证书
        [weakSelf photoPick];
        weakSelf.fileTag = YES;
    };
    serviceView.imageBlock = ^(UIImage *image) {
        //图片放大
        [weakSelf zoomImageView:weakSelf.serviceView.imageView image:image];
        
    };
    serviceView.starLable.alpha = 1;
    serviceView.uploadButton.alpha = 1;
    serviceView.leftLable.text = @"船舶营运证书";
    [scrollView addSubview:serviceView];
    [serviceView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(projectView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
//        make.bottom.equalTo(scrollView);
    }];
    self.serviceView = serviceView;
    
    
    //适装证书
    AddBoatView * installView = [[AddBoatView alloc]init];
    installView.chooseBlock = ^{
        //适装证书
        [weakSelf photoPick];
        weakSelf.installTag = YES;
    };
    installView.imageBlock = ^(UIImage *image) {
        //图片放大
        [weakSelf zoomImageView:weakSelf.installView.imageView image:image];
        
    };
    installView.starLable.alpha = 1;
    installView.uploadButton.alpha = 1;
    installView.leftLable.text = @"船舶适装证书";
    [scrollView addSubview:installView];
    [installView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(serviceView.bottom);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(realH(120));
        //        make.bottom.equalTo(scrollView);
    }];
    self.installView = installView;
    
    
    
    
    
    
    //添加船舶
    UIButton * sureButton = [[UIButton alloc]init];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = XXJColor(27, 69, 138);
    sureButton.layer.cornerRadius = 5;
    sureButton.clipsToBounds = YES;
    sureButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(38)];
    [scrollView addSubview:sureButton];
    [sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(installView.bottom).offset(realH(20));
        make.centerX.equalTo(scrollView);
        make.bottom.equalTo(scrollView).offset(realH(-20));
        make.size.equalTo(CGSizeMake((SCREEN_WIDTH - realW(40)) , realH(100)));
    }];
    
    
    if (self.model != nil) {
        self.nameView.textField.text = self.model.name;
//        self.mssiView.textField.text =
        [self.typeView.chooseButton setTitle:self.model.type_name forState:UIControlStateNormal];
        self.shipID = self.model.type_id;
        [self.areaView.chooseButton setTitle:self.model.sailing_area forState:UIControlStateNormal];
        self.weightView.textField.text = self.model.deadweight;
        self.lengthView.textField.text = self.model.length;
        self.widthView.textField.text = self.model.width;
        self.deepView.textField.text = self.model.draught;
        [self.checkView.chooseButton setTitle:self.model.inspect_type forState:UIControlStateNormal];
        self.dateView.timeLable.text = [TYDateUtils timestampSwitchTime:[self.model.complete_time integerValue]];
        
        self.volumeView.textField.text = self.model.storage;
        
        if ([self.model.type_name containsString:@"化"]) {
            self.installView.leftLable.text = @"适装证书";
        }
        else
        {
            self.installView.leftLable.text = @"适航证书";
        }
        
        [self.typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [self.areaView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        [self.checkView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
        
        if ([self.model.review_status_name isEqualToString:@"待审核"]) {
            self.nameView.textField.userInteractionEnabled = NO;
            self.mssiView.textField.userInteractionEnabled = NO;
            self.typeView.chooseButton.userInteractionEnabled = NO;
            self.areaView.chooseButton.userInteractionEnabled = NO;
            self.weightView.textField.userInteractionEnabled = NO;
            self.lengthView.textField.userInteractionEnabled = NO;
            self.widthView.textField.userInteractionEnabled = NO;
            self.deepView.textField.userInteractionEnabled = NO;
            self.checkView.chooseButton.userInteractionEnabled = NO;
            self.dateView.timeLable.userInteractionEnabled = NO;
            self.dateView.frameView.userInteractionEnabled = NO;
            self.volumeView.textField.userInteractionEnabled = NO;
            
            self.projectView.uploadButton.userInteractionEnabled = NO;
            self.serviceView.uploadButton.userInteractionEnabled = NO;
            self.installView.uploadButton.userInteractionEnabled = NO;
            
            sureButton.userInteractionEnabled = NO;
            
            [sureButton setTitle:@"待审核" forState:UIControlStateNormal];
        }
        
    }
    
    
    
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
            
            if (self.cerTag)
            {
                //主要项目
                self.certificate_file_id = dataDict[@"id"];
                
                [self.projectView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(80));
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [self.projectView.imageView setImage:image];
                });
                
                
            }
            else if (self.fileTag)
            {
                //营运证书
                self.inspect_file_id = dataDict[@"id"];
                
                [self.serviceView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(80));
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [self.serviceView.imageView setImage:image];
                });
                
            }
            else if (self.installTag)
            {
                //适装证书
                self.install_file_id = dataDict[@"id"];
                
                [self.installView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(80));
                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [self.installView.imageView setImage:image];
                });
                
            }
            
        }
        else
        {
//            [SVProgressHUD showWithStatus:@"上传失败"];
            [SVProgressHUD dismiss];
            [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
            
            if (self.cerTag)
            {
                //主要项目
                self.certificate_file_id = nil;
                [self.projectView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(0));
                }];
            }
            else if (self.fileTag)
            {
                //营运证书
                self.inspect_file_id = nil;
                [self.serviceView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(0));
                }];
            }
            else if (self.installTag)
            {
                //适装证书
                self.install_file_id = nil;
                [self.installView.imageView updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(realW(0));
                }];
            }
            
        }
        self.cerTag = NO;
        self.fileTag = NO;
        self.installTag = NO;
    }];
}


#pragma mark -- 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}


#pragma mark -- 比较日期的大小
- (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    
    return aa;
}


#pragma mark -- 检查类型的弹窗
-(void)creatPopView
{
    UIView * coverView = [[UIView alloc]init];
    [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    [self.view addSubview:coverView];
    [coverView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    self.coverView = coverView;
    
    __weak typeof(self) weakSelf = self;
    TypeView * popView = [[TypeView alloc]init];
    popView.okBlock = ^(NSString *ss) {
        if ([ss isEqualToString:@"取消"]) {
            
        }
        else
        {
            
            [weakSelf.checkView.chooseButton setTitle:ss forState:UIControlStateNormal];
            [weakSelf.checkView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
        }
        [weakSelf tapClick];
    };
    popView.backgroundColor = [UIColor whiteColor];
    popView.alpha = 0;
    popView.layer.cornerRadius = 10;
    popView.clipsToBounds = YES;
    [self.view addSubview:popView];
    [popView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.size.equalTo(CGSizeMake(realW(400), realH(500)));
    }];
    self.popView = popView;
}



#pragma mark -- 点击背景消失
-(void)tapClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0;
        self.popView.alpha = 0;
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



#pragma mark -- 选择船舶类型
-(void)shipTypeRequest
{
    if (self.shipTypeDict.count > 0) {
        NSArray * array = [self.shipTypeDict allKeys];
//        XXJLog(@"%@",array);
//        NSMutableArray * keyArray = [NSMutableArray array];
//        NSMutableArray * valueArray = [NSMutableArray array];
//
//        for (NSDictionary * dict in self.shipTypeDict) {
//            [keyArray addObject:[dict allKeys]];
//            [valueArray addObject:[dict allValues]];
//        }
        
        
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"船舶类型" dataSource:[self.shipTypeDict allValues] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            NSString * sss = selectValue;
            
            if ([sss containsString:@"化"]) {
                self.installView.leftLable.text = @"适装证书";
            }
            else
            {
                self.installView.leftLable.text = @"适航证书";
            }
            
            [self.typeView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [self.typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            for (NSInteger i = 0; i < array.count; i++) {
                NSString * selectStr = [self.shipTypeDict allValues][i];
                
                
                
                if ([selectValue isEqualToString:selectStr]) {
                    self.shipID = array[i];
                    break;
                }
            }
            
//            for (NSString * s in array) {
//                NSInteger i = [s integerValue];
//                NSString * selectStr = [self.shipTypeDict allValues][i];
//                if ([selectValue isEqualToString:selectStr]) {
//                    self.shipID = s;
//                    break;
//                }
//            }
            
            
            XXJLog(@"%@",self.shipID)
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
        return;
    }
    
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:ShipType URLMethod:ShipTypeMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        
        NSDictionary * resultDict = (NSDictionary *)result;
        
        self.shipTypeDict = resultDict[@"result"][@"list"];
        
        
        NSArray * array = [self.shipTypeDict allKeys];
//        NSArray * valueArray = [self.shipTypeDict allValues];
//        XXJLog(@"%@",array);
//
//        NSMutableArray * keyNewArray = [NSMutableArray array];
//        NSMutableArray * valueNewArray = [NSMutableArray array];

//        for (NSDictionary * dict in self.shipTypeDict) {
//            [keyArray addObject:[dict allKeys]];
//            [valueArray addObject:[dict allValues]];
//        }
        
//        for (NSString * value in [self.shipTypeDict allValues]) {
//            for (id ss in self.shipTypeDict) {
//
//                [keyNewArray addObject:ss];
//
//
//            }
//        }
        
        
        //类型选择
        [BRStringPickerView showStringPickerWithTitle:@"船舶类型" dataSource:[self.shipTypeDict allValues] defaultSelValue:@"" isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
            
            NSString * sss = selectValue;
            
            if ([sss containsString:@"化"]) {
                self.installView.leftLable.text = @"适装证书";
            }
            else
            {
                self.installView.leftLable.text = @"适航证书";
            }
            
            
            [self.typeView.chooseButton setTitle:selectValue forState:UIControlStateNormal];
            [self.typeView.chooseButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:realW(10)];
            
            for (NSInteger i = 0; i < array.count; i++) {
                NSString * selectStr = [self.shipTypeDict allValues][i];
                if ([selectValue isEqualToString:selectStr]) {
                    self.shipID = array[i];
                    break;
                }
            }
            
//            for (NSString * s in array) {
//                NSInteger i = [s integerValue];
//                NSString * selectStr = [self.shipTypeDict allValues][i];
//                if ([selectValue isEqualToString:selectStr]) {
//                    self.shipID = s;
//                    break;
//                }
//            }
            
            
            
            
            
            XXJLog(@"%@",self.shipID)
            
        } cancelBlock:^{
            NSLog(@"点击了背景视图或取消按钮");
        }];
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
    
}


#pragma mark -- 船舶检查类型
-(void)shipCheckRequest
{
    if (self.checkShipArray.count > 0) {
        return;
    }
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:CheckType URLMethod:CheckTypeMethod parameters:nil finished:^(id result) {
        [SVProgressHUD dismiss];
        XXJLog(@"%@",result)
        
        self.popView.dataArray = result[@"result"];
        
        self.checkShipArray = result[@"result"];
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -- 确认添加请求
-(void)sureClick
{
    __weak typeof(self) weakSelf = self;
    
    if ([[UseInfo shareInfo].nameApprove isEqualToString:@"认证通过"])
    {
        if ([[UseInfo shareInfo].companyApprove isEqualToString:@"认证通过"]) {
            [self addBoat];
            
            return;
        }
        else
        {
            //判断加入的公司
            if ([[UseInfo shareInfo].joinCompanyApprove isEqualToString:@"认证通过"])
            {
                //打电话
                [self addBoat];
                
                return;
            }
            
        }
    }
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"化运网是实名制平台，请认证后再操作" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:@"认证" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        ChooseApproveViewController * approveVc = [[ChooseApproveViewController alloc]init];
        approveVc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:approveVc animated:YES];
        
    }];
    [alertController addAction:rubbishAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    
}


-(void)addBoat
{
    if (self.nameView.textField.text.length == 0) {
        [self.view makeToast:@"请填写船舶名称" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if ([self.typeView.chooseButton.currentTitle isEqualToString:@"请选择船舶类型"] || self.shipID == nil) {
        [self.view makeToast:@"请选择船舶类型" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if ([self.areaView.chooseButton.currentTitle isEqualToString:@"请选择船舶航区"]) {
        [self.view makeToast:@"请选择船舶航区" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if (self.weightView.textField.text.length == 0) {
        [self.view makeToast:@"请填写参考重量" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if (self.volumeView.textField.text.length == 0) {
        [self.view makeToast:@"请填写船舶舱容" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if (self.lengthView.textField.text.length == 0) {
        [self.view makeToast:@"请填写船舶总长" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if (self.widthView.textField.text.length == 0) {
        [self.view makeToast:@"请填写船舶总宽" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if (self.deepView.textField.text.length == 0) {
        [self.view makeToast:@"请填写满载吃水" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if ([self.checkView.chooseButton.currentTitle isEqualToString:@"请选择船舶检查类型"]) {
        [self.view makeToast:@"请选择船舶检查类型" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if (self.dateView.timeLable.text.length == 0) {
        [self.view makeToast:@"请填写建成日期" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    if (self.certificate_file_id == nil) {
        [self.view makeToast:@"请上传船舶主要项目" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if (self.inspect_file_id == nil) {
        [self.view makeToast:@"请上传船舶营运证书" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    if (self.install_file_id == nil) {
        [self.view makeToast:@"请上传适装证书" duration:0.5 position:CSToastPositionCenter];
        
        return;
    }
    
    
    
    
    
    NSString *parameterstring = [NSString stringWithFormat:@"\"name\":\"%@\",\"mmsi\":\"%@\",\"type_id\":\"%@\",\"deadweight\":\"%@\",\"length\":\"%@\",\"width\":\"%@\",\"draught\":\"%@\",\"image_id\":\"\",\"has_cover\":\"\",\"has_crane\":\"\",\"access_token\":\"%@\",\"source\":\"%@\",\"registry\":\"\",\"sailing_area\":\"%@\",\"comlete_time\":\"%@\",\"Inspect_type\":\"%@\",\"Certificate_file_id\":\"%@\",\"Inspect_file_id\":\"%@\",\"owner_file_id\":\"%@\",\"storage\":\"%@\"",
                                 self.nameView.textField.text,
                                 self.mssiView.textField.text,
                                 self.shipID,
                                 self.weightView.textField.text,
                                 self.lengthView.textField.text,
                                 self.widthView.textField.text,
                                 self.deepView.textField.text,
                                 [UseInfo shareInfo].access_token,
                                 @"2",
                                 self.areaView.chooseButton.currentTitle,
                                 [NSString stringWithFormat:@"%ld",
                                  [TYDateUtils timeSwitchTimestamp:self.dateView.timeLable.text andFormatter:@"yyyy-MM-dd"]],
                                 self.checkView.chooseButton.currentTitle,
                                 self.certificate_file_id,
                                 self.inspect_file_id,
                                 self.install_file_id,
                                 self.volumeView.textField.text
                                 ];
    
    
    [SVProgressHUD show];
    
    [XXJNetManager requestPOSTURLString:AddShip URLMethod:AddShipMethod parameters:parameterstring finished:^(id result) {
        
        if ([result[@"result"][@"status"] boolValue]) {
            [SVProgressHUD showWithStatus:@"添加成功"];
            [SVProgressHUD dismissWithDelay:0.5 completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [SVProgressHUD dismiss];
            [self.view makeToast:result[@"result"][@"msg"] duration:0.5 position:CSToastPositionCenter];
        }
        
        
        XXJLog(@"%@",result)
        
        
        
    } errored:^(NSError *error) {
        [self.view makeToast:@"请求异常" duration:0.5 position:CSToastPositionCenter];
        
        [SVProgressHUD dismiss];
    }];
}


-(void)setModel:(MyBoatModel *)model
{
    _model = model;
}







@end
