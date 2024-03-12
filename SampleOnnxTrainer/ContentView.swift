//
//  ContentView.swift
//  SampleOnnxTrainer
//
//  Created by Serhat Leloglu on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText = ""

    let serialQueue = DispatchQueue(label: "com.lan.flqueue")

    var body: some View {
        Text(displayText)
        Button("Load onnx models") {
            loadModels()
        }.padding()
        Button("Train onnx models") {
            trainModels()
        }.padding()
    }

//    MARK: private funcs
    
    private func loadModels() {
        let bundle = Bundle.main
        let rtuCheckpoint = "rtu_checkpoint"
        let rtuTrainingModel = "rtu_training_model"
        let rtuEvalModel = "rtu_eval_model"
        let rtuOptimizerModel = "rtu_optimizer_model"
        let ortExt = "ort"
        let ckptExt = "ckpt"
        
        let ckpt = Self.getPathFor(resource: rtuCheckpoint, ofType: ckptExt, bundle: bundle)!
        let trainModelPath = Self.getPathFor(resource: rtuTrainingModel, ofType: ortExt, bundle: bundle)!
        let evalModelPath = Self.getPathFor(resource: rtuEvalModel, ofType: ortExt, bundle: bundle)!
        let optModelPath = Self.getPathFor(resource: rtuOptimizerModel, ofType: ortExt, bundle: bundle)!

        let onnxTrainingRunner = OnnxTrainingRunner()

        do {
            try onnxTrainingRunner.loadModels(
                checkpointPath: ckpt,
                trainModelPath: trainModelPath,
                evalModelPath: evalModelPath,
                optimizerModelPath: optModelPath)
            pr(text: "loaded models")
        } catch {
            pr(text: error.localizedDescription)
        }
    }
    
    private func trainModels() {
        let bundle = Bundle.main
        let rtuCheckpoint = "rtu_checkpoint"
        let rtuTrainingModel = "rtu_training_model"
        let rtuEvalModel = "rtu_eval_model"
        let rtuOptimizerModel = "rtu_optimizer_model"
        let ortExt = "ort"
        let ckptExt = "ckpt"
        
        let ckpt = Self.getPathFor(resource: rtuCheckpoint, ofType: ckptExt, bundle: bundle)!
        let trainModelPath = Self.getPathFor(resource: rtuTrainingModel, ofType: ortExt, bundle: bundle)!
        let evalModelPath = Self.getPathFor(resource: rtuEvalModel, ofType: ortExt, bundle: bundle)!
        let optModelPath = Self.getPathFor(resource: rtuOptimizerModel, ofType: ortExt, bundle: bundle)!

        let onnxTrainingRunner = OnnxTrainingRunner()

        do {
            try onnxTrainingRunner.loadModels(
                checkpointPath: ckpt,
                trainModelPath: trainModelPath,
                evalModelPath: evalModelPath,
                optimizerModelPath: optModelPath)
            pr(text: "loaded models")
        } catch {
            pr(text: error.localizedDescription)
        }
        
        do {
            for _ in 1 ... 100 {
                try _ = onnxTrainingRunner.trainModel()
            }
            pr(text: "train models")
        } catch {
            pr(text: error.localizedDescription)
        }
    }
        
    public static func getPathFor(resource: String, ofType fileType: String?, bundle: Bundle) -> String? {
        return bundle.path(forResource: resource, ofType: fileType, inDirectory: nil)
    }
    
    func pr(text: String, completion: (() -> Void)? = nil) {
        print(text)
        displayText = text
    }
}
