---
title: Get Request with Haskell
date: 2017-03-25T20:39:33
tags: haskell, programming
---


## Contextualização

Na [Tougg](https://tougg.com.br), existe uma API 'interna' que retorna informações de um usuário dado seu ID. O end-point é algo como: http:/localhost:3000/api/users/:user_id.

Como eu queria se incomodar com alguma coisa, resolvi tentar escrever um pequeno código Haskell para fazer uma *request* para esse end-point e ler alguma informação do JSON retornado.

Vamos lá.

<!-- more -->

## Primeiras coisas primeiro

Após um pequena busca no google, parece que o package wreq faz esse tipo de trabalho. Então acesso o terminal:

```
> cabal update
> cabal install -j --disable-tests wreq
```
50 horas depois, tudo instalado. Vamos em frente:

### Experimentação no ghci

Vamos fazer alguns testes direto no gchi

```haskell
> import Network.Wreq
> r <- get "http://httpbin.org/get"
> ghci :type r
> r :: Response ByteString
```

Ok,`r`contém a resposta do servidor.

Pelo que parece literais `String` são sempre do tipo `String`. Algumas bibliotecas Haskell mais complexas precisam lidar corretamente com três tipos: `String`, `Text` e `ByteString`. Para não precisarmos usar conversões o tempo todo existe uma extensão chamada `OverloadedStrings`.

Para ativar a extensão:

```haskell
> :set -XOverloadedStrings
```

Pois bem. Vou precisar capturar alguns dados noresponse:

**wreq** usa o *package* **lens**, para várias coisas, inclusive isso, vamos importar

```haskell
> import Control.Lens
```

Agora podemos recuperar algumas informações, como ostatusdo response.

```haskell
> r ^. responseStatus
> Status {statusCode = 200, statusMessage = "OK"}
```

Também podemos fazer composições, como por exemplo para pegar o `statusCode`:

```haskell
> r ^. responseStatus . statusCode
```

Certo, isso já é algo.

### O "projeto"

Vamos colocar isso em um arquivo para ficar mais simples editar:

`> touch tougg-client.hs`
Adicionei apenas o `import`:

```haskell
import Network.Wreq
```

Salvei e:

```
> haskellrun tougg-client.hs

tougg-client.hs:0:53: error:
	• Variable not in scope: main :: IO a0
	• Perhaps you meant ‘min’ (imported from Prelude)
```

Motherfucker!! Então tentei isso:

```haskell
import Network.Wreq

main = do
  putStrln "Hi"
e recebi isso agora.

	tougg-client.hs:6:3: error:
• Variable not in scope: putStrln :: [Char] -> t
• Perhaps you meant one of these:
	‘putStrLn’ (imported from Prelude),
	‘putStr’ (imported from Prelude)
```

Motherfucker!!! Ok, agora digitei errado mesmo, `putStrln` ao invés de `putStrLn`. Por sinal, ótima mensagem de erro aqui.

Vamos tentar denovo agora:

```
> runhaskell tougg-client.hs
> hi
```

Sucesso! temos algo rodando.

Agora vamos mudar para o *end-point* que comentei no lá começo do post. Esse *end-point* espera um token, como autenticação.

Logo preciso dar um jeito de passar esse token no header da requisição. `getWith` parece ser o que preciso aqui, e também header.

```haskell
let opts = defaults & header "Authorization: Token token" .~ ["token_here"]
```

parece que é algo assim faz o serviço. Vamos colocar isso no arquivo fonte:

```haskell
{-# LANGUAGE OverloadedStrings #-}

import Network.Wreq
import Control.Lens
import Data.Aeson.Lens (_String, key)

main = do
  let opts = defaults & header "Authorization: Token token" .~ ["token_here"]
  putStrLn "Eu venci!"
```

Quando estava no **ghci** foi usado: `set -XOverloadedStrings`para habilitar a extensão, quando em um arquivo fonte, precisamos usar como mostrado na linha `1`.

```
> runhaskell tougg-client.hs
> Eu venci!
```

YEAH!. Parece que tudo está funcionando ainda. Agora preciso fazer a requisição passando o `opts`, onde tem o `token`. Vamos usar o `getWith`, mencionado anteriormente:

```haskell
{-# LANGUAGE OverloadedStrings #-}

import Network.Wreq
import Control.Lens
import Data.Aeson.Lens (_String, key)

main = do
  let opts   = defaults & header "Authorization: Token token" .~ ["token_here"]
  r <-  getWith opts "http://localhost:3000/api/users/8348"

  let status = r ^. responseStatus
  putStrLn  status
```

Vamos rodar.

```
> runhaskell tougg-client.hs

> tougg-client.hs:12:13: error:
	• Couldn't match type ‘Data.ByteString.Lazy.Internal.ByteString’
					 with ‘[Char]’
	  Expected type: String
		Actual type: Data.ByteString.Lazy.Internal.ByteString
	• In the first argument of ‘putStrLn’, namely ‘status’
	  In a stmt of a 'do' block: putStrLn status
	  In the expression:
		do { let opts
				   = defaults & header "Authorization: Token token" .~ ...;
			 r <- getWith opts "http://localhost:3000/api/users/848";
			 let status = r ^. responseBody;
			 putStrLn status }
```

Motherfucker Hell!!!. Sinceramente sou burro o bastante para AINDA não entender o que essa mensagem quer dizer.... Intervalo de 15 minutos tentando fazer funcionar..

BUMM! Mudei de `putStrLn` para `print` e funcionou. ‘Bizarro’! Enfim, aqui estamos, consegui fazer o *request* e pegar o response. VICTORY!

Agora preciso ler do prompt o ID do usuário que queremos.

**google:** haskell how to read from command line

Parece que o que precisamos é um simples

```haskell
idUser <- getLine
```

Podemos usar `:t` para ver o tipo:

```
:t getLine
getLine :: IO String
```

Parece que faz sentido. Agora precisamos concatenar esse `idUser` na nossa URL. `++` faz isso. Vamos tentar isso:

```haskell
r <-  getWith opts http://localhost:3000/api/users/" ++ idUser
```

Rodando:

```
tougg-client.hs:12:9: error:
	• Couldn't match expected type ‘[Char]’
				  with actual type ‘IO
									  (Response Data.ByteString.Lazy.Internal.ByteString)’
	• In the first argument of ‘(++)’, namely
		‘getWith opts "http://localhost:3000/api/users/"’
	  In a stmt of a 'do' block:
		r <- getWith opts "http://localhost:3000/api/users/" ++ idUser
	  In the expression:
		do { putStrLn "Informe o ID do usu\225rio desejado";
			 idUser <- getLine;
			 putStrLn idUser;
			 let opts = defaults & header "Authorization: Token token" .~ ...;
			 .... }
```


Motherfucker!!!!. Não sei, denovo! Mas parece que isso resolve:

```haskell
r <-  getWith opts ("http://localhost:3000/api/users/" ++ idUser)
```

Rodando:

```
> runhaskell tougg-client.hs
  Informe o ID do usuário desejado
  6526
  Status {statusCode = 200, statusMessage = "OK"}
```

Ótimo!. Na verdade preciso pegar o `body`. O *package* **lens** possui várias funções bem úteis para trabalhar com JSON. No `body` recebemos um JSON contendo algumas inforamações do usuário. A *keyuser*, retorna o e-mail do usuário. Para poder pegar essa informação alterei o código para isso:

```haskell
{-# LANGUAGE OverloadedStrings #-}

import Network.Wreq
import Control.Lens
import Data.Aeson.Lens (key)
import Data.Aeson.Lens (_String, key)

main = do
  putStrLn "Informe o ID do usuário desejado"
  idUser <- getLine
  let opts   = defaults & header "Authorization: Token token" .~ ["token_here"]
  r <-  getWith opts ("http://localhost:3000/api/users/" ++ idUser)

  let email = r ^. responseBody . key "user" . _String
  print  email
```

## Conclusão

Haskell é bacana! É bom programar como se fosse a primeira vez. A linguagem é fortemente tipada e ao mesmo tempo os tipos são inferidos pelo compilador, não sendo necessário fazer isso manualmente, o que é algo bastante interessante.

Esse post foi somente uma brincadeira, não entramos em detalhe em nada, porém foi bacana para explorar algo diferente e usar o google 10 vezes por minute :)
