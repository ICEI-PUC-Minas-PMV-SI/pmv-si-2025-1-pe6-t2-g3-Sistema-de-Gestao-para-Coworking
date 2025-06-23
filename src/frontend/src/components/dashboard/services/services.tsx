import { CardCarousel } from "@/components/card-carousel/card-carousel";
import styles from "./services.module.css";

const Services = () => {
  return (
    <section id="services" className={styles.container}>
      <div className={styles.screenAbout}>
        <h2>Nossos serviços</h2>
        <span>
          Nossos espaços foram desenvolvidos para promover a criatividade e a
          boa produtividade, com o mínimo de stress.
        </span>
        <span>
          Na Belo Space você encontra diversas opções de espaços compartilhados
          ou privativos, equipados e estruturados com o melhor das tecnologias e
          engenharias socioambientais.
        </span>
      </div>
      <CardCarousel
        cards={[
          {
            src: "/assets/services/services-image1.png",
            title: "Espaço Criativo",
            description:
              "Diversas opções e formatos de salas de reunião para você e sua equipe trabalharem em um espaço surpreendente e agradável.",
          },
          {
            src: "/assets/services/services-image2.png",
            title: "Salas Privadas",
            description:
              "Você pode ter uma mesa exclusiva e dedicada com escaninho/gaveteiro em uma sala compartilhada.",
          },
          {
            src: "/assets/services/services-image3.png",
            title: "Ambiente especial",
            description:
              "Um ambiente totalmente pensado no bem-estar em acordo com o meio ambiente.",
          },
          {
            src: "/assets/services/services-image4.png",
            title: "Equipamento e Tecnologia",
            description:
              "Salas com equipamentos pensados na melhor perfomance para você e sua equipe.",
          },
        ]}
        width={47}
        height={40}
      />
    </section>
  );
};

export default Services;
