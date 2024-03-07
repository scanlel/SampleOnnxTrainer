import Foundation

enum OnnxError: Error, Equatable {
    case ortEnvironmentGenerationError
    case sessionOptionsGenerationError
}
