import { create } from "zustand";
import { jwtDecode } from "jwt-decode";

type JwtPayload = {
  id: number;
  fullName: string;
  email: string;
  role: string;
  exp: number;
};

type AuthState = {
  user: JwtPayload | null;
  setUserFromToken: (token: string) => void;
  logout: () => void;
};

export const useAuthStore = create<AuthState>((set) => ({
  user: null,

  setUserFromToken: (token: string) => {
    try {
      const decoded = jwtDecode<JwtPayload>(token);
      if (decoded.exp * 1000 > Date.now()) {
        localStorage.setItem("token", token);
        set({ user: decoded });
      } else {
        localStorage.removeItem("token");
        set({ user: null });
      }
    } catch {
      localStorage.removeItem("token");
      set({ user: null });
    }
  },

  logout: () => {
    localStorage.removeItem("token");
    set({ user: null });
  },
}));
