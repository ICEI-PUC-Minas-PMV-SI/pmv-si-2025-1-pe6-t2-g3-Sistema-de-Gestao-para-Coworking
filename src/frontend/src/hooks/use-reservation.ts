import api from "@/lib/axios";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { toast } from "react-toastify";

type Workspace = {
  id: number;
  name: string;
  capacity: number;
  location: string;
  status: string;
};

type Reservation = {
  workspaceId: number;
  reservedDates: string[];
};

type WorkspaceWithReservations = Workspace & {
  reservedDates: Date[];
};

type ReservationPayload = {
  workspaceId: number;
  reservationDate: string;
  userId: number;
  status: string;
};

export function useWorkspacesWithReservations() {
  const {
    data: workspaces,
    isLoading: loadingWorkspaces,
    isError: errorWorkspaces,
  } = useQuery<Workspace[]>({
    queryKey: ["workspaces"],
    queryFn: () => api.get("/workspace").then((res) => res.data),
  });

  const {
    data: reservationsByWorkspace,
    isLoading: loadingReservations,
    isError: errorReservations,
  } = useQuery<Reservation[]>({
    queryKey: ["reservation"],
    queryFn: () => api.get("/reservation").then((res) => res.data),
  });

  const isLoading = loadingWorkspaces || loadingReservations;
  const isError = errorWorkspaces || errorReservations;

  function parseDateToLocal(dateStr: string): Date {
    const [year, month, day] = dateStr.split("-").map(Number);
    return new Date(year, month - 1, day);
  }

  const data: WorkspaceWithReservations[] | undefined = workspaces?.map(
    (workspace) => {
      const match = reservationsByWorkspace?.find(
        (r) => r.workspaceId === workspace.id,
      );
      return {
        ...workspace,
        reservedDates: (match?.reservedDates ?? []).map(parseDateToLocal) || [],
      };
    },
  );

  return {
    isLoading,
    isError,
    data,
  };
}

const createReservation = async (data: ReservationPayload) => {
  return await api.post("/reservation/create", data).then((res) => res.data);
};

export function useCreateReservation(onSuccessCallback: () => void) {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: createReservation,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["reservation"] });
      onSuccessCallback();
    },
    onError: () => {
      toast.error("Erro ao criar reserva. Tente novamente mais tarde!");
    },
  });
}
