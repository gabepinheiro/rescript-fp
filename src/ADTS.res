/*
 ADTS/Algebraic Data Types (Tipos Algébricos de Dados) 
 1. O que são ADTs ?
    - ADTS basicamento são tipos de dados compostos por outros tipos.
    - Podemos utilizar ADT em qualquer linguagem, pode-se utilizar em JS, TS, ReScript... a diferença é o suporte/sintaxe de cada uma
      linguagem utiliza. Desde q se tenha uma forma de definir e destinguir esses tipos vc tem um ADT.
      - Array é um ADT, por exemplo

 2. O que são product types
    - Basicamente é uma estrutura que permite que vc tenha numa mesma estrutura dois valores ou mais diferentes ao mesmo tempo

 3. O que são sum types
    - Uma lista de opções bem definidas e que vai assumir como type uma única opção desta lista
    - Em TypeScript chamamos isso de Union Type, geralmente.
 4. Mas porque o nome "product" e "sum"
 5. Utilizando ADTs para modelar sua lógica
*/

// Sum types
type name = string
type age = int

//Product type
// Dois valores numa mesma estrutura
type person = (name, age)

// Product type
// person é composto por name E age
let person: person = ("Gabe", 20)

type myBool = False | True
//Product type
// Product type (Produto) é sobre multiplicar as possibilidades
type tupleBool = (myBool, myBool)
let tuple1 = (False, False)
let tuple2 = (True, True)
let tuple3 = (True, False)
let tuple4 = (False, True)

// A diferença entre sum types e product types é que ao invés de ter uma estrutura que possui 2 valores (ou mais) teremos um set/lista
// de opções bem definidas para o nosso tipo

// Variants
// Sum type
// Sum (soma) ele vai somar as possibilidades
type state = Loading | Success | Error
// state é Loading OU Success OU Error

@react.component
let make = () => {
  <div>
    <h1> {`Hello from React + ReScript and Vite`->React.string} </h1>
  </div>
}
