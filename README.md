# Sample Onnx Trainer

## Description

This is a sample iOS app that showcases the memory consumption of loading ONNX models within an ORTTrainingSession.

In the project, I have also added a `.trace` file, which is created by using the Xcode Allocations profiler instrument. 

## How to make sense of the Trace File

To view the trace file you only need to download Xcode. Xcode installation downloads an accompanying Instruments.app, and you an just double click on the trace file to open it afterwards.

### Video
[Video](https://drive.google.com/file/d/1SqEQQTDok3TBHe4orhiitmUlIvGRY166/view?usp=sharing)

## Running the App

To run this app, make sure you have the following dependencies installed:

- Xcode 14 or later
- CocoaPods
- Mac OS Ventura or later

Follow these steps to set up the project:

1. Open a terminal and navigate to the root folder of the project.
2. Run the following command to install the required dependencies using CocoaPods:

  ```shell
  pod install
  ```

3. Once the dependencies are installed, open the `SampleOnnxTrainer.xcworkspace` file using Xcode.
4. Select a simulator or device to run the app on.
5. Build and run the app using Xcode.