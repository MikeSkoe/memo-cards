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
        cards->Belt.List.keep(card => card.level === level);

    let getCards = (t: t, iteration: iteration): list<Card.t> => {
        let rec sliceFirstEmptyLists = (lst: list<list<Card.t>>): list<list<Card.t>> => switch lst {
            | list{head, ...tail} if Belt.List.size(head) == 0 => sliceFirstEmptyLists(tail)
            | list{_head, ..._} => lst
            | list{} => lst
        };

        list{Card.New, Card.Familiar, Card.Remember, Card.Know}
            ->Belt.List.map(getByLevel(t))
            ->sliceFirstEmptyLists
            ->Belt.List.mapWithIndex((day, cards) => mod(iteration, day + 1) === 0 ? cards : list{})
            ->Belt.List.reduce(list{}, Belt.List.concat)
    };
}

