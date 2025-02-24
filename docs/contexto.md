# Introdução

Texto descritivo com a visão geral do projeto abordado. Inclui o contexto, o problema, os objetivos, a justificativa e o público-alvo do projeto.

## Problema
O problema da marcação de salas em um ambiente de coworking é um dos principais desafios enfrentados por gestores e usuários desses espaços. Em um contexto onde startups e profissionais autônomos buscam flexibilidade e praticidade, a gestão eficiente das reservas de salas é crucial para garantir uma experiência positiva e evitar conflitos que possam prejudicar a produtividade e a satisfação dos usuários.

Um dos principais problemas é a sobreposição de reservas. Em um espaço de coworking, onde várias pessoas ou equipes compartilham os mesmos recursos, é comum que ocorram conflitos de agendamento, especialmente se o processo de reserva não for centralizado ou automatizado. Isso pode levar a situações em que duas ou mais pessoas tentam usar a mesma sala no mesmo horário, causando frustração e perda de tempo. A complexidade no processo de reserva também é um ponto crítico. Se o sistema for complicado ou exigir muitas etapas para realizar uma reserva, os usuários podem desistir de usar o espaço ou buscar alternativas mais simples. Isso é particularmente relevante para profissionais autônomos e startups, que muitas vezes precisam de agilidade e praticidade para focar em suas atividades principais.

Em resumo, o problema da marcação de salas em um coworking envolve uma série de desafios, desde a sobreposição de reservas e a dificuldade em visualizar a disponibilidade até a complexidade no processo de reserva e a falta de flexibilidade. Um sistema de gestão eficiente deve resolver esses problemas, oferecendo uma experiência ágil, intuitiva e integrada para os usuários, ao mesmo tempo em que fornece ferramentas de controle e análise para os gestores do espaço.

## Objetivos

Objetivo Geral

Desenvolver um sistema de agendamento de salas presenciais para reuniões, garantindo uma solução eficiente, segura e de fácil usabilidade. O sistema permitirá que os usuários façam reservas em salas predefinidas, otimizando o uso dos espaços disponíveis na organização.

Objetivos Específicos

Implementar um sistema seguro de autenticação e controle de acesso:
- Desenvolver um mecanismo de login para os usuários.
- Avaliar e aplicar práticas de segurança, como armazenamento seguro de senhas e proteção contra acessos indevidos.

Criar uma interface intuitiva para gerenciamento de reservas:
- Desenvolver um design responsivo e acessível para facilitar a experiência do usuário.
- Implementar funcionalidades que permitam visualizar, cadastrar e cancelar reservas de forma eficiente.

## Justificativa

Descreva a importância ou a motivação para trabalhar com esta aplicação que você escolheu. Indique as razões pelas quais você escolheu seus objetivos específicos ou as razões para aprofundar em certos aspectos do software.

O grupo de trabalho pode fazer uso de questionários, entrevistas e dados estatísticos, que podem ser apresentados, com o objetivo de esclarecer detalhes do problema que será abordado pelo grupo.

