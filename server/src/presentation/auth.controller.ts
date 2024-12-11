import { Request, Response } from "express";
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import userEntity from "../domain/entities/user.entity";
class AuthController {
    constructor() {}

    async userRegister (request: Request, response: Response): Promise<void> {
        try {
            const user = await userEntity.findOne({ email: request.body.email });
            if (user) {
                response.status(500).json("User already exist");
                return;
            }
            const hashedPassword = await bcrypt.hash(request.body.password, 12);
            const accessToken = jwt.sign({ email: request.body.email }, "secretkey123", { expiresIn: '30m' });
            const refreshToken = jwt.sign({ email: request.body.email }, "secretkey123", { expiresIn: '1d' });
            const newUser = await userEntity.create({
                ...request.body,
                password: hashedPassword,
            })

            response.status(201).json({
                status: 'Success',
                message: 'User registered successfully',
                data: newUser
            })
        } catch (error: any) {
            response.json({message: error.message || "Error occurred when register user"})
        }
    }

    async userLogin (request: Request, response: Response): Promise<void> {
        try {
            const { email, password } = request.body;
            const user = await userEntity.findOne({ email });
            if (!user) {
                response.status(400).json({message: "User not found"})
                return;
            }
            if (user) {
                const isPasswordValid = await bcrypt.compare(password, user.password); 
                if (!isPasswordValid) {
                    response.status(401).json({message: "Invalid email or password"});
                    return;
                }                    

                
                const accessToken = jwt.sign({ _id: user._id }, "secretkey123", { expiresIn: '30m' });
                const refreshToken = jwt.sign({ _id: user._id }, "secretkey123", { expiresIn: '1d' });
        
               
                response.status(200).json({
                    status: 'Success',
                    message: 'Logged in successfully',
                    accessToken,
                    refreshToken,
                    user: {
                        username: user.username,
                        email: user.email,
                    }
                })
            } else {
                response.status(401).json({message: "User not found"});
                return;
            }
        } catch (error: any) {
            response.status(500).json({message: error.message});
        }
    }

    async getCurrentUser(request: Request, response: Response): Promise<void> { 
        try {
            const userId = (request as any).user._id;
            const user = await userEntity.findById(userId).select("-password");
            if (!user) {
                 response.status(404).json({message: "User not found"});
                 return;
            }

            response.status(200).json({
                status: 'Success',
                user,
            });
        } catch (error: any) {
            response.status(500).json({message: error.message || "Error occurred while fetching user data"});
        }
    }
}

export default AuthController;