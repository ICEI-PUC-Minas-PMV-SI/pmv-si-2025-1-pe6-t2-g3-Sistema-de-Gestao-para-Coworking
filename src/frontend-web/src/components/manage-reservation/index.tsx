import {
  GetReservations,
  useGetReservations,
} from "@/hooks/use-manage-reservation";
import styles from "./style.module.css";
import Image from "next/image";
import { Calendar, MapPinArea, UsersFour } from "@phosphor-icons/react";
import Button from "@/components/button";
import { formatBrazillianDate } from "@/utils/formatBrazillianDate";
import { getDaysInUntilReservation } from "@/utils/getDaysUntil";
import { useState } from "react";
import RescheduleModal from "./reschedule-modal/reschedule-modal";
import CancelModal from "./cancel-modal/cancel-modal";
import { useRouter } from "next/navigation";

const ManageReservation = () => {
  const { data: reservations } = useGetReservations();
  const [isOpenRescheduleModal, setIsOpenRescheduleModal] = useState(false);
  const [isOpenCancelModal, setIsOpenCancelModal] = useState(false);
  const [activeReservation, setActiveReservation] =
    useState<GetReservations | null>(null);
  const router = useRouter();

  const normalizeName = (name: string) => {
    return name
      .toLowerCase()
      .replace(/\s+/g, "-")
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "");
  };

  const handleOpenRescheduleModal = (reservation: GetReservations) => {
    setActiveReservation(reservation);
    setIsOpenRescheduleModal(true);
  };

  const handleCloseRescheduleModal = () => {
    setIsOpenRescheduleModal(false);
    setActiveReservation(null);
  };

  const handleOpenCancelModal = (reservation: GetReservations) => {
    setActiveReservation(reservation);
    setIsOpenCancelModal(true);
  };

  const handleCloseCancelModal = () => {
    setIsOpenCancelModal(false);
    setActiveReservation(null);
  };

  if (!reservations || reservations.length === 0)
    return (
      <div className={styles.notFoundContainer}>
        <div className={styles.notFoundInfo}>
          <h2>Minhas reservas</h2>
          <span>Parece que você não tem nenhuma reserva agendada...</span>
        </div>
        <div className={styles.notFoundButton}>
          <span>Agende agora mesmo um espaço</span>
          <Button onClick={() => router.push("/reservation")}>
            Agendar reserva
          </Button>
        </div>
      </div>
    );

  return (
    <div className={styles.container}>
      <h2 className={styles.pageTitle}>Minhas reservas</h2>
      {reservations.map((reservation, index) => (
        <div className={styles.card} key={index}>
          <div className={styles.imageContainer}>
            <Image
              src={`/assets/create-reservation/${normalizeName(reservation.workspace.name)}.png`}
              alt={reservation.workspace.name}
              width={450}
              height={650}
              style={{ objectFit: "cover" }}
            />
          </div>
          <div className={styles.reservationInfos}>
            <h2>{reservation.workspace.name}</h2>
            <div className={styles.workspaceInfo}>
              <div className={styles.location}>
                <MapPinArea size={24} />
                <span>{reservation.workspace.location}</span>
              </div>
              <div className={styles.capacity}>
                <UsersFour size={24} />
                {reservation.workspace.capacity}
              </div>
            </div>
            <div className={styles.date}>
              <div className={styles.reservedDate}>
                <Calendar size={24} />
                <strong>
                  {formatBrazillianDate(reservation.reservationDate)}
                </strong>
              </div>
              <label>
                {getDaysInUntilReservation(reservation.reservationDate)}
              </label>
            </div>
            <div className={styles.buttonGroup}>
              <Button onClick={() => handleOpenRescheduleModal(reservation)}>
                Reagendamento
              </Button>
              <Button
                onClick={() => handleOpenCancelModal(reservation)}
                style={{ backgroundColor: "#F54020" }}
              >
                Cancelar reserva
              </Button>
            </div>
          </div>
        </div>
      ))}
      {isOpenRescheduleModal && activeReservation && (
        <RescheduleModal
          isOpen={isOpenRescheduleModal}
          onClose={handleCloseRescheduleModal}
          reservation={activeReservation}
        />
      )}
      {isOpenCancelModal && activeReservation && (
        <CancelModal
          isOpen={isOpenCancelModal}
          onClose={handleCloseCancelModal}
          reservationId={activeReservation.id}
        />
      )}
    </div>
  );
};

export default ManageReservation;
