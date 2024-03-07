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

}
