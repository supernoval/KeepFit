//
//  CircleProgressView.m
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#define kLabelHeight 20.0
#define kHelveticaNeue    @"HelveticaNeue"
#define kHelveticaNeue_Bold  @"HelveticaNeue-Bold"

#import "CircleProgressView.h"
#import "CircleShapeLayer.h"

@interface CircleProgressView()

@property (nonatomic, strong) CircleShapeLayer *progressLayer;
@property (strong, nonatomic) UILabel *stepsLabel;
@property (nonatomic,strong) UILabel *stepTitleLabel;
@property (nonatomic,strong) UILabel *walkingDisLabel;


@end

@implementation CircleProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.progressLayer.frame = self.bounds;
    
//    [self.progressLabel sizeToFit];
//    self.progressLabel.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y- self.frame.origin.y);
    
    [self.stepsLabel sizeToFit];
    
}

- (void)updateConstraints {
    [super updateConstraints];
}

-(UILabel*)stepsLabel
{
    if (!_stepsLabel) {
        
        _stepsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - kLabelHeight/2, self.frame.size.width, kLabelHeight)];
        _stepsLabel.numberOfLines = 1;
        _stepsLabel.textAlignment = NSTextAlignmentCenter;
        _stepsLabel.font = [UIFont fontWithName:kHelveticaNeue size:20];
        _stepsLabel.textColor = [UIColor blackColor];
        
        [self addSubview:_stepsLabel];
        
        
    }
    
    return _stepsLabel;
    
}
-(UILabel*)stepTitleLabel
{
    if (!_stepTitleLabel) {
        
        _stepTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.frame.size.height/4, self.bounds.size.width, kLabelHeight)];
        _stepTitleLabel.numberOfLines = 1;
        _stepTitleLabel.textAlignment = NSTextAlignmentCenter;
        _stepTitleLabel.text = @"步数";
        _stepTitleLabel.font = [UIFont fontWithName:kHelveticaNeue size:15];
        _stepTitleLabel.textColor = [UIColor darkGrayColor];
        
        [self addSubview:_stepTitleLabel];
        
    }
    
    return _stepTitleLabel;
    
}

-(UILabel*)walkingDisLabel
{
    if (!_walkingDisLabel) {
        
    _walkingDisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - kLabelHeight/2, self.frame.size.width, kLabelHeight)];
        _walkingDisLabel.numberOfLines = 0;
        _walkingDisLabel.textAlignment = NSTextAlignmentCenter;
        _walkingDisLabel.font = [UIFont fontWithName:kHelveticaNeue size:15];
        _walkingDisLabel.textColor = [UIColor darkGrayColor];
      
        [self addSubview:_walkingDisLabel];
        
        
    }
    
    return _walkingDisLabel;
    
}
- (double)percent {
    return self.progressLayer.percent;
}

- (CGFloat)currentDistance {
    return self.progressLayer.currentDistance;
}

-(void)setCurrentDistance:(CGFloat)currentDistance
{
    self.progressLayer.currentDistance = currentDistance;
    
//    _stepsLabel.attributedText = [self getstepslabelString:currentDistance];
    
    _stepsLabel.text = @"5161616";
    
    
}


-(void)setExpectedDistance:(CGFloat)expectedDistance{
    
    _expectedDistance = expectedDistance;
    
    self.progressLayer.expectedDistance = expectedDistance;
    
   
   
    
}


#pragma mark - Private Methods

- (void)setupViews {
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = false;
    
    //add Progress layer
    self.progressLayer = [[CircleShapeLayer alloc] init];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.progressLayer];
    [self stepsLabel];
    
  
    
    
    
}

- (void)setTintColor:(UIColor *)tintColor {
    self.progressLayer.progressColor = tintColor;

}

-(NSAttributedString*)getstepslabelString:(CGFloat)steps
{
    
    NSString *stepsStr = [NSString stringWithFormat:@"%.0f",steps];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",stepsStr]];
    
    
    [muStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:20],NSStrokeColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0,stepsStr.length)];
    
    return muStr;
}

-(NSMutableAttributedString*)getdistanceString:(CGFloat)distance
{
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"步行%.0f千米",distance]];
    
    
    return muStr;
    
    
}

- (NSAttributedString *)gettextlabelString:(CGFloat)currentdistance steps:(CGFloat)steps {
    
    NSMutableParagraphStyle *muparagraph = [[NSMutableParagraphStyle alloc]init];
    [muparagraph setLineSpacing:10];
    [muparagraph setAlignment:NSTextAlignmentCenter];
    
    
    NSString *stepsStr = [NSString stringWithFormat:@"%.0f",steps];
    NSString *disStr = [NSString stringWithFormat:@"步行%.0f千米",currentdistance];
    
    
  
    _distancetext = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"步数\n%@\n%@",stepsStr,disStr]];
        
        
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15],NSStrokeColorAttributeName:[UIColor darkGrayColor]} range:NSMakeRange(0,2)];
        
    
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15],NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(stepsStr.length +1, disStr.length +3)];
    
    [_distancetext addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(2, stepsStr.length +2 )];
    NSLog(@"distanceLenth:%ld",(long)disStr.length);
    
    

    
 
    
    return _distancetext;
}


@end
