import type { NextAuthConfig } from "next-auth"

export const authConfig = {
  pages: {
    signIn: "/login",
  },
  callbacks: {
    authorized({ auth, request: { nextUrl } }) {
      const isLoggedIn = !!auth?.user
      const isOnDashboard = nextUrl.pathname.startsWith("/dashboard")

      if (isOnDashboard) {
        if (isLoggedIn) return true
        return false // redirect ke /login
      } else if (isLoggedIn) {
        return Response.redirect(new URL("/dashboard", nextUrl))
      }
      return true
    },
    async session({ session, token }) {
      // Pastikan selalu return object
      return {
        ...session,
        user: {
          ...session.user,
          id: token.sub, // simpan userId dari token
        },
      }
    },
  },
  providers: [
    // tambahkan provider login (Google, GitHub, Credentials, dll.)
  ],
} satisfies NextAuthConfig
