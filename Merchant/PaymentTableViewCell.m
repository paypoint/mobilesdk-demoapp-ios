//
//  PaymentTableViewCell.m
//  Merchant
//
//  Created by Robert Nash on 22/06/2015.
//  Copyright (c) 2015 Paypoint. All rights reserved.
//

#import "PaymentTableViewCell.h"
#import "PaymentFormField.h"
#import "FormDetails.h"
@interface PaymentTableViewCell ()
@property (weak, nonatomic) IBOutlet ActionButton *actionButton;
@property (nonatomic, weak) FormDetails *form;
@end

@implementation PaymentTableViewCell

-(void)awakeFromNib {
    self.actionButton.accessibilityLabel = @"PayNowButton";
}

-(IBAction)actionButtonPressed:(ActionButton*)button {
    [self.delegate paymentTableViewCell:self actionButtonPressed:button];
}

-(void)configureWithForm:(FormDetails *)form {
    self.form = form;
}

- (IBAction)textFieldEditingChanged:(PaymentFormField *)sender {
    self.form.amount = (sender.text.length) ? @(sender.text.doubleValue) : nil;
}

@end