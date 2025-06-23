export const getDaysInUntilReservation = (
  reservationDateStr: string,
): string => {
  const today = new Date();
  const parseLocalDate = (dateStr: string): Date => {
    const [year, month, day] = dateStr.split("-").map(Number);
    return new Date(year, month - 1, day);
  };
  const reservationDate = parseLocalDate(reservationDateStr);

  today.setHours(0, 0, 0, 0);
  reservationDate.setHours(0, 0, 0, 0);

  const diffInMs = reservationDate.getTime() - today.getTime();
  const diffInDays = diffInMs / (1000 * 60 * 60 * 24);

  switch (true) {
    case diffInDays > 1:
      return `Faltam ${Math.floor(diffInDays)} dias para a reserva.`;
    case diffInDays === 1:
      return "A reserva é amanhã.";
    case diffInDays === 0:
      return "A reserva é hoje.";
    case diffInDays < 0:
      return `A reserva foi há ${Math.abs(Math.floor(diffInDays))} dia${Math.abs(Math.floor(diffInDays)) > 1 ? "s" : ""}.`;
    default:
      return "";
  }
};
