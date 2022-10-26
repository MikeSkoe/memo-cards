type t = {
    cards: list<Card.t>,
};

type iteration = int;

let empty = {
    cards: list{}
};

let make = (~cards) => { cards };

module Update = {
    let addCard = (t: t, card: Card.t): t => {
        cards: list{card, ...t.cards},
    }

    let updateCard = (t: t, card: Card.t): t => {
        cards: t.cards->Belt.List.map(crd => crd.front === card.front && card.back === card.back ? card : crd)
    }

    let rec updateCards = (t: t, cards: list<Card.t>): t => switch cards {
        | list{} => t
        | list{head, ...tail} => updateCards(updateCard(t, head), tail)
    }
}

module Selectors = {
    let getByLevel = ({ cards }: t, level): list<Card.t> =>
        cards
        ->Belt.List.keep(card => card.level === level);

    let getCards = (t: t, iteration: iteration): list<Card.t> => {
        let reviewEach = (day, cards) =>
            mod(iteration, day) === 0
            ? cards
            : list{};

        getByLevel(t, Card.New)
            ->Belt.List.concat(reviewEach(2, getByLevel(t, Card.Familiar)))
            ->Belt.List.concat(reviewEach(3, getByLevel(t, Card.Remember)))
            ->Belt.List.concat(reviewEach(4, getByLevel(t, Card.Know)));
    };
}

