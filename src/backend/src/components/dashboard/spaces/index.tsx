import Button from "@/components/button";
import styles from "./spaces.module.css";
import { ImageCarousel } from "@/components/carousel/carousel";
import { useRouter } from "next/navigation";

const Spaces = () => {
  const router = useRouter();
  return (
    <div className={styles.container}>
      <ImageCarousel
        images={[
          {
            src: "/assets/spaces/spaces-image.png",
            alt: "Tela inicial espaços 1",
          },
          {
            src: "/assets/spaces/spaces-image2.png",
            alt: "Tela inicial espaços 2",
          },
          {
            src: "/assets/spaces/spaces-image3.png",
            alt: "Tela inicial espaços 3",
          },
        ]}
        width={150}
        height={80}
      />
      <div className={styles.textBox}>
        <h1>Descubra nossos novos locais!</h1>
        <span>
          A Belo Space é um coworking feito para empresas transformadoras, de
          todos os tamanhos.
        </span>
        <span>
          Temos escritórios, estações de trabalho, salas de reunião e espaços
          para eventos corporativos para diversos formatos de times e empresas.
        </span>
        <Button onClick={() => router.push("/reservation")}>
          Agende já sua reserva
        </Button>
      </div>
    </div>
  );
};

export default Spaces;
