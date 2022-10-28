type t = list<Card.t>;

type iteration = int;

let empty: t = list{};

let make = (~cards) => { cards };

module Update = {
    let addCard = (t: t, card: Card.t): t => list{card, ...t}

    let updateCard = (t: t, newCard: Card.t): t => 
        t->Belt.List.map(card => card.front === newCard.front && card.back === newCard.back ? newCard : card)

    let rec updateCards = (t: t, cards: t): t => switch cards {
        | list{} => t
        | list{head, ...tail} => updateCards(updateCard(t, head), tail)
    }
}

module Selectors = {
    let getByLevel = (t: t, level): list<Card.t> =>
        t->Belt.List.keep(card => card.level === level);

    let getCards = (t: t, iteration: iteration): t => {
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

