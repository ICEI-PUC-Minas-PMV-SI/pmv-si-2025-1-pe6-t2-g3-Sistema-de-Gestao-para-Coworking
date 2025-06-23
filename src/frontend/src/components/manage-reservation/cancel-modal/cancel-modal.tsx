import Button from "@/components/button";
import styles from "./cancel-modal.module.css";
import { Loader } from "@/components/loader/loader";
import { CancelModelProps } from "./interface";
import { X } from "@phosphor-icons/react";
import { useCancelReservation } from "@/hooks/use-manage-reservation";
import { toast } from "react-toastify";

const CancelModal = ({ isOpen, onClose, reservationId }: CancelModelProps) => {
  const { mutate, isPending } = useCancelReservation({
    onSuccessCallback: () => {
      toast.success("Reserva cancelada com sucesso!");
      onClose();
    },
  });

  const handleSubmit = () => {
    mutate(reservationId);
  };

  if (!isOpen) return null;
  return (
    <div className={styles.backdrop} onClick={onClose}>
      <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
        <button className={styles.closeButton} onClick={onClose}>
          <X size={20} />
        </button>
        <div className={styles.modalContainer}>
          <div className={styles.modalContent}>
            <div className={styles.contentInfo}>
              <h2>Deseja realmente cancelar a reserva?</h2>
              <span>
                Essa ação é permanente e pode não haver a possibilidade de
                remarca caso outra pessoa reservar a sala no horário escolhido!
              </span>
            </div>
            <div className={styles.actionGroup}>
              <Button
                style={{ backgroundColor: "#F54020" }}
                onClick={handleSubmit}
                disabled={isPending}
              >
                {isPending ? <Loader /> : "Cancelar Reserva"}
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CancelModal;
