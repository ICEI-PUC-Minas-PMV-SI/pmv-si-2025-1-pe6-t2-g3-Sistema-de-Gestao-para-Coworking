import Image from "next/image";
import styles from "./styles.module.css";
import { CheckCircle, MapPinArea, UsersFour } from "@phosphor-icons/react";
import Button from "@/components/button";
import { useEffect, useState } from "react";
import DateInput from "./calendar/reservation-calendar";
import {
  useCreateReservation,
  useWorkspacesWithReservations,
} from "@/hooks/use-reservation";
import { Loader } from "../loader/loader";
import { ReservationModal } from "./modal/reservation-modal";
import { toast } from "react-toastify";
import { useRouter } from "next/navigation";
import { useAuthStore } from "@/stores/useAuthStore";

const CreateReservation = () => {
  const [reservedDates, setReservedDates] = useState<Date[]>([]);
  const [selectedDates, setSelectedDates] = useState<
    Record<number, Date | null>
  >({});
  const [isOpenModal, setIsOpenModal] = useState(false);
  const router = useRouter();

  const { data: workspaces, isError } = useWorkspacesWithReservations();
  const {
    mutate,
    isPending,
    isSuccess: isSuccessReservate,
    reset,
  } = useCreateReservation(() => {
    setSelectedDates({});
  });

  useEffect(() => {
    if (isSuccessReservate) {
      setIsOpenModal(true);
    }
  }, [isSuccessReservate]);

  const user = useAuthStore((state) => state.user);
  if (!user?.id) {
    toast.error("Usuário não identificado.");
    return;
  }

  const handleSubmit = async (workspaceId: number) => {
    const selectedDate = selectedDates[workspaceId];
    if (!selectedDate) {
      toast.error("A data precisa ser selecionada antes de reservar.");
      return;
    }

    const formattedDate = selectedDate.toISOString().split("T")[0];
    setReservedDates([...reservedDates, selectedDate]);
    mutate({
      workspaceId,
      reservationDate: formattedDate,
      userId: user.id,
      status: "PENDING",
    });
  };

  if (isError) return <p>Erro ao carregar os espaços.</p>;
  if (!workspaces || workspaces.length === 0)
    return <p>Nenhum espaço encontrado.</p>;

  const handleDateSelect = (workspaceId: number, date: Date) => {
    setSelectedDates((prev) => ({
      ...prev,
      [workspaceId]: date,
    }));
  };

  const normalizeName = (name: string) => {
    return name
      .toLowerCase()
      .replace(/\s+/g, "-")
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "");
  };

  return (
    <div className={styles.container}>
      <h2 className={styles.pageTitle}>Reserve sua BeloSpace</h2>
      {workspaces.map((workspace, index) => (
        <div className={styles.card} key={index}>
          <h2>{workspace.name}</h2>
          <div className={styles.imageContainer}>
            <Image
              src={`/assets/create-reservation/${normalizeName(workspace.name)}.png`}
              alt={workspace.name}
              width={450}
              height={400}
              style={{ objectFit: "cover" }}
            />
          </div>
          <div className={styles.workspaceInfos}>
            <div className={styles.location} title="Localização da sala">
              <MapPinArea size={32} />
              <span>{workspace.location}</span>
            </div>
            <div className={styles.capacity} title="Capacidade total da sala">
              {workspace.capacity}
              <UsersFour size={32} />
            </div>
          </div>
          <div className={styles.actionGroup}>
            <div>
              <label>
                <strong>Data</strong>
              </label>
              <DateInput
                reservedDates={workspace.reservedDates}
                onDateSelect={(date) => handleDateSelect(workspace.id, date)}
                selectedDate={selectedDates[workspace.id] || null}
              />
              <label style={{ color: "#cccccc" }}>
                Você pode selecionar até 1 data.
              </label>
            </div>
            <Button
              onClick={() => handleSubmit(workspace.id)}
              disabled={isPending}
            >
              {isPending ? <Loader /> : "Reservar"}
            </Button>
          </div>
        </div>
      ))}
      {isSuccessReservate && (
        <ReservationModal
          isOpen={isOpenModal}
          onClose={() => {
            setIsOpenModal(false);
            reset();
          }}
        >
          <div className={styles.modalContainer}>
            <div className={styles.modalContent}>
              <h2>Sua reserva foi confirmada!</h2>
              <span>
                Agora é só aproveitar nosso belo espaço com sua equipe.
              </span>
              <CheckCircle size={64} color="#3cd21e" />
            </div>
            <div className={styles.buttonGroup}>
              <Button
                appearance="secondary"
                onClick={() => setIsOpenModal(false)}
              >
                Fechar
              </Button>
              <Button onClick={() => router.push("/manage-reservation")}>
                Minha reserva
              </Button>
            </div>
          </div>
        </ReservationModal>
      )}
    </div>
  );
};

export default CreateReservation;
