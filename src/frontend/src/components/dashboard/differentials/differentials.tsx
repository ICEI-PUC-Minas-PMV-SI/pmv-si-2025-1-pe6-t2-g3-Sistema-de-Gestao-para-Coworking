import { Aperture, Leaf, Waveform, WifiHigh } from "@phosphor-icons/react";
import styles from "./differentials.module.css";

const Differentials = () => {
  return (
    <div className={styles.container}>
      <div className={styles.screenAbout}>
        <h2>Diferenciais da Belo Space</h2>
        <span>
          Somos o que existe de mais avançado e inovador no mercado de
          coworking. <br />
          Conheça nossos espaços e transforme-se.
        </span>
      </div>
      <div className={styles.content}>
        <div className={styles.row}>
          <div className={styles.rowItem}>
            <Aperture size={64} weight="fill" />
            <h1>STUDIO LAB</h1>
            <br />
            <span>
              Somos um coworking completo, com estúdios de vídeo e podcast de
              diferentes tamanhos, que vão de 10m² a 100m², prontos para atender
              desde criadores independentes até grandes produções.
            </span>
          </div>
          <div className={styles.rowItem}>
            <Leaf size={64} weight="fill" />
            <h1>SOMOS VERDE</h1>
            <br />
            <span>
              Às vezes, você vai se perguntar se entrou em uma floricultura ou
              em um espaço de trabalho. Isso porque acreditamos que ambientes
              bem-cuidados transformam o seu dia e impulsionam a produtividade.
            </span>
          </div>
        </div>
        <div className={styles.line} />
        <div className={styles.row}>
          <div className={styles.rowItem}>
            <WifiHigh size={64} weight="bold" />
            <h1>FIBRA ÓTICA</h1>
            <br />
            <span>
              Nossa internet é de altíssima velocidade, com sistema de
              redundância e gestão de segurança. Utilizamos as melhores
              tecnologias do mercado para garantir estabilidade e desempenho.
            </span>
          </div>
          <div className={styles.rowItem}>
            <Waveform size={64} weight="bold" />
            <h1>AUDITÓRIO LAB</h1>
            <br />
            <span>
              Também oferecemos auditórios modernos, com tratamento acústico e
              estrutura de alto padrão, ideais para palestras, eventos,
              conferências e treinamentos corporativos.
            </span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Differentials;
