import Foundation
import onnxruntime_training_objc

@available(iOS 12.0, *)
class OnnxToolkit {
    lazy var ortEnv: ORTEnv? = {
        do {
            return try ORTEnv(loggingLevel: .error)
        } catch {
            return nil
        }
    }()

    lazy var sessionOptions: ORTSessionOptions? = {
        do {
            return try ORTSessionOptions()
        } catch {
            return nil
        }
    }()

    lazy var runOptions: ORTRunOptions? = {
        do {
            return try ORTRunOptions()
        } catch {
            return nil
        }
    }()
}
