let s = React.string

/*
  Result Monad Type // Result type ou Result.t
  - 1. O que é ?
       - Uma estrutura que também pode ser considerada uma Monad
       - É utilizar para fazer tratamento de casos onde pode ser que algo dar errado (não necessariamente com exceções)
       - Uso de Variants para substituir exceções
       - Basicamente, o Result Type é uma forma de representar uma operação que pode dar `certo` ou `errado`. 
       - É mais utilizado para operações que podem da certo ou errado. Se dê certo, vc terá o dado e se dê errado, vc terá o error
       - É muito parecido com o type Option Monad, a diferença é que no Result type vc terá "duas caixas" (Ok e Error) segurando algum valor.
       - Left or Right. Certo -> Left // Errado -> Right

  - 2. Como e quando utilizar ?
      - Quando precisar fazer alguma operação, busca e/ou executar alguma coisa que vai te retornar algo mas vc ñ tem certeza se a mesma vai dar certo.
        - Buscas em API's
        - Buscas em Banco de Dados
        - Buscas nos recursos do Browser

  - 3. Utilizando com Pattern Matching Belt.Result.t
  - 4. Exemplo de uso com fetch + rescript-jzon
*/

// Exemplo simples validando uma idade e retornando Result
let validateAge = age => age >= 18 ? Ok(`Maior de idade`) : Error(`Menor de Idade`)

// Definindo o tipo a nível do ReScripto
type user = {
  id: int,
  name: string,
  username: string,
  email: string,
}

// Definindo um `codec` para validar com o dado retornado da API e checar se está de acordo com o `contrato` definido entre o FRONT x BACK
let codec = Jzon.object4(
  ({id, name, username, email}) => (id, name, username, email),
  ((id, name, username, email)) => Ok({id, name, username, email}),
  Jzon.field("id", Jzon.int),
  Jzon.field("name", Jzon.string),
  Jzon.field("username", Jzon.string),
  Jzon.field("email", Jzon.string),
)

let apiUrl = "https://jsonplaceholder.typicode.com/users"

let getUser = (~id) => {
  open Webapi

  Fetch.fetch(`${apiUrl}/${id->Js.Int.toString}`)
  ->Promise.then(Fetch.Response.json)
  ->Promise.thenResolve(json => json->Jzon.decodeWith(codec)) // Validando o contrato
}

type state = Loading | Error | Data(user)

@react.component
let make = () => {
  let (state, setState) = React.useState(_ => Loading)

  React.useEffect0(() => {
    //Usando o Pattern Matching para abrir as caixas do result type
    /* switch validateAge(10) { */
    /* | Ok(message) => Js.log(message) */
    /* | Error(error) => Js.Console.log(error) */
    /* } */

    // Usando o Module Belt.Result para manipular o result type
    /* validateAge(18) */
    /* ->Belt.Result.map(message => `Success: ${message}`) */
    /* ->Belt.Result.getWithDefault("MENOR DE IDADE") */
    /* ->Js.log */

    // Consumindo o result type utilizando o Module Betl.Result.t
    getUser(~id=1)
    ->Promise.thenResolve(result =>
      result->Belt.Result.map(data => Data(data))->Belt.Result.getWithDefault(Error)
    )
    ->Promise.thenResolve(result => setState(_ => result))
    ->ignore

    // Consumindo a Promise e o result type com Pattern Matching
    /* getUser(~id=1) */
    /* ->Promise.thenResolve(result => */
    /* switch result { */
    /* | Ok(user) => setState(_ => Data(user)) */
    /* | Error(_) => setState(_ => Error) */
    /* } */
    /* ) */
    /* ->ignore */

    None
  })

  <div className="main-container">
    <h2> {`Result Type`->s} </h2>
    {switch state {
    | Loading => <h3> {`Loading`->s} </h3>
    | Data(user) => <h3> {`${user->Jzon.encodeStringWith(codec)}`->s} </h3>
    | Error => <h3> {`Error :(`->s} </h3>
    }}
  </div>
}
