import Image from "next/image";
import styles from "./footer.module.css";
import { Envelope, MapPin, Phone, WhatsappLogo } from "@phosphor-icons/react";
import Button from "@/components/button";
import { useRouter } from "next/navigation";

const Footer = () => {
  const router = useRouter();
  return (
    <footer className={styles.footer}>
      <div className={styles.footerContent}>
        <div className={styles.left}>
          <h2>Contato</h2>
          <div className={styles.items}>
            <Envelope size={32} />
            <span>contato@belospace.com.br</span>
          </div>
          <div className={styles.items}>
            <WhatsappLogo size={32} />
            <span>+55 31 99999-9999</span>
          </div>
          <div className={styles.items}>
            <Phone size={32} />
            <span>+55 31 99999-9999</span>
          </div>
          <Button
            className={styles.items}
            onClick={() => router.push("/reservation")}
          >
            Agende sua reserva
          </Button>
        </div>
        <div className={styles.logo}>
          <Image
            src={"/logo.png"}
            alt="Logo BeloSpace"
            width={180}
            height={180}
          />
        </div>
        <div className={styles.rigth}>
          <h2>Nossa unidade</h2>
          <div className={styles.items}>
            <span>
              BeloSpace Sion - Rua Fulano de tal, 999 Sion - Belo Horizonte
            </span>
            <MapPin size={32} />
          </div>
        </div>
      </div>
      <span className={styles.copyrigth}>
        Copyright © 2025 | Powered by <strong>BeloSpace</strong>
      </span>
    </footer>
  );
};

export default Footer;
