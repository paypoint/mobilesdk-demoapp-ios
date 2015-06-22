//
//  FormFieldsViewController.m
//  Merchant
//
//  Created by Robert Nash on 23/04/2015.
//  Copyright (c) 2015 Paypoint. All rights reserved.
//

#import "FormFieldsViewController.h"
#import "ColourManager.h"

#import <PayPointPayments/PPOValidator.h>

@interface FormFieldsViewController () <PaymentEntryFieldsManagerDelegate>
@property (nonatomic, strong) PaymentEntryFieldsManager *fieldsManager;
@end

@implementation FormFieldsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.form = [FormDetails new];
    
    self.fieldsManager = [PaymentEntryFieldsManager new];
    self.fieldsManager.delegate = self;
    self.fieldsManager.textFields = self.textFields;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [self.view addGestureRecognizer:tap];
}

-(IBAction)textFieldEditingChanged:(FormField *)sender forEvent:(UIEvent *)event {
    
    switch (sender.tag) {
            
        case TEXT_FIELD_TYPE_CARD_NUMBER: {
            self.form.cardNumber = sender.text;
            [self.fieldsManager reformatAsCardNumber:sender];
        }
            break;
            
        case TEXT_FIELD_TYPE_CVV:
            self.form.cvv = sender.text;
            break;
            
        case TEXT_FIELD_TYPE_AMOUNT:
            self.form.amount = (sender.text.length) ? @(sender.text.doubleValue) : nil;
            break;
            
        default:
            break;
    }

}

#pragma mark - Actions

-(void)backgroundTapped:(UITapGestureRecognizer*)gesture {
    [self.view endEditing:YES];
}

#pragma mark - PaymentEntryFieldsManager Delegate

-(void)paymentEntryFieldsManager:(PaymentEntryFieldsManager *)manager didUpdateCardNumber:(NSString *)cardNumber {
    self.form.cardNumber = cardNumber;
}

-(void)paymentEntryFieldsManager:(PaymentEntryFieldsManager *)manager didUpdateCVV:(NSString *)cvv {
    self.form.cvv = cvv;
}

-(void)paymentEntryFieldsManager:(PaymentEntryFieldsManager *)manager didUpdateExpiryDate:(NSString *)expiryDate {
    self.form.expiry = expiryDate;
}

-(void)paymentEntryFieldsManager:(PaymentEntryFieldsManager *)manager didUpdateAmount:(NSNumber *)amount {
    self.form.amount = amount;
}

-(void)paymentEntryFieldsManager:(PaymentEntryFieldsManager *)manager textFieldDidEndEditing:(FormField *)textField {
    
    NSError *error;
    
    TEXT_FIELD_TYPE type = 0;
    
    if ((self.textFields[TEXT_FIELD_TYPE_CARD_NUMBER] == textField)) {
        type = TEXT_FIELD_TYPE_CARD_NUMBER;
        error = [PPOValidator validateCardPan:textField.text];
    } else if ((self.textFields[TEXT_FIELD_TYPE_EXPIRY] == textField)) {
        type = TEXT_FIELD_TYPE_EXPIRY;
        error = [PPOValidator validateCardExpiry:textField.text];
    } else if ((self.textFields[TEXT_FIELD_TYPE_CVV] == textField)) {
        type = TEXT_FIELD_TYPE_CVV;
        error = [PPOValidator validateCardCVV:textField.text];
    }
    
    if (textField.text.length == 0) {
        [self.fieldsManager resetTextFieldBorderOfType:type];
    } else {
        if (error) {
            [self.fieldsManager highlightTextFieldBorderInactive:type];
        } else {
            [self.fieldsManager highlightTextFieldBorderActive:type];
        }
    }
}

@end
