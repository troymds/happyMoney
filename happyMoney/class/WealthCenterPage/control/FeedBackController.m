//
//  FeedBackController.m
//  happyMoney
//  意见反馈 
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "FeedBackController.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface FeedBackController ()<UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *_hit;
}
@end

@implementation FeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"意见反馈 ";
    
    CGFloat startX = 42/2;
    CGFloat startY = 58/2;
    CGFloat iconWH = 152/2;
    
    //1 icon
    UIImageView *icon = [[UIImageView alloc] initWithFrame:Rect(startX, startY, iconWH, iconWH)];
    [self.view addSubview:icon];
    [icon setImage:LOADPNGIMAGE(@"load_big.png")];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = iconWH/2;
    icon.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [icon setImageWithURL:[NSURL URLWithString:[SystemConfig sharedInstance].user.avatar]
        placeholderImage:placeHoderImage];
    
    CGFloat labelX = CGRectGetMaxX(icon.frame) + 10;
    CGFloat labelY = startY + iconWH/4 - 5;
    CGFloat labelW = kWidth - labelX - 10;
    CGFloat lableH = iconWH/1.5;
    UILabel *instruction = [[UILabel alloc] initWithFrame:Rect(labelX, labelY, labelW, lableH)];
    [self.view addSubview:instruction];
    instruction.text = @"无论何时您的美丽自信是我们最大的心愿。";
    instruction.backgroundColor = [UIColor clearColor];
    instruction.textColor = HexRGB(0x3a3a3a);
    instruction.font = [UIFont boldSystemFontOfSize:18];
    instruction.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:instruction.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [instruction.text length])];
    instruction.attributedText = attributedString;
    [instruction sizeToFit];
    
//    instruction.adjustsFontSizeToFitWidth = YES;
    //2 UITextView
    CGFloat textX  = startX / 2;
    CGFloat textY = CGRectGetMaxY(icon.frame) + startY;
    CGFloat tectW = kWidth - textX * 2;
    CGFloat textH = 272/2;
    UITextView *textView = [[UITextView alloc] initWithFrame:Rect(textX, textY, tectW, textH)];
    [self.view addSubview:textView];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:PxFont(Font22)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 5.0;
    _textView = textView;
    
    CGFloat hitX = textX + 5;
    CGFloat hitW = tectW - hitX - 5;
    UILabel *hit = [[UILabel alloc] initWithFrame:Rect(hitX, textY + 2, hitW, 40)];
    [self.view addSubview:hit];
    hit.text = @"请在这里写下您的宝贵意见，来帮助我们提供给您更好的服务";
    hit.numberOfLines = 0;
    hit.enabled = YES;
    hit.font = [UIFont systemFontOfSize:PxFont(Font22)];
    hit.backgroundColor = [UIColor clearColor];
    hit.textColor = HexRGB(0x808080);
    _hit = hit;
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:done];
    done.layer.masksToBounds = YES;
    done.layer.cornerRadius = 5.0;
    done.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    done.frame = Rect(startX, CGRectGetMaxY(textView.frame) + 15, kWidth - startX * 2, 40);
    [done setTitle:@"提交反馈" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(sumbitFeed) forControlEvents:UIControlEventTouchUpInside];
    done.backgroundColor = ButtonColor;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        _hit.hidden = YES;
    }else
    {
        _hit.hidden = NO;
    }
}

-(void)sumbitFeed
{
    if (_textView.text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;

        [self.view endEditing:YES];
        
        NSDictionary *parms  = [NSDictionary dictionaryWithObjectsAndKeys:_textView.text,@"content", nil];
        
        [HttpTool postWithPath:@"postSuggest" params:parms success:^(id JSON, int code) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if (code == 100) {
                NSString *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
                [RemindView showViewWithTitle:data location:MIDDLE];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }else
    {
        [RemindView showViewWithTitle:@"请输入反馈内容" location:MIDDLE];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
