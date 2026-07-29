import express from "express"; 
import { authMiddleware } from "../middleware/authMiddleware.js";
import {register, login, logout, me} from '../controllers/authController.js';
import { validateRequest } from "../middleware/validateRequestMiddleware.js";
import { loginSchema, registerSchema } from "../validators/authValidators.js"; 
const router = express.Router(); 

router.post("/register", validateRequest(registerSchema), register);

router.post("/login", validateRequest(loginSchema),login);

router.post("/logout", logout);

router.get("/me", authMiddleware, me);

export default router; 

