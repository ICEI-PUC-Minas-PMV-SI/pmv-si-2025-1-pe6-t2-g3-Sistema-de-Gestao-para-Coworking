interface Card {
  src: string;
  title: string;
  description: string;
}

export interface CardCarouselProps {
  cards: Card[];
  width: number;
  height: number;
}
