import { RegisterFormData } from '@/components/register/interface';
import api from '@/lib/axios';
import { useAuthStore } from '@/stores/useAuthStore';
import { useMutation } from '@tanstack/react-query';
import { useRouter } from 'next/navigation';
import { toast } from 'react-toastify';

function getFriendlyErrorMessage(status: number | undefined, message?: string): string {
  if (status) {
    switch (status) {
      case 400:
        return "Preencha todos os campos corretamente.";
      case 403:
        return "Você não tem permissão para acessar.";
      case 404:
        return "Usuário não encontrado.";
      case 500:
        return "Email ou senha incorretos.";
      default:
        return "Ocorreu um erro inesperado. Tente novamente.";
    }
  }

  switch (message) {
    case "Invalid password":
      return "Senha inválida. Verifique e tente novamente.";
    case "User not found":
      return "E-mail não cadastrado.";
    default:
      return "Erro desconhecido. Tente novamente.";
  }
}

export function useLogin(onSuccess?: () => void) {
  const setUserFromToken = useAuthStore((state) => state.setUserFromToken);
  return useMutation({
    mutationFn: async (data: { email: string; password: string }) => {
      const response = await api.post('/auth/login', {
        email: data.email,
        password: data.password,
      });

      const token = response.data.token;
      localStorage.setItem('token', token);
      return token;
    },
    onSuccess: (token) => {
      setUserFromToken(token);
      toast.success("Login realizado com sucesso!");
      onSuccess?.();
    },
    onError: (error: any) => {
      const status = error.response?.status;
      const message = error.response?.data?.message;

      const friendlyMessage = getFriendlyErrorMessage(status, message);
      toast.error(friendlyMessage);
    },
  });
}

export function useRegister() {
  const router = useRouter();

  return useMutation({
    mutationFn: async (data: RegisterFormData) => {
      const response = await api.post("/auth/signup", data);
      return response.data;
    },
    onSuccess: () => {
      toast.success("Usuário registrado com sucesso!");
      router.push("/login");
    },
    onError: (error: any) => {
      const status = error.response?.status;
      const message = error.response?.data?.message;

      const friendlyMessage = getFriendlyErrorMessage(status, message);
      toast.error(friendlyMessage);
    },
  });
}
