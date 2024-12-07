import CustomError from "./custom.error";

class ValidationError extends CustomError {
    errorCode = 400;
    errorType = "VALIDATION_ERROR";

    constructor(message: string, private property: string) {
        super(message);
        Object.setPrototypeOf(this, ValidationError.prototype)
    }

    serializeErrors() {
        return [{message:this.message, property: this.property}]
    }
}

export default ValidationError;