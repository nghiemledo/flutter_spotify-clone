import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export const authenticateToken = (req: Request, res: Response, next: NextFunction): void => {
    const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
         res.status(401).json({message: "Token is required"});
         return;
    }

    jwt.verify(token, 'secretkey123', (err, user) => {
        if (err) {
            return res.status(403).json({message: "Invalid token"});
        }

        (req as any).user = user;
        next();
    });
};