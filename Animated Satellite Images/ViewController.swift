//
//  ViewController.swift
//  Animated Satellite Images
//
//  Author: Charles Ryan Barrett
//  Date: 2/24/2021
//  Description: A simple iOS app that plays an animated sequence of sattelite images, in either visible or infrared, at various speeds. For CSC 308 at EKU
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    
    //Current animation speed
    var curSpeed = 1.0 //Default speed is 1.0 (fastest)
    
    //If animation is currently playing
    var curPlaying = false //Need to know to keep animation playing when speed or image type is changed
    
    //Array to hold the visible images
    var visImg = [UIImage]()
    //Array to hold infrared images
    var infImg = [UIImage]()
    
    
    //Outlets
    
    //main image view to display the pictures
    @IBOutlet weak var display: UIImageView!
    
    //Label to relay current speed of frames
    @IBOutlet weak var curSpeedLabel: UILabel!
    
    //play/stop button
    @IBOutlet weak var playBtn: UIButton!
    
    
    //Function for when the type of image is changed
    @IBAction func imgTypeChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            display.animationImages = visImg
            display.image = visImg[0]
        }
        else{
            display.animationImages = infImg
            display.image = infImg[0]
        }
        
        //Restart animation if it was playing when image type was changed
        if curPlaying{
            display.startAnimating()
        }

    }
    
    //Function for when speed is adjusted via the stepper
    @IBAction func changeSpeedStepper(_ sender: UIStepper) {
        //Send new speed to changeSpeed function
        changeSpeed(newSpeed: sender.value)
    }
    
    //Function for when play button is pressed
    @IBAction func playStop(_ sender: Any) {
        if (display.isAnimating){
            //Is currently animating
            
            //Stop it
            display.stopAnimating()
            
            //Update curPlaying
            curPlaying = false
            //Update button text
            playBtn.setTitle("Play", for: UIControl.State.normal)
        }
        else
        {
            //It is not animating
            
            //Start it
            display.startAnimating()
            //Update curPlaying
            curPlaying = true
            //Update button text
            playBtn.setTitle("Stop", for: UIControl.State.normal)

        }
    }
    
    
    //Function to change play speed
    func changeSpeed(newSpeed: Double){

        curSpeed = Double(visImg.count)/newSpeed
        //visImg and infImg have the same number of images, so either can be counted
        display.animationDuration = (Double(visImg.count)/curSpeed)
        
        //Update the number of frames per second
        
        let preamble = "Playback Speed: \(visImg.count) Frames in "
        
        //If only 1 second, it should be singular and not plural
        if newSpeed == 1{
            curSpeedLabel.text = preamble + String(Int(newSpeed)) + " Second"
        }
        else{
            curSpeedLabel.text = preamble + String(Int(newSpeed)) + " Seconds"
        }
        
        
        //Restart animation if it was already playing before speed was changed
        if curPlaying{
            display.startAnimating()
        }
    }
    
    //This function loads the image arrays with the images

    func loadImages(){
        //populate visImg and infImg
        let visName = "visible"
        let infName = "infrared"
        for x in 1...14 {
            if x < 10
            {
            visImg.append(UIImage(named: visName + "0" + String(x) + ".jpg")!)
            infImg.append(UIImage(named: infName + "0" + String(x) + ".jpg")!)
            }
            else
            {
                visImg.append(UIImage(named: visName + String(x) + ".jpg")!)
                infImg.append(UIImage(named: infName + String(x) + ".jpg")!)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //load the images
        loadImages()
        
        //add the visual images as default to the display
        display.animationImages = visImg
        
        //Set default speed
        changeSpeed(newSpeed: curSpeed)
        //make the button look nicer
        playBtn.layer.cornerRadius = 20.0

    }


}

/*
var visImg = [ UIImage(named: "visible01.jpg"),UIImage(named: "visible02.jpg"),
UIImage(named: "visible03.jpg"), UIImage(named: "visible04.jpg"), UIImage(named: "visible05.jpg"), UIImage(named: "visible06.jpg"),UIImage(named: "visible07.jpg"),UIImage(named: "visible08.jpg"),UIImage(named: "visible09.jpg"),
UIImage(named: "visible10.jpg"), UIImage(named: "visible11.jpg"), UIImage(named: "visible12.jpg"), UIImage(named: "visible13.jpg"),UIImage(named: "visible14.jpg")]

//Array to hold the infrared images
var infImg = [ UIImage(named: "infrared01.jpg"),UIImage(named: "infrared02.jpg"),
UIImage(named: "infrared03.jpg"), UIImage(named: "infrared04.jpg"), UIImage(named: "infrared05.jpg"), UIImage(named: "infrared06.jpg"),UIImage(named: "infrared07.jpg"),UIImage(named: "infrared08.jpg"),UIImage(named: "infrared09.jpg"),
UIImage(named: "infrared10.jpg"), UIImage(named: "infrared11.jpg"), UIImage(named: "infrared12.jpg"), UIImage(named: "infrared13.jpg"),UIImage(named: "infrared14.jpg")]
*/
