import { X } from "@phosphor-icons/react";
import { ModalProps } from "./interface";
import styles from "./reschedule.module.css";
import {
  useGetReservationsByWorkspaceId,
  useUpdateReservation,
  UpdateReservationProps,
} from "@/hooks/use-manage-reservation";
import { toast } from "react-toastify";
import DateInput from "@/components/reservation/calendar/reservation-calendar";
import Button from "@/components/button";
import { Loader } from "@/components/loader/loader";
import { useEffect, useState } from "react";

const RescheduleModal = ({ isOpen, onClose, reservation }: ModalProps) => {
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);

  const { data, refetch } = useGetReservationsByWorkspaceId(
    reservation.workspace.id
  );
  useEffect(() => {
    if (isOpen && reservation.workspace.id) {
      refetch();
    }
  }, [isOpen, reservation.workspace.id, refetch]);

  const { mutate, isPending } = useUpdateReservation({
    onSuccessCallback: () => {
      toast.success("Reserva reagendada com sucesso!");
      onClose();
    },
  });

  if (!data) return <p>Nenhuma reserva encontrada.</p>;
  const reservedDates = data.reservedDates.map(
    (date) => new Date(`${date}T00:00:00`)
  );

  const handleSubmit = () => {
    if (!selectedDate) {
      toast.error("Selecione uma data.");
      return;
    }

    const payload: UpdateReservationProps = {
      id: reservation.id,
      reservationDate: selectedDate.toISOString().split("T")[0],
      status: "PENDING",
    };
    mutate(payload);
  };

  const handleDateSelect = (date: Date) => {
    setSelectedDate(date);
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
              <h2>Selecione a nova data para reagendar</h2>
              <span>
                Você está reagendando a{" "}
                <strong>{reservation.workspace.name}</strong> neste momento.
              </span>
            </div>
            <div className={styles.actionGroup}>
              <label>
                <strong>Data</strong>
              </label>
              <DateInput
                reservedDates={reservedDates}
                onDateSelect={handleDateSelect}
                selectedDate={selectedDate}
              />
              <label style={{ color: "#cccccc" }}>
                Você pode selecionar até 1 data.
              </label>
              <Button onClick={handleSubmit} disabled={isPending}>
                {isPending ? <Loader /> : "Reagendar"}
              </Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RescheduleModal;
