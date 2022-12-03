/*
  Funções Puras
  -  O que são ?
      1. Dada uma mesma entrada, vamos receber sempre a mesma saída
        - O fato de ela sempre receber os mesmos argumentos e, não trabalhar com nenhum global, faz a função retorne a mesma saída
        - Para mantermos uma função pura nós temos que pensar que não podemos trabalhar com valores externos/globais

      2. Não produzem side-effects
         - O que são side-effects (efeitos colaterais) ? 
           - Qualquer operação que interaja com o mundo externo (Requests, DOM, Banco de Dados...) causando alguma mudança na aplicação

  -  Vantagens e Desvantagens
  -  O que são side-effects ou efeitos colaterais ?
  -  Exemplos práticos
*/

let sum = (a, b) => a + b
let result = sum(1, 2)

Js.log(result)

let a = 1

// Função impura
let impureSum = b => {
  a + b
}

let result = impureSum(10)
Js.log(result)

// No dia a dia teremos funções que causam efeitos colaterais.
/* let requestData = () => { */
/* Fetch.get("...") */
/* ->Promise.then(data => { */
/* Js.log(`Hello ${data.name}`) */
/* } */
/* } */
