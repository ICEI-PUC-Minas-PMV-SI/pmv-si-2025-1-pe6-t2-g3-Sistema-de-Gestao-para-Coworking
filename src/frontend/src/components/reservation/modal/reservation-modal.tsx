import { X } from "@phosphor-icons/react";
import { ModalProps } from "./interface";
import styles from "./reservation-modal.module.css";

export const ReservationModal = ({ isOpen, onClose, children }: ModalProps) => {
  if (!isOpen) return null;
  return (
    <div className={styles.backdrop} onClick={onClose}>
      <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
        <button className={styles.closeButton} onClick={onClose}>
          <X size={20} />
        </button>
        {children}
      </div>
    </div>
  );
};
