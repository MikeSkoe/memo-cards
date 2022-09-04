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

let make = (({ cards }): Box.t) => switch cards {
    | list{head, ...tail} => Review({
        ...emptyReview,
        reviewing: head,
        toReview: tail,
    })
    | list{} => Overview
}

module Update = {
    let next = (t, known: bool) => switch t {
        | Review({ toReview, reviewing, remember, forget }) => switch toReview {
            | list{head, ...tail} => Review({
                reviewing: head, 
                toReview: tail,
                remember: known ? list{reviewing, ...remember} : remember,
                forget: known ? forget : list{reviewing, ...forget},
            })
            | list{} => Overview
        }
        | Overview => Overview
    }
}

