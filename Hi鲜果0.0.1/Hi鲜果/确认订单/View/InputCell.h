//
//  InputCell.h
//  Hi鲜果
//
//  Created by rimi on 15/7/8.
//  Copyright (c) 2015年 Hi fruit. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, InputCellType) {
    InputCellTypeScore,
    InputCellTypeInvoice
};

@protocol InputCellDelegate <NSObject>

- (void)inputCellType:(InputCellType)type content:(NSString *)content;

@end

@interface InputCell : UITableViewCell<UITextFieldDelegate>

@property (assign, nonatomic) InputCellType type;

@property (weak, nonatomic) id<InputCellDelegate> delegate;

@end
