type review = {
    toReview: Stack.t,
    reviewing: option<Card.t>,
    remember: Stack.t,
    forget: Stack.t,
}

let emptyReview = {
    toReview: Stack.empty,
    reviewing: None,
    remember: Stack.empty,
    forget: Stack.empty,
}

type t = Review(review) | Overview;

let empty = Overview;

let make = (head: Card.t, tail: Stack.t) => Review({
    ...emptyReview,
    reviewing: Some(head),
    toReview: tail,
});

module Update = {
    let next = ({ toReview, reviewing, remember, forget }, known) => {
        let (remember, forget) = switch (known, reviewing) {
            | (true, Some(review)) => (
                remember->Stack.Update.addCard(Card.Update.next(review)),
                forget,
            )
            | (false, Some(review)) => (
                remember,
                forget->Stack.Update.addCard(Card.Update.back(review)),
            )
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

