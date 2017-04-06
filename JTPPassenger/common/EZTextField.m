
#import "EZTextField.h"
#import "Constants.h"

@implementation EZTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.textColor = [UIColor whiteColor];

        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self setValue:TEXTFIELD_PLACEHOLDER_TEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        
        self.layer.cornerRadius = EZ_CORNER_RADIUS;
        self.layer.borderWidth = EZ_BORDER_WIDTH;
        self.layer.borderColor = [TEXTFIELD_BORDER_COLOR CGColor];
        self.textColor = [UIColor blackColor];
    }
    return self;
}
/*
- (void)drawRect:(CGRect)rect {
    self.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor whiteColor]);
    self.layer.borderWidth = 2.0f;
}*/

- (BOOL)validateTextWithRegularExpression:(NSString *)regExpression
{
    NSPredicate *validateTextPridicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExpression];
    BOOL isValid = [validateTextPridicate evaluateWithObject:[self.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
    
    [self changeBorderColor:isValid];
    return isValid;
}
-(BOOL)isEmptyTextCheck
{
    BOOL isValid = [[self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
    
    [self changeBorderColor:isValid];
    return isValid;
}
- (void)changeBorderColor:(BOOL)isValid
{
    self.layer.cornerRadius = EZ_CORNER_RADIUS;
    self.layer.borderWidth = EZ_BORDER_WIDTH;
    self.layer.borderColor = [TEXTFIELD_BORDER_COLOR CGColor];
    
    if (isValid) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
}
@end
