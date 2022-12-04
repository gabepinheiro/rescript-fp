/*
  Function Composition (Composição de funções)
  1. O que é composição de funções ?
     - Composição de funções nada mais é que a gente compor uma função utilizando outras funções.
     - Utilizar outras funções da maiores ou menores para compormos uma nova função.
     - Compor uma função maior quebrando ela em funções menores
     - Podemos fazer um pararelo entre composição de funções com components que criamos em React para montar uma interface
       ou até mesmo compor outros components.

  2. Qual a relação com currying <> pipe operator <> first class/hof
  3. Como quebrar um problema em funções menores
  4. O diferencial do pipe-operator para composição de funções
  5. Proposal do TC39 para o JavaScript
  6. Exemplos práticos
  7. Vantagens
     - 1. Um código mais conciso.
     - 2. Mais previsibilidade
     - 3. Um código mais fácil de testar
     - 4. Um código mais fácil de debugar
     - 5. Uma melhoria significativa na legibildiade, evitando em escrever um código mais imperativo - um código extenso com vários comandos/ações
          dentro de um mesmo bloco. Não que funções maiores sejam ruins mas quando a gente quebra um problema em problema menores a gente tem essas vantagens de composição.
     - 6. Reaproveitamento código.
     - 7. Reduzir complexidade
     - 8. Reduir acoplamentos de código.
*/

//Funções menores
let sum = (a, b) => a + b
let double = a => a * 2
let square = a => a * a

// Sem utilizar composição
let calculateWihoutComposition = value => {
  let result = (value + 10) * 2
  result * result
}
Js.log(calculateWihoutComposition(10))

// Com composição mas sem a utilização do pipe-operator
let calculateWithComposition = value => square(double(sum(value, 10)))
Js.log(calculateWithComposition(10))

// Composição + Pipe Operator
let calculatePipeOperator = value => value->sum(10)->double->square
Js.log(calculatePipeOperator(10))

type person = {name: string, age: int}
let people = [
  {name: `Alonzo Church`, age: 30},
  {name: `Alan Turing`, age: 32},
  {name: `Jéssica Alves`, age: 22},
  {name: `João Silva`, age: 19},
]

let underAge = (people, ~age) => people->Js.Array2.filter(person => person.age < age)

let splitBySpace = value => value->Js.String2.split(" ")
let toLowerCase = values => values->Js.Array2.map(Js.String2.toLowerCase)
let joinWith = (values, ~separator) => values->Js.Array2.joinWith(separator)
let prepend = (a, b) => `${b}/${a}`

// Alonzo Church => alonzo-church => https://myurl.com/alonzo-church
let slugfy = (~url, path) => {
  path
  //
  ->splitBySpace
  ->toLowerCase
  ->joinWith(~separator="-")
  ->prepend(url)
  ->Js.Global.encodeURI
}

Js.log(slugfy(~url="https:es77.dev", `João Silva`))

let slugfyWithEs77 = slugfy(~url="https://es77.dev")
let slugfyWithOtherDomain = slugfy(~url="https://mydomain.com")

Js.log(people->underAge(~age=30)->Js.Array2.map(person => person.name->slugfyWithEs77))
Js.log(people->underAge(~age=30)->Js.Array2.map(person => person.name->slugfyWithOtherDomain))

@react.component
let make = () => {
  <div>
    <h1> {`Hello from React + ReScript and Vite`->React.string} </h1>
  </div>
}
