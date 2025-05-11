import { ButtonProps } from "./interface";
import styles from "./button.module.css";

const Button = ({
  children,
  className = "",
  appearance = "primary",
  ...rest
}: ButtonProps) => {
  const appearanceClass =
    appearance === "primary" ? styles.primary : styles.secondary;
  return (
    <button
      className={`${styles.button} ${appearanceClass} ${className}`}
      {...rest}
    >
      {children}
    </button>
  );
};

export default Button;
