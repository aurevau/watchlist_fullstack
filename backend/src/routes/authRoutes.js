import express from "express"; 
import {register, login, logout} from '../controllers/authController.js';
import { validateRequest } from "../middleware/validateRequestMiddleware.js";
import { loginSchema, registerSchema } from "../validators/authValidators.js"; 
const router = express.Router(); 

router.post("/register", validateRequest(registerSchema), register);

router.post("/login", validateRequest(loginSchema),login);

router.post("/logout", logout);

export default router; 

