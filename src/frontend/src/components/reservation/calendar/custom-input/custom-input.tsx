import { forwardRef } from "react";
import styles from "./custom-input.module.css";
import { CalendarDots } from "@phosphor-icons/react";

type Props = {
  value?: string;
  onClick?: () => void;
};

export const CustomInput = forwardRef<HTMLInputElement, Props>(
  ({ value, onClick }, ref) => {
    return (
      <div className={styles.container} onClick={onClick}>
        <CalendarDots size={24} className={styles.icon} />
        <input
          ref={ref}
          value={value || ""}
          readOnly
          placeholder="Escolha uma data"
          className={styles.input}
        />
      </div>
    );
  }
);

CustomInput.displayName = "CustomInput";
