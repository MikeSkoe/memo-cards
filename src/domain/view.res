type review = {
    toReview: list<Card.t>,
    reviewing: option<Card.t>,
    remember: list<Card.t>,
    forget: list<Card.t>,
}

let emptyReview = {
    toReview: list{},
    reviewing: None,
    remember: list{},
    forget: list{},
}

type t = Review(review) | Overview;

let empty = Overview;

let make = (cards: list<Card.t>) => switch cards {
    | list{head, ...tail} => Review({
        ...emptyReview,
        reviewing: Some(head),
        toReview: tail,
    })
    | list{} => Overview
};

module Update = {
    let next = ({ toReview, reviewing, remember, forget }, known) => {
        let (remember, forget) = switch (known, reviewing) {
            | (true, Some(review)) => (list{Card.Update.next(review), ...remember}, forget )
            | (false, Some(review)) => (remember, list{Card.Update.back(review), ...forget})
            | (true, None)
            | (false, None) => (remember, forget)
        }
        let (reviewing, toReview) = switch toReview {
            | list{head, ...tail} => (Some(head), tail)
            | list{} => (None, list{})
        }

        { reviewing, toReview, remember, forget }
    };
}

