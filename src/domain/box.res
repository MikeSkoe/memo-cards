type t = {
    cards: list<Card.t>,
}

let empty = {
    cards: list{}
}

let make = (~cards): t => { cards: cards }

module Update = {
    let add = (t, card): t => {
        cards: t.cards->Belt.List.add(card)
    }
}

