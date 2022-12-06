/*
  Monads
   - Introdução
   - Manipulando o DOM de forma unsafe
   - Criando nossa propria Monad
   - Manipulando o DOM de maneira safe com Monads
   - Utilizando rescript-webapi + Optional Monad do ReScript
   - Combinando pipe + Monads
   - A anatomia de uma Monad e suas regras 
   - Quando utilizar Monads ?
*/

//Construindo nossa propria Optional Monad
module Optional = {
  /* type t<'a> = None | Some('a) */
  type t<'a> = option<'a>

  let return = value => Some(value)

  let flatMap = (optional, function) =>
    switch optional {
    | None => None
    | Some(value) => function(value)
    }

  let getWithDefault = (optional, defaultValue) =>
    switch optional {
    | None => defaultValue
    | Some(value) => value
    }
}

// Valores de apoio
let x = 1
let f = a => Optional.return(a + 1)
let m = Optional.return(x)
let g = a => Optional.return(a * 2)

// 3 leis que define o que é uma Monad
// 1. Left Identity
Js.log3("1. Left Identity => ", Optional.return(x)->Optional.flatMap(f), f(x))

// 2. Right Identity
Js.log3("2. Right Identity => ", m->Optional.flatMap(Optional.return), m)

// 3. Associative
Js.log2(
  "3. Associative => ",
  m->Optional.flatMap(f)->Optional.flatMap(g) ==
    m->Optional.flatMap(x => x->f->Optional.flatMap(g)),
)

module Dom = {
  @val external document: Dom.element = "document"
  @send @return(nullable)
  external querySelector: (Dom.element, string) => option<Dom.element> = "querySelector"
  @get external innerText: Dom.element => string = "innerText"
}

@react.component
let make = () => {
  React.useEffect0(() => {
    open Dom

    // Utilizando o Module Belt para lidar com a Modad Optional
    document
    ->querySelector(".main-container")
    ->Belt.Option.flatMap(container => container->querySelector("h2"))
    ->Belt.Option.flatMap(element => element->innerText->Optional.return)
    ->Belt.Option.flatMap(innerText => `Elemento, innerText: ${innerText}`->Optional.return)
    ->Belt.Option.getWithDefault("Elemento não encontrado")
    ->Js.log

    // Utilizando nossa propria Monad Optional e com getWithDefault
    /* let result = */
    /* document */
    /* ->querySelector(".main-container") */
    /* ->Optional.flatMap(container => container->querySelector("h2")) */
    /* ->Optional.flatMap(element => element->innerText->Optional.return) */
    /* ->Optional.flatMap(innerText => `Elemento, innerText: ${innerText}`->Optional.return) */
    /* ->Optional.getWithDefault("Elemento não encontrado") */
    //->Js.log

    /* Js.log(result) */

    // Sem getWithDefault
    /* switch result { */
    /* | None => Js.log("Elemento não encontrado") */
    /* | Some(text) => Js.log(text) */
    /* } */

    /* let container = document->querySelector(".main-container") */
    /*  */
    /* switch container { */
    /* | None => Js.log("Elemento não encontrado") */
    /* | Some(element) => */
    /* switch element->querySelector("h2") { */
    /* | None => Js.log("Elemento não encontrado") */
    /* | Some(element) => Js.log(`Element encontrado, innerText: ${element->innerText}`) */
    /* } */
    /* } */

    None
  })
  <div className="main-container">
    {`Outra parte do texto`->React.string}
    <h2> {`Monads`->React.string} </h2>
  </div>
}
