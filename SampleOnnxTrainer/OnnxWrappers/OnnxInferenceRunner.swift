import Foundation

import onnxruntime_training_objc

@available(iOS 12.0, *)
class OnnxInferenceRunner {

    // MARK: - Internal variables

    /// ort inference and training sessions are different
    var ortSession: ORTSession?
    let tools = OnnxToolkit()

    func loadModel(fromPath: String) throws -> Bool {
        guard let ortEnv = tools.ortEnv else {
            throw OnnxError.ortEnvironmentGenerationError
        }

        guard let sessionOptions = tools.sessionOptions else {
            throw OnnxError.sessionOptionsGenerationError
        }

        try sessionOptions.enableOrtExtensionsCustomOps()

        do {
            ortSession = try ORTSession(env: ortEnv, modelPath: fromPath, sessionOptions: sessionOptions)
            return true
        } catch let error {
            throw error
        }
    }
}
