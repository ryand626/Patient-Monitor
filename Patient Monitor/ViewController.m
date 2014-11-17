//
//  ViewController.m
//  Patient Monitor
//
//  Created by Ryan Dougherty on 11/5/14.
//  Copyright (c) 2014 team3. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialize_dimentions];
    
    [self addDefaultViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Set the dimentions of the frames when the view first loads
-(void)initialize_dimentions{
    // Position of the lower bar as a percentage of the screen
    float lower_bar_scale = .80;
    // Position of the right bar as a percentage of the screen
    float right_bar_scale = .70;
    // Number of breaks in the side view
    number_of_side_doopies = 3;
    // Number of breaks in the main view
    number_of_main_view_breaks = 0;
    
    // Get window data
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Set Main View Bounds
    main_view_x = 0;
    main_view_y = 0;
    main_view_width = window.frame.size.width*right_bar_scale;
    main_view_height = window.frame.size.height*lower_bar_scale;
    
    // Set Bottom (Options) Bar Bounds
    bottom_bar_x = 0;
    bottom_bar_y = window.frame.size.height*lower_bar_scale;
    bottom_bar_width = window.frame.size.width;
    bottom_bar_height = window.frame.size.height*(1-lower_bar_scale);
    
    // Set Side Bar Bounds
    hilight_view_x = window.frame.size.width*right_bar_scale;
    hilight_view_y = 0;
    hilight_view_width = window.frame.size.width*(1-right_bar_scale);
    hilight_view_height = window.frame.size.height*lower_bar_scale;
}

// Create the bounds where elements will be drawn
-(void)addDefaultViews{
    main_view = [[UIView alloc] initWithFrame:CGRectMake(main_view_x, main_view_y, main_view_width, main_view_height)];
    [main_view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:main_view];
    
    hilight_view = [[UIView alloc] initWithFrame:CGRectMake(hilight_view_x, hilight_view_y, hilight_view_width, hilight_view_height)];
    [hilight_view setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:hilight_view];
    
    bottom_bar = [[UIView alloc] initWithFrame:CGRectMake(bottom_bar_x, bottom_bar_y, bottom_bar_width, bottom_bar_height)];
    [bottom_bar setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:bottom_bar];
    
    [self updateEKG];
    [self updateSPO2];
    [self updatePULSE];
    [self updateTEMPERATURE];
    
    [self.view addSubview:EKG];
    [self.view addSubview:SPO2];
    [self.view addSubview:PULSE];
    [self.view addSubview:TEMPERATURE];
    
    [self.view addSubview:EKG_Button];
    [self.view addSubview:SPO2_Button];
    [self.view addSubview:PULSE_Button];
    [self.view addSubview:TEMPERATURE_Button];
}

-(void)updateEKG{
    float x = main_view_x;
    float y = main_view_y;
    float width = main_view_width;
    float height = main_view_height;
    
    EKG = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [EKG setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ekg.png"]]];
    
    EKG_Button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 100, 100)];
    [EKG_Button setBackgroundImage:[UIImage imageNamed:@"ekgicon.png" ] forState:UIControlStateNormal];
}

-(void)updateSPO2{
    float x = hilight_view_x;
    float y = hilight_view_y;
    float width = hilight_view_width;
    float height = hilight_view_height/number_of_side_doopies;
    
    SPO2 = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [SPO2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"spo2.png"]]];
    
    SPO2_Button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
    [SPO2_Button setBackgroundImage:[UIImage imageNamed:@"SpO2icon.png"] forState:UIControlStateNormal];
}

-(void)updatePULSE{
    float x = hilight_view_x;
    float y = hilight_view_y+hilight_view_height/number_of_side_doopies;
    float width = hilight_view_width;
    float height = hilight_view_height/number_of_side_doopies;
    
    PULSE = [[UIView alloc] initWithFrame:CGRectMake(x, y, width,height)];
    [PULSE setBackgroundColor:[UIColor magentaColor]];
    
    PULSE_Button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
    [PULSE_Button setBackgroundImage:[UIImage imageNamed:@"pulseicon.png"] forState:UIControlStateNormal];
}

-(void)updateTEMPERATURE{
    float x = hilight_view_x;
    float y = hilight_view_y+2*hilight_view_height/number_of_side_doopies;
    float width = hilight_view_width;
    float height = hilight_view_height/number_of_side_doopies;
    
    TEMPERATURE = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [TEMPERATURE setBackgroundColor:[UIColor redColor]];
    
    TEMPERATURE_Button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
    [TEMPERATURE_Button setBackgroundImage:[UIImage imageNamed:@"thermometericon.png"] forState:UIControlStateNormal];
}

@end
