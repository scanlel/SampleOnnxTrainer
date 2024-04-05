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
            loadSilhouetteModels()
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
    
    private func loadTestModels() {
        let bundle = Bundle.main
        let rtuCheckpoint = "prod_checkpoint"
        let rtuTrainingModel = "prod_training_model"
        let rtuEvalModel = "prod_eval_model"
        let rtuOptimizerModel = "prod_optimizer_model"
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
    
    private func loadSilhouetteModels() {
        let bundle = Bundle.main
        let rtuCheckpoint = "silhouette_checkpoint"
        let rtuTrainingModel = "silhouette_training_model"
        let rtuEvalModel = "silhouette_eval_model"
        let rtuOptimizerModel = "silhouette_optimizer_model"
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

    public static func getPathFor(resource: String, ofType fileType: String?, bundle: Bundle) -> String? {
        return bundle.path(forResource: resource, ofType: fileType, inDirectory: nil)
    }
    
    func pr(text: String, completion: (() -> Void)? = nil) {
        print(text)
        displayText = text
    }
}
