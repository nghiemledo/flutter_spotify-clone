import AuthRepository from "../infrastructure/repository/auth.repository";

class AuthService {
    constructor(private authRepository: AuthRepository) {}
}

export default AuthService;