import express, { NextFunction, Request, Response } from 'express';

const app = express();
const PORT = 3000;

app.get('/', (req: Request, res: Response, next: NextFunction) => {

})

app.listen(PORT, () => {
    console.log(`Server is running at port: ${PORT}`);
});