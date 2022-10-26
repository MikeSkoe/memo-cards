type review = {
    toReview: list<Card.t>,
    reviewing: Card.t,
    remember: list<Card.t>,
    forget: list<Card.t>,
}

let emptyReview = {
    toReview: list{},
    reviewing: Card.empty,
    remember: list{},
    forget: list{},
}

type t = Review(review) | Overview;

let empty = Overview;

let make = (cards: list<Card.t>) => switch cards {
    | list{head, ...tail} => Review({
        ...emptyReview,
        reviewing: head,
        toReview: tail,
    })
    | list{} => Overview
}

module Update = {
    let next = ({ toReview, reviewing, remember, forget }, known) => switch toReview {
        | list{head, ...tail} => Some({
            reviewing: head, 
            toReview: tail,
            remember: known ? list{Card.Update.next(reviewing), ...remember} : remember,
            forget: known ? forget : list{Card.Update.back(reviewing), ...forget},
        })
        | list{} => None
    }
}

