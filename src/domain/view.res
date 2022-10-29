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

let andThen = (f, g, x) => x->f->g;

module Update = {
    let next = ({ toReview, reviewing, remember, forget }, known) => {
        let remember = (known ? reviewing : None)
            ->Belt.Option.map(
                andThen(Card.Update.next, Stack.Update.addCard(remember)),
            )
            ->Belt.Option.getWithDefault(remember);

        let forget = (!known ? reviewing : None)
            ->Belt.Option.map(
                andThen(Card.Update.back, Stack.Update.addCard(forget)),
            )
            ->Belt.Option.getWithDefault(forget);

        let (reviewing, toReview) = switch toReview {
            | list{head, ...tail} => (Some(head), tail)
            | list{} => (None, list{})
        }

        { reviewing, toReview, remember, forget }
    };
}

