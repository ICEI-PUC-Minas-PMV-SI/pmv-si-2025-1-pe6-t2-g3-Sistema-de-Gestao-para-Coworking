import { CardCarousel } from "@/components/card-carousel/card-carousel";
import styles from "./units.module.css";

const Units = () => {
  return (
    <section id="units" className={styles.container}>
      <div className={styles.screenAbout}>
        <h2>Nossas Unidades</h2>
        <span>
          Nossas unidades de coworking foram pensadas para impulsionar a
          inovação, a colaboração e o crescimento sustentável.
        </span>
        <span>
          Com espaços modernos, infraestrutura de ponta e um ambiente que
          respira tecnologia, oferecemos soluções flexíveis para startups,
          empresas de tecnologia e profissionais que buscam mais do que apenas
          um local de trabalho.
        </span>
      </div>
      <CardCarousel
        cards={[
          {
            src: "/assets/units/units-image1.png",
            title: "BeloSpace Sion",
            description:
              "Tranquilidade e sofisticação em um dos bairros mais charmosos de BH. Ideal para quem busca foco com um toque de natureza urbana.",
          },
          {
            src: "/assets/units/units-image2.png",
            title: "BeloSpace Lourdes ",
            description:
              "Elegância e praticidade no coração da cidade. Um espaço premium para negócios e conexões de alto nível.",
          },
          {
            src: "/assets/units/units-image3.png",
            title: "BeloSpace Cruzeiro",
            description:
              "Um refúgio acolhedor e funcional em meio à cidade. Para quem quer trabalhar com leveza e eficiência.",
          },
          {
            src: "/assets/units/units-image4.png",
            title: "BeloSpace Floresta",
            description:
              "A vibe autêntica da Floresta combinada com tecnologia e design. Um espaço para crescer com originalidade.",
          },
          {
            src: "/assets/units/units-image5.png",
            title: "BeloSpace Gutierrez",
            description:
              "Equilíbrio entre modernidade e bem-estar em um bairro residencial e cheio de estilo. Trabalhe perto de casa, com tudo o que você precisa.",
          },
        ]}
        width={47}
        height={40}
      />
    </section>
  );
};

export default Units;
