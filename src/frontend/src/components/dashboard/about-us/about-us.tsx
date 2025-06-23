import Image from "next/image";
import styles from "./about-us.module.css";

const AboutUs = () => {
  return (
    <section id="about" className={styles.container}>
      <div className={styles.containerTitle}>
        <h2>Sobre nós</h2>
      </div>
      <div className={styles.content}>
        <span>
          O Belo Space nasceu em Belo Horizonte da vontade de criar um ambiente
          de trabalho que fosse bonito, funcional e inspirador. Fundado por
          amigos apaixonados por criatividade e conexão, o espaço surgiu como
          alternativa aos escritórios engessados e cafés improvisados.
          <br />
          <br />
          Aqui, unimos estrutura de ponta com bem-estar: internet de altíssima
          velocidade, estúdios de vídeo e podcast, auditórios modernos e um
          ambiente que mistura natureza, conforto e tecnologia. Cada detalhe foi
          pensado para estimular a criatividade e facilitar conexões.
          <br />
          <br />
          Somos mais que um coworking — somos um espaço vivo, feito para quem
          busca leveza, foco e um lugar onde boas ideias se encontram.
        </span>
        <Image
          src={"/assets/about/about-image.png"}
          alt="Sobre nós"
          width={800}
          height={600}
        />
      </div>
    </section>
  );
};

export default AboutUs;
