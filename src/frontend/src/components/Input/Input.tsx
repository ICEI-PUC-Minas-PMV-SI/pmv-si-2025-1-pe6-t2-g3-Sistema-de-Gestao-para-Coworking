import React from "react";
import styles from "./input.module.css";
import { UseFormRegister } from "react-hook-form";

type InputProps = {
  label: string;
  type: string;
  name: string;
  register: UseFormRegister<any>;
  required?: boolean;
  placeholder?: string;
};

const Input: React.FC<InputProps> = ({
  label,
  type,
  name,
  register,
  required,
  placeholder,
}: InputProps) => {
  return (
    <div className={styles.inputContainer}>
      <label className={styles.label}>{label}</label>
      <input
        id={name}
        type={type}
        placeholder={placeholder}
        {...register(name, { required })}
      />
    </div>
  );
};

export default Input;
