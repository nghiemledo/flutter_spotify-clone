import { Router } from "express";
import AuthController from "../presentation/auth.controller";
import AuthService from "../application/auth.service";
import AuthRepository from "../infrastructure/repositories/auth.repository";

const authRouter = Router();
const authRepository = new AuthRepository();
const authService = new AuthService(authRepository);
const authController = new AuthController(authService);

authRouter.post("/login", authController.userLogin);
authRouter.post("/register", authController.userRegister);

export default authRouter;