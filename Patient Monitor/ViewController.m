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
    //[self loadSoundFiles];

    [self initialize_dimentions];
    [self addDefaultViews];    
    [self initializeGraphs];
    [self.view bringSubviewToFront:SPO2_Button];
    [self makeAlarmWindow];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) makeAlarmWindow{
    float window_width = 400;
    float window_height = 400;
    float frame_height = 100;
    
    // Create the window frame
    alarmWindow = [[UIView alloc]initWithFrame:CGRectMake(window.frame.size.width/2-window_width/2, main_view_height/2-window_height/2, window_width, window_height)];
    [alarmWindow setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:alarmWindow];
    
    // Create Menu Bar
    alarmText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, alarmWindow.frame.size.width, frame_height)];
    
    // Change settings of menu bar
    [alarmText setTextAlignment:NSTextAlignmentCenter];
    [alarmText setText:@"Alarm Settings"];
    [alarmText setBackgroundColor:[UIColor lightGrayColor]];
    [alarmText setFont:[alarmText.font fontWithSize:32]];
    // Add menu bar to view
    [alarmWindow addSubview:alarmText];
    
    // Create List Scrollable options List
    alarmOptionsTable = [[UITableView alloc]initWithFrame:CGRectMake(0, frame_height, window_width, window_height-frame_height)];
    [alarmWindow addSubview:alarmOptionsTable];
    
    
    // Set up display toggle in options bar
    isWindowUp = false;
    [self.view sendSubviewToBack:alarmWindow];
    
    UITableViewCell* tableCell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, window_width, 40)];
    [tableCell setBackgroundColor:[UIColor redColor]];
}

// Set the dimentions of the frames when the view first loads
-(void)initialize_dimentions{
    // Position of the lower bar as a percentage of the screen
    float lower_bar_scale = .90;
    // Position of the right bar as a percentage of the screen
    float right_bar_scale = .70;
    // Number of breaks in the side view
    number_of_side_doopies = 3;
    // Number of breaks in the main view
    number_of_main_view_breaks = 0;
    // Buttons
    button_width = 100;
    button_height = 100;
    
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
    side_view_x = window.frame.size.width*right_bar_scale;
    side_view_y = 0;
    side_view_width = window.frame.size.width*(1-right_bar_scale);
    side_view_height = window.frame.size.height*lower_bar_scale;
}

-(void)initializeGraphs{
    graphData = [[TheData alloc] init];
    
    EKG_Graph = [[Graph alloc] initWithFrame:main_view.frame];
    SPO2_Graph = [[Graph alloc] initWithFrame:SPO2.frame];
    
    
    [EKG_Graph.graphXData addObjectsFromArray:[graphData getDataX]];
    [EKG_Graph.graphYData addObjectsFromArray:[graphData getDataY]];
    [self.view addSubview:EKG_Graph];
    [EKG_Graph setGraphColor:[UIColor blackColor] WithShapeColor:[UIColor orangeColor]];
    
    [SPO2_Graph.graphXData addObjectsFromArray:[graphData getDataX]];
    [SPO2_Graph.graphYData addObjectsFromArray:[graphData getDataY]];
    [self.view addSubview:SPO2_Graph];
    [SPO2_Graph setGraphColor:[UIColor blackColor] WithShapeColor:[UIColor blueColor]];
    
    main_graph = EKG_Graph;
}

