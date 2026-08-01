import bcrypt from "bcryptjs";
import {prisma} from "../config/db.js";
import {generateToken} from '../utils/generateToken.js';

const register = async (req, res) => {
    const body = req.body; 
    const {name, email, password} = body; 

    // Check if user already exists 
    const userExists = await prisma.user.findUnique({
        where: {email: email}, 
    });

    if (userExists) {
        return res.status(400).json({error: "User already exists with this email"});
    }

    // Hash password 
    const salt = await bcrypt.genSalt(10)
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create user 
    const user = await prisma.user.create({
        data: {
            name, 
            email, 
            password: hashedPassword,
        }
    });

      // Generate JWT Token 
    const token = generateToken(user.id, res); 

    res.status(201).json({
        status: "sucess",
        data: {
            user: {
                id: user.id,
                name: name, 
                email: email, 
            },
            token,
        }
    });

};



const login = async (req, res) => {
    const {email, password} = req.body; 

     // Check if user email exists in the table
    const user = await prisma.user.findUnique({
        where: {email: email}, 
    });

    if(!user) {
        return res.status(401).json({error: "Invalid email or password"});
    }

    // verify the password 
    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
        return res.status(401).json({error: "Invalid email or password"});
    }

    // Generate JWT Token 
    const token = generateToken(user.id, res); 


    res.status(201).json({
        status: "sucess",
        data: {
            user: {
                id: user.id, 
                email: email, 
            },
            token,
        }
    });
};

const me = async (req, res) => {
    const user = await prisma.user.findUnique({
        where: {id: req.user.id},
        select: {
            id: true,
            name: true,
            email: true,
        }
    });

    if (!user) {
        return res.status(404).json({error: "User not found"});
    }

    res.status(200).json({
        status: "success",
        data: {user},
    });
};

const logout = async (req, res) => {
    res.cookie("jwt", "", {
        httpOnly: true,
        expires: new Date(0)
    });
    res.status(200).json({
        status: "success", 
        message: "Logged out succesfully"
    });
};

export {register, login, logout, me};