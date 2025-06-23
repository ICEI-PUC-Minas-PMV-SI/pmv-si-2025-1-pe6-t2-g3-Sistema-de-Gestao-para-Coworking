type Reservation = {
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

export interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  reservation: Reservation;
}
