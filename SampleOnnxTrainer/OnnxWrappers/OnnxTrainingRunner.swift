import Foundation
import onnxruntime_training_objc

@available(iOS 12.0, *)
public class OnnxTrainingRunner {

    // MARK: - Internal variables

    // ort inference and training sessions are different
    public var ortSession: ORTTrainingSession?
    let tools = OnnxToolkit()

    // this is kept for reseting the weights if necessary
    var initialWeights: ORTValue?

    public func isModelsLoaded() -> Bool {
        return ortSession != nil
    }

    public func loadModels(checkpointPath: String, trainModelPath: String, evalModelPath: String, optimizerModelPath: String) throws {
        guard let ortEnv = tools.ortEnv else {
            throw OnnxError.ortEnvironmentGenerationError
        }

        guard let sessionOptions = tools.sessionOptions else {
            throw OnnxError.sessionOptionsGenerationError
        }

        // to enable using models that have ort extensions we should call this function
        try sessionOptions.enableOrtExtensionsCustomOps()

        let checkpoint = try ORTCheckpoint(path: checkpointPath)
        ortSession = try ORTTrainingSession(
            env: ortEnv,
            sessionOptions: sessionOptions,
            checkpoint: checkpoint,
            trainModelPath: trainModelPath,
            evalModelPath: evalModelPath,
            optimizerModelPath: optimizerModelPath)
    }
    
    public func trainModel() throws -> [Any] {
        let numberOfExamples = 32
        
        let inputs = try Self.createTestInputs(numberOfExamples)
        let labels = try Self.createTestLabels(numberOfExamples)

        let outputs = try ortSession!.trainStep(withInputValues: inputs + labels)
        var result: [Any] = []
        for output in outputs {
            let data = try output.tensorData() as Data
            var array: [Float] = []
            data.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) in
                let floatPointer = pointer.bindMemory(to: Float.self)
                let count = data.count / MemoryLayout<Float>.size
                for index in 0 ..< count {
                    let value = floatPointer[index]
                    array.append(value)
                }
            }
            result.append(array)
        }
    
        return result
    }
    
    static func createTestInputs(_ numberOfExamples: Int) throws -> [ORTValue] {
        let featureList: [Int] = [2443, 6, 25, 25, 417, 308, 24, 8, 27, 4742, 10279, 58, 11, 2001, 10, 2438, 2443, 25, 25, 10279]
        var inputList: [[[Float]]] = []

        for cardinality in featureList {
            let zeroesMatrix: [[Float]] = Array(repeating: Array(repeating: 0.0,
                                                                 count: cardinality),
                                                count: numberOfExamples)
            inputList.append(zeroesMatrix)
        }
        
        var inputORTValues: [ORTValue] = []
        for input in inputList {
            if input.count <= 0 {
                continue
            }
            let inputValues = input.flatMap { $0 }
            let mdata = NSMutableData()
            for val in inputValues {
                var mutableValue = val
                mdata.append(&mutableValue, length: MemoryLayout<Float>.size)
            }
            let ortValue = try ORTValue(
                tensorData: mdata,
                elementType: ORTTensorElementDataType.float,
                shape: [NSNumber(value: input.count), NSNumber(value: input.first!.count)])
            inputORTValues.append(ortValue)
        }
        return inputORTValues
    }
    
    static func createTestLabels(_ numberOfExamples: Int) throws -> [ORTValue] {
        let labelValues: [Float] = Array(repeating: 1.0, count: numberOfExamples)
        let mdata = NSMutableData()
        for val in labelValues {
            var mutableValue = val
            mdata.append(&mutableValue, length: MemoryLayout<Float>.size)
        }
        let ortValue = try ORTValue(
            tensorData: mdata,
            elementType: ORTTensorElementDataType.float,
            shape: [NSNumber(value: numberOfExamples), NSNumber(value: 1)])
        return [ortValue]
    }

    deinit {
        self.ortSession = nil
    }
}
