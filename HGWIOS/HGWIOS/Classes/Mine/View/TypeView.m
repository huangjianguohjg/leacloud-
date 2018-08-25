//
//  TypeView.m
//  HGWIOS
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 Developer. All rights reserved.
//

#import "TypeView.h"
#import "SelectTableViewCell.h"
@interface TypeView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * selectArray;

@end

@implementation TypeView

-(NSMutableArray *)selectArray
{
    if (_selectArray == nil) {
        self.selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
//    UIScrollView * scrollView = [[UIScrollView alloc]init];
//    scrollView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:scrollView];
//    [scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.equalTo(self);
//    }];
//    _scrollView = scrollView;
    
    
    UITableView * tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = realH(88);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [tableView registerClass:[SelectTableViewCell class] forCellReuseIdentifier:@"SelectTableViewCell"];
    tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(realH(10));
        make.bottom.equalTo(self).offset(realH(-100));
//        make.right.equalTo(self).offset(realW(-10));
//        make.left.equalTo(self).offset(realW(10));
        make.top.left.right.equalTo(self);
    }];
    self.tableView = tableView;
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5;
    [self addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tableView.bottom);
        make.right.left.equalTo(self);
        make.height.equalTo(realH(1));
    }];
    
    UIButton * cancelButton = [[UIButton alloc]init];
    [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self addSubview:cancelButton];
    [cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(-realW(100));
        make.top.equalTo(tableView.bottom).offset(realH(10));
    }];
    
    UIButton * okButton = [[UIButton alloc]init];
    [okButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont fontWithName:PingFangSc_Regular size:realFontSize(32)];
    [self addSubview:okButton];
    [okButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(realW(100));
        make.top.equalTo(tableView.bottom).offset(realH(10));
    }];
    
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    SelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"SelectTableViewCell%ld",indexPath.row]];
    if (cell == nil) {
        cell = [[SelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"SelectTableViewCell%ld",indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.selectButton setTitle:self.dataArray[indexPath.row] forState:UIControlStateNormal];
    
    if (indexPath.row == 0) {
        cell.selectButton.selected = YES;
        cell.userInteractionEnabled = NO;
    }
    
    
    if (self.selectArray.count == 0) {
        cell.selectButton.selected = NO;
        if (indexPath.row == 0) {
            cell.selectButton.selected = YES;
            cell.userInteractionEnabled = NO;
        }
    }
    
    
    
    __block CGFloat tempS = 0;
    
    cell.selectBlock = ^(NSString *ss) {
        for (NSString * s in weakSelf.selectArray) {
            if ([ss isEqualToString:s]) {
                [weakSelf.selectArray removeObject:s];
                tempS = 1;
                break;
            }
            
        }
        
        if (tempS == 0) {
            [weakSelf.selectArray addObject:ss];
        }
        
        tempS = 0;
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SelectTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    cell.selectButton.selected = !cell.selectButton.selected;
//
//
//        CGFloat tempS = 0;
//
//        for (NSString * s in self.selectArray) {
//            if ([cell.selectButton.currentTitle isEqualToString:s]) {
//                [self.selectArray removeObject:s];
//                tempS = 1;
//                break;
//            }
//
//        }
//
//        if (tempS == 0) {
//            [self.selectArray addObject:cell.selectButton.currentTitle];
//        }
    

    
}




#pragma mark -- 取消 确定 点击
-(void)buttonClick:(UIButton *)button
{
    if ([button.currentTitle isEqualToString:@"取消"]) {
        if (self.okBlock) {
            self.okBlock(@"取消");
        }
    }
    else
    {
        NSString * tempStr = @"船舶运费";
        NSString * otherStr = nil;
        if (self.selectArray.count > 0) {
            for (NSInteger i = 0; i < self.selectArray.count; i++) {
                
                NSString * s = self.selectArray[i];
                
                if ([s isEqualToString:@"其他"]) {
                    otherStr = s;
                }
                else
                {
                    tempStr = [NSString stringWithFormat:@"%@,%@", tempStr,self.selectArray[i]];
                }
            }
            
            if (otherStr) {
                tempStr = [tempStr stringByAppendingString:@",其他"];
            }
            
            
            
        }
        
        if (self.okBlock) {
            self.okBlock(tempStr);
        }
        
        XXJLog(@"%@",tempStr)
        
    }
}


-(void)setClear:(NSString *)clear
{
    _clear = clear;
    
    [self.selectArray removeAllObjects];
    
    for (NSInteger i = 1; i < self.dataArray.count; i++) {
        SelectTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.selectButton.selected = NO;
    }
}








@end
