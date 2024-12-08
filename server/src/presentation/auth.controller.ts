import { Request, Response } from "express";
import AuthService from "../application/auth.service";

class AuthController {
    constructor(private authService: AuthService) {}

    async userRegister (request: Request, response: Response): Promise<void> {

    }

    async userLogin (request: Request, response: Response): Promise<void> {
        
    }
}

export default AuthController;