import React from "react";
import { useForm } from "react-hook-form";
import Input from "@/components/Input/Input";
import Button from "@/components/button/index";
import styles from "./login.module.css";
import Image from "next/image";
import { LoginFormData } from "./interface";
import { useRouter } from "next/router";
import { useLogin } from "@/hooks/use-auth";

const UseLogin: React.FC = () => {
  const router = useRouter();
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginFormData>();

  const { mutate: login } = useLogin(() => {
    router.push("/dashboard");
  });

  const onSubmit = (data: LoginFormData) => {
    login(data);
  };

  return (
    <div className={styles.loginContainer}>
      <div className={styles.loginBox}>
        <Image
          src="/logo.png"
          alt="Belo space logo"
          width={220}
          height={220}
          className={styles.loginLogo}
        />
        <div className={styles.loginHeader}>
          <span style={{ color: "rgba(24, 52, 77, 1)", fontWeight: "600" }}>
            Bem-vindo(a)!
          </span>
          <span>
            Insira as informações nos respectivos campos para acessar o sistema.
          </span>
        </div>
        <form onSubmit={handleSubmit(onSubmit)}>
          <Input
            label="Email"
            type="email"
            name="email"
            placeholder="exemplo@gmail.com"
            register={register}
            required
          />
          {errors.email && (
            <span className={styles.error}>E-mail obrigatório</span>
          )}
          <Input
            label="Senha"
            type="password"
            name="password"
            placeholder="*******"
            register={register}
            required
          />
          {errors.password && (
            <span className={styles.error}>E-mail obrigatório</span>
          )}
          <div className={styles.forgotPassword}>
            <a href="#">Esqueceu sua senha?</a>
          </div>
          <Button type="submit" className={styles.button}>
            Login
          </Button>
        </form>
        <div className={styles.registerLink}>
          Ainda não é cliente?{" "}
          <a
            onClick={() => {
              router.push("/register");
            }}
          >
            Cadastre-se aqui
          </a>
        </div>
      </div>
    </div>
  );
};

export default UseLogin;
