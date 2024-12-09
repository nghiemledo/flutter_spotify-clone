import AuthRepository from "../infrastructure/repositories/auth.repository";

class AuthService {
    constructor(private authRepository: AuthRepository) {}
}

export default AuthService;