import { Router } from "express";
import AuthController from "../presentation/auth.controller";
// import AuthService from "../application/auth.service";
// import AuthRepository from "../infrastructure/repositories/auth.repository";
import { authenticateToken } from "../middlewares/auth.middleware";

const authRouter = Router();
// const authRepository = new AuthRepository();
// const authService = new AuthService(authRepository);
const authController = new AuthController();

authRouter.post("/login", authController.userLogin);
authRouter.post("/register", authController.userRegister);
authRouter.get("/current_user", authenticateToken, authController.getCurrentUser);

export default authRouter;