> **Links Úteis**:
> - [Como montar a justificativa](https://guiadamonografia.com.br/como-montar-justificativa-do-tcc/)

## Público-Alvo

Este Sistema de Gestão para Coworking é voltado para a gestão de agendamentos de salas presenciais em Belo Horizonte. O projeto tem como foco startups e profissionais autônomos que buscam um ambiente flexível para trabalho colaborativo. A seguir, detalhamos os principais perfis de usuários:

- **Empreendedores e Fundadores de Startups:** Homens e mulheres, de 25 a 40 anos, formação superior em Administração, Marketing, TI ou Design, solteiros(as) ou casados(as), que frequentam regiões centrais de Belo Horizonte como Savassi e Funcionários e procuram um escritório inicial para suas reuniões.

- **Desenvolvedores e Designers de Startups:** Pessoas de 20 a 35 anos, cursando ou formados em TI, Ciência da Computação ou Design Gráfico, solteiros(as) ou em relacionamento, que buscam ambientes colaborativos e cafés em regiões inovadoras de Belo Horizonte.

- **Profissionais de Marketing e Vendas de Startups:** Homens e mulheres, de 22 a 40 anos, com formação em Marketing, Publicidade ou Administração, solteiros(as) ou casados(as), frequentam regiões com networking ativo como Savassi e Lourdes.

- **Consultores e Profissionais Autônomos:** Homens e mulheres, de 25 a 45 anos, com formação em Administração, TI, Marketing ou Design, solteiros(as) ou casados(as) com horários flexíveis, que utilizam coworking para reuniões com clientes em centros empresariais de Belo Horizonte.

- **Freelancers e Profissionais Remotos:** Homens e mulheres, de 22 a 40 anos, com formação em TI, Design, Marketing ou Jornalismo, solteiros(as) ou casados(as) com horários flexíveis, que buscam ambientes produtivos e inspiradores em bairros com boa infraestrutura em Belo Horizonte.
# Especificações do Projeto

## Requisitos

As tabelas que se seguem apresentam os requisitos funcionais e não funcionais que detalham o escopo do projeto. Para determinar a prioridade de requisitos, aplicar uma técnica de priorização de requisitos e detalhar como a técnica foi aplicada.

### Requisitos Funcionais

|ID    | Descrição do Requisito  | Prioridade |
|------|-----------------------------------------|----|
|RF-001| Permitir que o usuário cadastre tarefas | ALTA | 
|RF-002| Emitir um relatório de tarefas no mês   | MÉDIA |

### Requisitos não Funcionais

|ID     | Descrição do Requisito  |Prioridade |
|-------|-------------------------|----|
|RNF-001| O sistema deve ser responsivo para rodar em um dispositivos móvel | MÉDIA | 
|RNF-002| Deve processar requisições do usuário em no máximo 3s |  BAIXA | 

Com base nas Histórias de Usuário, enumere os requisitos da sua solução. Classifique esses requisitos em dois grupos:

- [Requisitos Funcionais
 (RF)](https://pt.wikipedia.org/wiki/Requisito_funcional):
 correspondem a uma funcionalidade que deve estar presente na
  plataforma (ex: cadastro de usuário).
- [Requisitos Não Funcionais
  (RNF)](https://pt.wikipedia.org/wiki/Requisito_n%C3%A3o_funcional):
  correspondem a uma característica técnica, seja de usabilidade,
  desempenho, confiabilidade, segurança ou outro (ex: suporte a
  dispositivos iOS e Android).
Lembre-se que cada requisito deve corresponder à uma e somente uma
característica alvo da sua solução. Além disso, certifique-se de que
todos os aspectos capturados nas Histórias de Usuário foram cobertos.

> **Links Úteis**:
> - [O que são Requisitos Funcionais e Requisitos Não Funcionais?](https://codificar.com.br/requisitos-funcionais-nao-funcionais/)
> - [O que são requisitos funcionais e requisitos não funcionais?](https://analisederequisitos.com.br/requisitos-funcionais-e-requisitos-nao-funcionais-o-que-sao/)

## Restrições

O projeto está restrito pelos itens apresentados na tabela a seguir.

| ID  | Restrição | Solução |
|----|-------------------------------------------------------|--------------------------------------------------------------|
| 01 | O projeto deverá ser entregue até o final do semestre | Utilizar metodologias ágeis (Scrum/Kanban) e priorizar MVP para garantir entregas iterativas. |
| 02 | Não pode ser desenvolvido um módulo de backend | Utilizar serviços de terceiros como Firebase, Supabase ou AWS Amplify para gerenciar autenticação e banco de dados. |
| 03 | A aplicação deve ser multiplataforma (web e mobile) | Utilizar frameworks como React (Next.js) para web e React Native ou Flutter para mobile. |
| 04 | Deve utilizar serviços de terceiros para backend | Integrar APIs externas para funcionalidades como autenticação, armazenamento e notificações. |
| 05 | A comunicação entre frontend e backend deve ser eficiente e confiável | Implementar GraphQL ou otimizar chamadas REST com cache e WebSockets para atualizações em tempo real. |
| 06 | O gerenciamento de agendamentos deve respeitar as limitações das APIs utilizadas | Definir regras de negócios diretamente no frontend e utilizar funções serverless para operações críticas. |
| 07 | Medidas de segurança devem ser adotadas para proteção dos dados dos usuários | Implementar autenticação segura (OAuth, Firebase Auth) e criptografia para armazenamento de dados sensíveis. |

# Catálogo de Serviços

Descreva aqui todos os serviços que serão disponibilizados pelo seu projeto, detalhando suas características e funcionalidades.

# Arquitetura da Solução

Definição de como o software é estruturado em termos dos componentes que fazem parte da solução e do ambiente de hospedagem da aplicação.

![arq](https://github.com/user-attachments/assets/b9402e05-8445-47c3-9d47-f11696e38a3d)


## Tecnologias Utilizadas

Descreva aqui qual(is) tecnologias você vai usar para resolver o seu problema, ou seja, implementar a sua solução. Liste todas as tecnologias envolvidas, linguagens a serem utilizadas, serviços web, frameworks, bibliotecas, IDEs de desenvolvimento, e ferramentas.

Apresente também uma figura explicando como as tecnologias estão relacionadas ou como uma interação do usuário com o sistema vai ser conduzida, por onde ela passa até retornar uma resposta ao usuário.

## Hospedagem

Explique como a hospedagem e o lançamento da plataforma foi feita.

> **Links Úteis**:
>
> - [Website com GitHub Pages](https://pages.github.com/)
> - [Programação colaborativa com Repl.it](https://repl.it/)
> - [Getting Started with Heroku](https://devcenter.heroku.com/start)
> - [Publicando Seu Site No Heroku](http://pythonclub.com.br/publicando-seu-hello-world-no-heroku.html)
