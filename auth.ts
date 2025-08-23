import NextAuth from "next-auth";
import Credentials from "next-auth/providers/credentials";
import { z } from "zod";
import bcrypt from "bcrypt";
import postgres from "postgres";
import type { User } from "@/app/lib/definitions";
import { authConfig } from "./auth.config";

// Koneksi ke PostgreSQL
const sql = postgres(process.env.POSTGRES_URL!, { ssl: "require" });

// Fungsi ambil user dari database
async function getUser(email: string) {
  try {
    const user = await sql<User[]>`
      SELECT * FROM users WHERE email = ${email}
    `;
    return user[0];
  } catch (error) {
    console.error("Failed to fetch user:", error);
    throw new Error("Failed to fetch user."); 
  }
}

// Konfigurasi NextAuth
export const { auth, signIn, signOut } = NextAuth({
  ...authConfig,
  providers: [
    Credentials({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "text" },
        password: { label: "Password", type: "password" },
      },
      async authorize(
        credentials: Record<"email" | "password", string> | undefined
      ) {
        // Cek apakah ada credentials
        if (!credentials) {
          console.log("No credentials provided");
          return null;
        }

        // Validasi input pakai Zod
        const parsedCredentials = z
          .object({
            email: z.string().email(),
            password: z.string().min(6),
          })
          .safeParse(credentials);

        if (!parsedCredentials.success) {
          console.log("Invalid credentials format");
          return null;
        }

        const { email, password } = parsedCredentials.data;

        // Cari user di DB
        const user = await getUser(email);
        if (!user) {
          console.log("User not found");
          return null;
        }

        // Cek password hash
        const passwordsMatch = await bcrypt.compare(password, user.password);
        if (!passwordsMatch) {
          console.log("Password mismatch");
          return null;
        }

        // Jangan return password ke session
        const { password: _, ...userWithoutPassword } = user;
        return userWithoutPassword;
      },
    }),
  ],
  session: {
    strategy: "jwt",
  },
  pages: {
    signIn: "/login", // halaman login custom
  },
});
