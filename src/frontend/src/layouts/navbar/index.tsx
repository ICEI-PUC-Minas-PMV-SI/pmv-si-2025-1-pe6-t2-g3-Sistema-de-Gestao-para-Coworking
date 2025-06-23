import {
  List,
  X,
  SignIn,
  UserCircle,
  CaretUp,
  CaretDown,
} from "@phosphor-icons/react";
import styles from "./nav.module.css";
import { useState } from "react";
import { useRouter } from "next/navigation";
import Image from "next/image";
import Button from "@/components/button";
import { useAuthStore } from "@/stores/useAuthStore";

const Navbar = () => {
  const router = useRouter();
  const { user, logout } = useAuthStore();
  const [menuOpen, setMenuOpen] = useState(false);
  const [showDropdown, setShowDropdown] = useState(false);

  const handleLogout = () => {
    logout();
    router.push("/login");
  };

  return (
    <>
      <nav className={styles.nav}>
        <div className={styles.logo}>
          <Image
            src={"/logo.png"}
            alt="Logo BeloSpace"
            width={160}
            height={160}
            onClick={() => router.push("/")}
          />
        </div>
        <div className={`${styles.navItens} ${menuOpen ? styles.show : ""}`}>
          <a
            onClick={() => {
              const section = document.getElementById("units");
              section?.scrollIntoView({ behavior: "smooth" });
              setMenuOpen(false);
            }}
          >
            Unidades
          </a>
          <a
            onClick={() => {
              const section = document.getElementById("services");
              section?.scrollIntoView({ behavior: "smooth" });
              setMenuOpen(false);
            }}
          >
            Serviços
          </a>
          <a
            onClick={() => {
              const section = document.getElementById("about");
              section?.scrollIntoView({ behavior: "smooth" });
              setMenuOpen(false);
            }}
          >
            Sobre nós
          </a>
        </div>
        <div className={`${styles.buttonGroup} ${menuOpen ? styles.show : ""}`}>
          <Button onClick={() => router.push("/reservation")}>
            Agende sua reserva
          </Button>
          {!user ? (
            <Button
              appearance="secondary"
              onClick={() => router.push("/login")}
            >
              <>
                <SignIn size={16} />
                Entrar
              </>
            </Button>
          ) : (
            <div className={styles.profileMenu}>
              <button
                className={styles.profileIcon}
                onClick={() => setShowDropdown(!showDropdown)}
              >
                <UserCircle size={40} color="#F5820F" weight="fill" />
                {showDropdown ? (
                  <CaretUp size={21} color="#F5820F" />
                ) : (
                  <CaretDown size={21} color="#F5820F" />
                )}
              </button>
              {showDropdown && (
                <div className={styles.dropdown}>
                  <a
                    onClick={() => {
                      router.push("/manage-reservation");
                      setShowDropdown(!showDropdown);
                    }}
                  >
                    Minhas reservas
                  </a>
                  <a
                    onClick={() => {
                      router.push("/reservation");
                      setShowDropdown(!showDropdown);
                    }}
                  >
                    Reservar
                  </a>
                  <a onClick={handleLogout}>Sair</a>
                </div>
              )}
            </div>
          )}
        </div>
        <button
          className={styles.menuBtn}
          onClick={() => setMenuOpen(!menuOpen)}
        >
          {menuOpen ? <X size={28} /> : <List size={28} />}
        </button>
      </nav>
    </>
  );
};

export default Navbar;
