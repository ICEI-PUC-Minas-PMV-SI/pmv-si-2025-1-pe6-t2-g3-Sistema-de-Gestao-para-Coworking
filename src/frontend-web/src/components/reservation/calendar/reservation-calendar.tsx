import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import styles from "./reservation-calendar.module.css";
import { ptBR } from "date-fns/locale";
import { CustomInput } from "./custom-input/custom-input";

interface DateInputProps {
  reservedDates?: Date[];
  onDateSelect: (date: Date) => void;
  selectedDate: Date | null;
}

const DateInput: React.FC<DateInputProps> = ({
  reservedDates = [],
  onDateSelect,
  selectedDate,
}) => {
  const isReserved = (date: Date) => {
    return reservedDates.some(
      (reservedDate) => reservedDate.toDateString() === date.toDateString()
    );
  };

  return (
    <div className={styles.container}>
      <DatePicker
        wrapperClassName="datepicker-wrapper"
        selected={selectedDate}
        onChange={(date: Date | null) => {
          onDateSelect(date as Date);
        }}
        filterDate={(date: Date) => !isReserved(date)}
        minDate={new Date()}
        placeholderText="Selecione uma data"
        dateFormat="dd/MM/yyyy"
        locale={ptBR}
        className={styles.datePickerInput}
        customInput={<CustomInput />}
        popperClassName={styles.datePickerPopper}
        calendarClassName="react-datepicker"
        dayClassName={(date) =>
          reservedDates.some(
            (reserved) => date.toDateString() === reserved.toDateString()
          )
            ? "reserved-date"
            : ""
        }
      />
    </div>
  );
};

export default DateInput;
