import { UseFormRegister } from 'react-hook-form';

export type InputProps = {
  label: string;
  type: string;
  name: string;
  register: UseFormRegister<any>;
  required?: boolean;
  placeholder?: string;
}
