import api from "@/lib/axios";
import { useAuthStore } from "@/stores/useAuthStore";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { toast } from "react-toastify";

export type GetReservations = {
  id: number;
  workspace: Workspace;
  reservationDate: string;
  status: string;
};

type Workspace = {
  id: number;
  name: string;
  capacity: number;
  location: string;
  status: string;
};

export type UpdateReservationProps = {
  id: number;
  reservationDate: string;
  status: string;
};

type GetReservationsByWorkspaceId = {
  workspaceId: number;
  reservedDates: string[];
};

type RawReservation = {
  id: number;
  reservationDate: string;
  status: string;
  workspace: {
    workspaceId: number;
    name: string;
    capacity: number;
    location: string;
    status: string;
  };
};

const fetchReservations = async (
  userId: number,
): Promise<GetReservations[]> => {
  const { data } = await api.get(`/reservation/user/${userId}`);
  const mappedData = data.map((reservation: RawReservation) => ({
    ...reservation,
    workspace: {
      ...reservation.workspace,
      id: reservation.workspace.workspaceId,
    },
  }));

  return mappedData;
};

export function useGetReservations() {
  const user = useAuthStore((state) => state.user);
  return useQuery<GetReservations[]>({
    queryKey: ["reservations", user?.id],
    queryFn: () => fetchReservations(user!.id),
    enabled: !!user?.id,
  });
}

const fetchReservationsByWorkspaceId = async (
  workspaceId: number,
): Promise<GetReservationsByWorkspaceId> => {
  const { data } = await api.get(`/reservation/${workspaceId}`);
  return data;
};

export const useGetReservationsByWorkspaceId = (workspaceId: number) => {
  return useQuery<GetReservationsByWorkspaceId>({
    queryKey: ["reservationsByWorkspaceId"],
    queryFn: () => fetchReservationsByWorkspaceId(workspaceId),
    enabled: false,
  });
};

const UpdateReservation = async (reservation: UpdateReservationProps) => {
  return await api
    .put(`/reservation/${reservation.id}`, reservation)
    .then((res) => res.data);
};

type UseUpdateReservationParams = {
  onSuccessCallback: () => void;
};

export function useUpdateReservation({
  onSuccessCallback,
}: UseUpdateReservationParams) {
  const queryClient = useQueryClient();
  const user = useAuthStore((state) => state.user);

  return useMutation({
    mutationFn: (reservation: UpdateReservationProps) =>
      UpdateReservation(reservation),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: ["reservations", user?.id],
      });
      onSuccessCallback();
    },
    onError: () => {
      toast.error("Erro ao atualizar reserva. Tente novamente mais tarde!");
    },
  });
}

const CancelReservation = async (reservationId: number) => {
  return await api
    .delete(`/reservation/${reservationId}`)
    .then((res) => res.data);
};

type UseCancelReservationParams = {
  onSuccessCallback: () => void;
};

export function useCancelReservation({
  onSuccessCallback,
}: UseCancelReservationParams) {
  const queryClient = useQueryClient();
  const user = useAuthStore((state) => state.user);

  return useMutation({
    mutationFn: (reservationId: number) => CancelReservation(reservationId),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: ["reservations", user?.id],
      });
      onSuccessCallback();
    },
    onError: () => {
      toast.error("Erro ao cancelar reserva. Tente novamente mais tarde!");
    },
  });
}
