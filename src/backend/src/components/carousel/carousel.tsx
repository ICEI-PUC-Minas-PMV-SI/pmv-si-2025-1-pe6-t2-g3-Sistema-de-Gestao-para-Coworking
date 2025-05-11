import { Swiper, SwiperSlide } from "swiper/react";
import { Autoplay, Navigation, Pagination } from "swiper/modules";
import Image from "next/image";
import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import { ImageCarouselProps } from "./interface";
import styles from "./carousel.module.css";

export const ImageCarousel = ({
  images,
  width,
  height,
}: ImageCarouselProps) => {
  return (
    <Swiper
      className={styles.swiper}
      modules={[Navigation, Pagination, Autoplay]}
      pagination={{ clickable: true }}
      spaceBetween={20}
      slidesPerView={1}
      autoplay={{
        delay: 3000,
        disableOnInteraction: false,
      }}
    >
      {images.map((img, index) => (
        <SwiperSlide key={index}>
          <div
            className={styles.image}
            style={{
              width: `${width}vh`,
              height: `${height}vh`,
            }}
          >
            <Image
              src={img.src}
              alt={img.alt || `Imagem ${index + 1}`}
              fill
              style={{ objectFit: "cover" }}
              priority={index === 0}
            />
          </div>
        </SwiperSlide>
      ))}
    </Swiper>
  );
};
