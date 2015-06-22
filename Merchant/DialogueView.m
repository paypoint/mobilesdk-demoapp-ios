//
//  DialogueView.m
//  Merchant
//
//  Created by Robert Nash on 22/06/2015.
//  Copyright (c) 2015 Paypoint. All rights reserved.
//

#import "DialogueView.h"
#import "ColourManager.h"
#import "TitleLabel.h"

@interface DialogueView ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet TitleLabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleViewTitleLabel;
@end

@implementation DialogueView

+(instancetype)dialogueView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DialogueView class])
                                         owner:self
                                       options:nil].lastObject;
    
}

-(void)awakeFromNib {
    self.titleView.backgroundColor = [ColourManager ppBlue];
    self.titleViewTitleLabel.font = [UIFont fontWithName: @"FoundryContext-Regular" size: 18];
    self.titleViewTitleLabel.textColor = [UIColor whiteColor];
}

- (IBAction)closeButtonPressed:(ActionButton *)sender {
    if (self.actionButtonHandler) self.actionButtonHandler(sender);
}

-(void)updateBody:(NSString *)text updateTitle:(NSString *)title {
    self.messageLabel.text = text;
    self.titleViewTitleLabel.text = title;
}

@end