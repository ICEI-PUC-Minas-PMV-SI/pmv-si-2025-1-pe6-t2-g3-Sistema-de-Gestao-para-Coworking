import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay, Navigation, Pagination } from "swiper/modules";
import Image from "next/image";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import { CardCarouselProps } from "./interface";
import styles from "./card-carousel.module.css";

export const CardCarousel = ({ cards, width, height }: CardCarouselProps) => {
  return (
    <Swiper
      className={styles.swiper}
      modules={[Navigation, Pagination, Autoplay]}
      navigation
      pagination={{ clickable: true }}
      spaceBetween={20}
      slidesPerView={2}
      autoplay={{
        delay: 5000,
        disableOnInteraction: false,
      }}
    >
      {cards.map((card, index) => (
        <SwiperSlide className={styles.swiperSlide} key={index}>
          <div className={styles.card}>
            <h2>{card.title}</h2>
            <div
              className={styles.imageContainer}
              style={{
                width: `${width}vh`,
                height: `${height}vh`,
              }}
            >
              <Image
                src={card.src}
                alt={card.title}
                fill
                style={{ objectFit: "cover" }}
              />
            </div>
            <div className={styles.content}>
              <p>{card.description}</p>
            </div>
          </div>
        </SwiperSlide>
      ))}
    </Swiper>
  );
};
