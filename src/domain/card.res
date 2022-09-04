type text = string;

type t = {
    front: text,
    back: text,
}

let empty: t = { front: "", back: "" }

let make = (~front, ~back): t => { front, back }