// Create the bounds where elements will be drawn
-(void)addDefaultViews{
    main_view = [[UIView alloc] initWithFrame:CGRectMake(main_view_x, main_view_y, main_view_width, main_view_height)];
    //[main_view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:main_view];
    
    side_view = [[UIView alloc] initWithFrame:CGRectMake(side_view_x, side_view_y, side_view_width, side_view_height)];
    //[side_view setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:side_view];
    
    [self makeBottomBar];
    
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
-(void)makeBottomBar{
    layout_index = 0;
    
    bottom_bar = [[UIView alloc] initWithFrame:CGRectMake(bottom_bar_x, bottom_bar_y, bottom_bar_width, bottom_bar_height)];
    [bottom_bar setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:bottom_bar];
    
    // Add a layout button
    layout = [[UIButton alloc]initWithFrame:CGRectMake(bottom_bar_width/2-button_width/2, bottom_bar_height/2-button_height/2, button_width, button_height)];
    [layout addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [layout setBackgroundImage:[UIImage imageNamed:@"settingsicon.png" ] forState:UIControlStateNormal];
    [bottom_bar addSubview:layout];
    
    // Add Text to the layout button
    UILabel *layoutText = [[UILabel alloc] initWithFrame:CGRectMake(bottom_bar_x+300, bottom_bar_y,300,bottom_bar_height)];
    [layoutText setText:@"Change Layout:"];
    [layoutText setTextColor: [UIColor whiteColor]];
    [self.view addSubview:layoutText];
    [self.view bringSubviewToFront:layoutText];
    
    // Make alarm options button
    alarmOptions = [[UIButton alloc]initWithFrame:CGRectMake(bottom_bar_width/2-button_width/2+button_width*2, bottom_bar_height/2-button_height/2, button_width, button_height)];
    [alarmOptions addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [alarmOptions setBackgroundImage:[UIImage imageNamed:@"settingsicon.png" ] forState:UIControlStateNormal];
    [bottom_bar addSubview:alarmOptions];
    
}

-(void)updateEKG{
    float x = main_view_x;
    float y = main_view_y;
    float width = main_view_width;
    float height = main_view_height;
    
    EKG = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    EKG_Button = [[UIButton alloc]initWithFrame:CGRectMake(x+width-button_width, y, button_width, button_height)];
    [EKG_Button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [EKG_Button setBackgroundImage:[UIImage imageNamed:@"ekgicon.png" ] forState:UIControlStateNormal];

    main_view = EKG;
    main_button = EKG_Button;
}

-(void)updateSPO2{
    float x = side_view_x;
    float y = side_view_y;
    float width = side_view_width;
    float height = side_view_height/number_of_side_doopies;
    
    SPO2 = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    SPO2_Button = [[UIButton alloc]initWithFrame:CGRectMake(x+width-button_width, y, button_width, button_height)];
    [SPO2_Button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [SPO2_Button setBackgroundImage:[UIImage imageNamed:@"SpO2icon.png"] forState:UIControlStateNormal];
}

-(void)updatePULSE{
    float x = side_view_x;
    float y = side_view_y+side_view_height/number_of_side_doopies;
    float width = side_view_width;
    float height = side_view_height/number_of_side_doopies;
    
    PULSE = [[UIView alloc] initWithFrame:CGRectMake(x, y, width,height)];
    [PULSE setBackgroundColor:[UIColor magentaColor]];
    
    PULSE_Button = [[UIButton alloc]initWithFrame:CGRectMake(x+width-button_width, y, button_width, button_height)];
    [PULSE_Button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [PULSE_Button setBackgroundImage:[UIImage imageNamed:@"pulseicon.png"] forState:UIControlStateNormal];
}

-(void)updateTEMPERATURE{
    float x = side_view_x;
    float y = side_view_y+2*side_view_height/number_of_side_doopies;
    float width = side_view_width;
    float height = side_view_height/number_of_side_doopies;
    
    TEMPERATURE = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [TEMPERATURE setBackgroundColor:[UIColor redColor]];
    
    TEMPERATURE_Button = [[UIButton alloc]initWithFrame:CGRectMake(x+width-button_width, y, button_width, button_height)];
    [TEMPERATURE_Button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [TEMPERATURE_Button setBackgroundImage:[UIImage imageNamed:@"thermometericon.png"] forState:UIControlStateNormal];
}

// TODO: Make this better by using the number of children of the view in a for loop to condense the code
-(void) buttonClicked:(UIButton*)sender
{
    CGRect tempFrame = main_view.frame;
    //Graph *tempGraph = main_graph;
    CGRect tempButton = main_button.frame;
    [self.view sendSubviewToBack: main_view];
    if(sender == EKG_Button){
        if(main_view != EKG){
            
            [main_view setFrame:EKG.frame];
            [main_button setFrame:EKG_Button.frame];
            [main_graph setFrame:EKG.frame];
            [main_graph resize];
            
            [EKG setFrame:tempFrame];
            [EKG_Button setFrame:tempButton];
            [EKG_Graph setFrame:EKG.frame];
            
            main_view = EKG;
            main_button = EKG_Button;
            main_graph = EKG_Graph;
            [EKG_Graph resize];
            
        }
    }
    if(sender == SPO2_Button){
        if(main_view != SPO2){
            [main_view setFrame:SPO2.frame];
            [main_button setFrame:SPO2_Button.frame];
            [main_graph setFrame:SPO2.frame];
            [main_graph resize];
            
            [SPO2 setFrame:tempFrame];
            [SPO2_Button setFrame:tempButton];
            [SPO2_Graph setFrame:SPO2.frame];

            main_view = SPO2;
            main_button = SPO2_Button;
            main_graph = SPO2_Graph;
            [SPO2_Graph resize];
        }
    }
    if(sender == PULSE_Button){
        if(main_view != PULSE){
            [main_view setFrame:PULSE.frame];
            [main_button setFrame:PULSE_Button.frame];
            [main_graph setFrame:PULSE.frame];
            [main_graph resize];
            
            [PULSE setFrame:tempFrame];
            [PULSE_Button setFrame:tempButton];

            main_view = PULSE;
            main_button = PULSE_Button;
            main_graph = nil;
        }
    }
    if(sender == TEMPERATURE_Button){
        if(main_view != TEMPERATURE){
            [main_view setFrame:TEMPERATURE.frame];
            [main_button setFrame:TEMPERATURE_Button.frame];
            [main_graph setFrame:TEMPERATURE.frame];
            [main_graph resize];
            
            [TEMPERATURE setFrame:tempFrame];
            [TEMPERATURE_Button setFrame:tempButton];
            
            main_view = TEMPERATURE;
            main_button = TEMPERATURE_Button;
            main_graph = nil;
        }
    }
    if(sender == layout){
        layout_index = (layout_index+1)%2;
        if(layout_index == 0){
            NSLog(@"Switching to default view");
            main_view.frame = CGRectMake(main_view_x, main_view_y, main_view_width, main_view_height);
        }else if (layout_index == 1){
            main_view.frame = CGRectMake(main_view_x, main_view_y, window.frame.size.width, main_view_height);
            NSLog(@"Switching to large view");
        }else if (layout_index == 2){
            NSLog(@"Switching to quadrant view");
        }else{
            NSLog(@"ERROR");
        }
        [self.view bringSubviewToFront:main_graph];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [main_graph setFrame:main_view.frame];
        
        [UIView commitAnimations];
        
        [main_graph resize];
    }
    

    
    [self.view bringSubviewToFront:main_view];
    [self.view bringSubviewToFront:main_graph];
    [self.view bringSubviewToFront:main_button];
    
    [self.view bringSubviewToFront:EKG_Button];
    [self.view bringSubviewToFront:SPO2_Button];
    [self.view bringSubviewToFront:PULSE_Button];
    [self.view bringSubviewToFront:TEMPERATURE_Button];
    
    if(sender == alarmOptions){
        float window_width = 400;
        float window_height = 400;
        float frame_height = 100;
        
        
        [self.view bringSubviewToFront:alarmWindow];
        if(!isWindowUp){
            
            alarmWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2,bottom_bar_y,alarmWindow.frame.size.width,alarmWindow.frame.size.height);
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            alarmWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2, main_view_height/2-window_height/2, window_width, window_height);
            
            [UIView commitAnimations];
        }else{
           
           // alarmWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2, main_view_height/2-window_height/2, window_width, window_height);
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            alarmWindow.frame = CGRectMake(window.frame.size.width/2-window_width/2,window.frame.size.height,alarmWindow.frame.size.width,alarmWindow.frame.size.height);
            [UIView commitAnimations];
            
        }
        isWindowUp = !isWindowUp;
    }

}

-(void)checkHeat{
   // if(self.instData >= 32.2){
        if(isAlarmOn){
            UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"High Temperatrue"
                                                                message:@"Your Temperature is above 90"
                                                               delegate:self
                                                      cancelButtonTitle:@"Thank You"
                                                      otherButtonTitles:nil];
            [tempAlert setTag:1];
            alarmTimer = 0;
            [tempAlert show];
            [self playAlarm];
            //myAlertView = tempAlert;
        }
        isAlarmOn = false;
 //   }else{
//        isAlarmOn = true;
 //   }
}

-(void)loadSoundFiles{
    // Set up file path to audio file
    NSString* path = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"mp3"];
    NSURL* file = [NSURL fileURLWithPath:path];
    
    // Set up audio player
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [alarmPlayer prepareToPlay];
    alarmPlayer.numberOfLoops = -1;
    
    path = [[NSBundle mainBundle] pathForResource:@"Tink" ofType:@"mp3"];
    file = [NSURL fileURLWithPath:path];
    
    // Set up audio player
    effectPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [effectPlayer prepareToPlay];
    
    NSLog(@"Sound files loaded");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 0){
            [alarmPlayer pause];
        }
    }
}

- (void) playAlarm {
    NSLog(@"Playing Sound");
    if ([alarmPlayer isPlaying]) {
        [alarmPlayer pause];
    } else {
        [alarmPlayer play];
    }
}

@end
