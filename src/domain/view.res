type review = {
    toReview: Stack.t,
    reviewing: Card.t,
    remember: Stack.t,
    forget: Stack.t,
    skipped: Stack.t,
}

let emptyReview = {
    toReview: Stack.empty,
    reviewing: Card.empty,
    remember: Stack.empty,
    forget: Stack.empty,
    skipped: Stack.empty,
}

type t = InProgress(review) | Done(Stack.t) | Overview;

let empty = Overview;

let make = (head: Card.t, tail: Stack.t) => InProgress({
    ...emptyReview,
    reviewing: head,
    toReview: tail,
});

// -- UPDATE --

let next = ({ toReview, reviewing, remember, forget, skipped }, familiarity) => {
    let reviewing' = reviewing->Card.mapLevel(Card.shiftLevel(_, familiarity));

    let forget = familiarity == Card.Back
        ? forget->Stack.addCard(reviewing')
        : forget;
    let skipped = familiarity == Card.Skip
        ? skipped->Stack.addCard(reviewing')
        : skipped;
    let remember = familiarity == Card.Next
        ? remember->Stack.addCard(reviewing')
        : remember;

    switch toReview {
        | list{} => Done(
            forget
            ->Stack.addCard(reviewing')
            ->Stack.concat(skipped)
            ->Stack.concat(remember)
        )
        | list{head, ...tail} => InProgress({
            toReview: tail,
            reviewing: head,
            remember,
            forget,
            skipped,
        })
    }
};

