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
@property (weak, nonatomic) IBOutlet PaymentFormField *textField;
@end

@implementation PaymentTableViewCell

-(void)awakeFromNib {
    self.actionButton.accessibilityLabel = @"PayNowButton";
    
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:30.0f],
                          NSForegroundColorAttributeName : [UIColor darkGrayColor]
                          };
    
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"100.00" attributes:dic];

}

-(IBAction)actionButtonPressed:(ActionButton*)button {
    [self.delegate paymentTableViewCell:self actionButtonPressed:button];
}

-(void)configureWithForm:(FormDetails *)form {
    self.form = form;
}

+(CGFloat)rowHeight {
    return 117.0f;
}

- (IBAction)textFieldEditingChanged:(PaymentFormField *)sender {
    self.form.amount = (sender.text.length) ? @(sender.text.doubleValue) : nil;
}

@end
