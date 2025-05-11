import React from "react";
import { useForm } from "react-hook-form";
import Input from "../Input/Input";
import styles from "./register.module.css";
import Image from "next/image";
import { RegisterFormData } from "./interface";
import Button from "@/components/button";
import { useRegister } from "@/hooks/use-auth";
import { useRouter } from "next/navigation";

const Register: React.FC = () => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<RegisterFormData>({
    defaultValues: {
      role: "USER",
    },
  });
  const { mutate: registerUser } = useRegister();
  const router = useRouter();

  const onSubmit = (data: RegisterFormData) => {
    registerUser(data);
  };

  return (
    <div className={styles.registerContainer}>
      <div className={styles.registerBox}>
        <Image
          src="/logo.png"
          alt="Belo space logo"
          width={180}
          height={180}
          className={styles.registerLogo}
        />
        <div className={styles.registerHeader}>
          <span style={{ color: "rgba(24, 52, 77, 1)", fontWeight: "600" }}>
            Bem-vindo(a)!
          </span>
          <span>
            Insira as informações nos respectivos campos para cadastrar no
            sistema.
          </span>
        </div>
        <form onSubmit={handleSubmit(onSubmit)}>
          <Input
            label="Nome Completo"
            type="name"
            name="fullName"
            placeholder="Insira aqui o nome"
            register={register}
            required
          />
          {errors.fullName && (
            <span className={styles.error}>Nome obrigatório</span>
          )}
          <Input
            label="Email"
            type="email"
            name="email"
            placeholder="Insira aqui seu email"
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
            placeholder="********"
            register={register}
            required
          />
          {errors.password && (
            <span className={styles.error}>Senha obrigatória</span>
          )}
          <Button type="submit" className={styles.button}>
            Registrar
          </Button>
          <div className={styles.registerLink}>
            Já é cliente?{" "}
            <a
              onClick={() => {
                router.push("/login");
              }}
            >
              Faça login aqui
            </a>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Register;
