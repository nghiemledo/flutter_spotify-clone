import { NextFunction, Request, Response } from "express";
import CustomError from "../errors/custom.error";

const ErrorHandler = (
    err: Error,
    _req: Request,
    res: Response,
    _next: NextFunction
) => {
    if(err instanceof CustomError) {
        return res.send({errors: err.serializeErrors()})
    }
    
    return res.send({
        error: [
            {
                message: "Some error occured!"
            }
        ]
    })
};

export default ErrorHandler;