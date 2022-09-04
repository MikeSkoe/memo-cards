type t = {
    new: Box.t,
    familiar: Box.t,
    remember: Box.t,
    know: Box.t,
    done: Box.t,
};

type iteration = int;

let empty = {
    new: Box.empty->Box.Update.add(Card.make(~front="new card fron", ~back="the card back")),
    familiar: Box.empty,
    remember: Box.empty,
    know: Box.empty,
    done: Box.empty,
};

let make = (~new, ~familiar, ~remember, ~know, ~done) => {
    new, familiar, remember, know, done,
};

module Update = {
    let addCard = (t: t, card: Card.t): t => {
        ...t,
        new: t.new->Box.Update.add(card),
    }
}

module Selectors = {
    let getBoxes = (t: t, iteration: iteration): Box.t => {
        let reviewEach = (day, cards) => mod(iteration, day) === 0 ? cards : list{};

        let cards =
            t.new.cards
            ->Belt.List.concat(reviewEach(2, t.familiar.cards))
            ->Belt.List.concat(reviewEach(3, t.remember.cards))
            ->Belt.List.concat(reviewEach(4, t.know.cards));

        Box.make(~cards=cards)
    };
}

