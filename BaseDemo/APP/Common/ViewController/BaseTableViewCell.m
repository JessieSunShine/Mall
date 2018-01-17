//
//  BaseTableViewCell.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier{
    
    BaseTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell=[[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupCustomUI];
        
    }
    
    return self;
}


-(void)setupCustomUI{
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
