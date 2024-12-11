import { Router } from "express";
import AuthController from "../presentation/auth.controller";
// import AuthService from "../application/auth.service";
// import AuthRepository from "../infrastructure/repositories/auth.repository";
import { authenticateToken } from "../middlewares/auth.middleware";

const authRouter = Router();
// const authRepository = new AuthRepository();
// const authService = new AuthService(authRepository);
const authController = new AuthController();

authRouter.post("/login", authController.userLogin.bind(authController));
authRouter.post("/register", authController.userRegister.bind(authController));
authRouter.get("/current_user", authenticateToken, authController.getCurrentUser.bind(authController));

export default authRouter;