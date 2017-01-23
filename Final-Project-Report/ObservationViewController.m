//
//  ObservationViewController.m
//  Final-Project-Report
//
//  Created by Parker Malachowsky on 12/12/16.
//  pmalacho@usc.edu
//  Copyright © 2016 Parker Malachowsky. All rights reserved.
//

#import "ObservationViewController.h"

@interface ObservationViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate>
//On save, will add the entry to the observations array
//will write to plist in documents folder
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

//IBOutlets from storyboard
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *situationTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@end

@implementation ObservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //observation entry can't be saved until both the text field and text view have been adressed
    self.saveButton.enabled = NO;
    
    //setting view controller as delegate for each
    self.nameTextField.delegate = self;
    self.situationTextView.delegate = self;
    
    //set texts
    self.nameTextField.placeholder = self.placeHolderText;
    self.instructionLabel.text = self.labelText;
    
}

//runs cancel handler
- (IBAction)cancelTapped:(id)sender {
    if (self.onCancelHandler){
        self.onCancelHandler();
    }
}

//runs complete handler
- (IBAction)saveTapped:(id)sender {
    //pass in user data to completion handler defined in prepareForSegue of TableViewController
    if (self.completionHandler){
        self.completionHandler(self.nameTextField.text, self.situationTextView.text, self.datePicker.date);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //open keyboard
    [self.nameTextField becomeFirstResponder];
    
}

//textfield delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    //close keyboard
    [textField resignFirstResponder];
    return YES;
};



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITextFieldDelegate methods

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //get string of textview/situation description
    NSString *latestSitatuationStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    
    // Determine if we should enable the save button
    [self updateSaveButtonStatusWithName: self.nameTextField.text andSituation: latestSitatuationStr];
    
    //close keyboard
    if ( [text isEqualToString:@"\n"] ) {
        [self.situationTextView resignFirstResponder];
    }
    return YES;
    
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //get string of textfield/name of youth
    NSString *latestNameStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    // Determine if we should enable the save button
    [self updateSaveButtonStatusWithName: latestNameStr andSituation: self.situationTextView.text];
    
    //move on to to text view
    if ( [string isEqualToString:@"\n"] ) {
        [self.situationTextView becomeFirstResponder];
    }
    
    return YES;
}

// MARK : - UITextViewDelegate


- (void)updateSaveButtonStatusWithName:(NSString *)name andSituation:(NSString *)situation{
    
    //user has inputted both things
    self.saveButton.enabled = (name.length > 0 && situation.length > 0);
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // dismiss keyboard when background is touched
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
