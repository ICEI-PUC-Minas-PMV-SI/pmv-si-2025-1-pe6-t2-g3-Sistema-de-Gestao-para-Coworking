# Introdução

Este projeto tem como objetivo o desenvolvimento de um sistema distribuído para a gestão e aluguel de espaços de coworking em Belo Horizonte. A aplicação será composta por três camadas principais: um backend responsável pela lógica de negócio e serviços de API, um frontend para acesso via aplicação web e um aplicativo mobile, garantindo acessibilidade e usabilidade multiplataforma.

O sistema permitirá que usuários realizem agendamentos de salas, gerenciem suas reservas e acessem informações sobre os espaços disponíveis. Para isso, será adotada uma arquitetura distribuída, visando escalabilidade, confiabilidade e eficiência na comunicação entre os componentes. O backend será implementado utilizando serviços de API, conforme as necessidades da aplicação. O frontend e o aplicativo mobile consumirão essas APIs para oferecer uma experiência intuitiva e responsiva aos usuários.

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

A criação de um ambiente de coworking com um sistema de gestão de reservas eficiente é uma solução estratégica para enfrentar os desafios recorrentes nesse tipo de espaço, como a sobreposição de reservas, a complexidade no processo de agendamento e a falta de visibilidade clara sobre a disponibilidade das salas. Esses problemas, quando não resolvidos, geram frustração, perda de tempo e insatisfação entre os usuários, impactando diretamente a produtividade e a experiência no espaço. Para startups, profissionais autônomos e equipes remotas, que são o público principal dos coworkings, a agilidade e a praticidade são fatores decisivos na escolha de um local para trabalhar. Portanto, um sistema de reservas ineficiente pode levar à perda de clientes e à redução da competitividade do espaço no mercado.

A sobreposição de reservas, por exemplo, é um problema comum em ambientes onde o processo de agendamento não é centralizado ou automatizado. Quando duas ou mais pessoas tentam usar a mesma sala no mesmo horário, surgem conflitos que podem gerar desconforto e desorganização. Além disso, a falta de um sistema intuitivo e de fácil acesso dificulta o processo de reserva, desmotivando os usuários e levando-os a buscar alternativas mais simples e eficientes. Isso é especialmente crítico em um cenário onde a concorrência entre espaços de coworking está em alta, e a experiência do usuário se torna um diferencial competitivo.

Além de melhorar a experiência do usuário, um sistema de gestão de reservas eficiente traz benefícios significativos para os gestores do espaço. Ele permite a otimização da ocupação das salas, reduzindo a ociosidade e aumentando a rentabilidade do negócio. Com dados em tempo real sobre o uso do espaço, os gestores podem tomar decisões mais informadas, identificar padrões de utilização e implementar melhorias contínuas. Ferramentas de análise integradas ao sistema também possibilitam o monitoramento de métricas importantes, como taxa de ocupação, preferências dos usuários e horários de pico, contribuindo para uma gestão mais estratégica e eficaz.

Em resumo, a implementação de um sistema de gestão de reservas eficiente em um ambiente de coworking não apenas resolve os problemas atuais relacionados à marcação de salas, mas também agrega valor ao negócio. Ele proporciona uma experiência superior para os usuários, com agilidade, transparência e praticidade, ao mesmo tempo em que oferece ferramentas estratégicas para os gestores, como otimização de recursos e análise de dados. Essa solução está alinhada com as tendências do mercado, que valoriza a flexibilidade, a inovação e a qualidade dos serviços, garantindo a competitividade e o crescimento do espaço de coworking.

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

| ID     | Descrição do Requisito                                                        | Prioridade |
| ------ | ----------------------------------------------------------------------------- | ---------- |
| RF-001 | Permitir que o usuário se registre e faça login no site                       | ALTA       |
| RF-002 | Permitir que o usuário consiga realizar reservas de salas no site             | ALTA       |
| RF-003 | Permitir que o usuário possa visualizar as suas reservas de salas             | ALTA       |
| RF-004 | Permitir que o usuário cancelar as suas reservas de salas                     | ALTA       |
| RF-005 | Permitir que o usuário receba notificações sobre suas reservas (email e push) | MÉDIA      |
| RF-006 | Permitir que o usuário edite suas reservas antes do horário agendado          | MÉDIA      |
| RF-007 | Permitir que administradores possam cadastrar e gerenciar salas disponíveis   | ALTA       |

### Requisitos não Funcionais

| ID      | Descrição do Requisito                                                                | Prioridade |
| ------- | ------------------------------------------------------------------------------------- | ---------- |
| RNF-001 | O sistema deve ser responsivo para rodar em um dispositivos desktop, tablets e mobile | ALTA       |
| RNF-002 | Deve processar requisições do usuário em no máximo 3s                                 |  BAIXA     |
| RNF-003 | O sistema deve garantir disponibilidade de 99,9%                                      | MÉDIA      |
| RNF-004 | O sistema deve permitir logs e auditoria para rastreamento de ações dos usuários      |  BAIXA     |

## Restrições

O projeto está restrito pelos itens apresentados na tabela a seguir.

| ID  | Restrição                                                                        | Solução                                                                                                             |
| --- | -------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| 01  | O projeto deverá ser entregue até o final do semestre                            | Utilizar metodologias ágeis (Scrum/Kanban) e priorizar MVP para garantir entregas iterativas.                       |
| 02  | Não pode ser desenvolvido um módulo de backend                                   | Utilizar serviços de terceiros como Firebase, Supabase ou AWS Amplify para gerenciar autenticação e banco de dados. |
| 03  | A aplicação deve ser multiplataforma (web e mobile)                              | Utilizar frameworks como React (Next.js) para web e React Native ou Flutter para mobile.                            |
| 04  | Deve utilizar serviços de terceiros para backend                                 | Integrar APIs externas para funcionalidades como autenticação, armazenamento e notificações.                        |
| 05  | A comunicação entre frontend e backend deve ser eficiente e confiável            | Implementar GraphQL ou otimizar chamadas REST com cache e WebSockets para atualizações em tempo real.               |
| 06  | O gerenciamento de agendamentos deve respeitar as limitações das APIs utilizadas | Definir regras de negócios diretamente no frontend e utilizar funções serverless para operações críticas.           |
| 07  | Medidas de segurança devem ser adotadas para proteção dos dados dos usuários     | Implementar autenticação segura (OAuth, Firebase Auth) e criptografia para armazenamento de dados sensíveis.        |

# Catálogo de Serviços

Este catálogo descreve os serviços que compõem a aplicação, detalhando suas funcionalidades e endpoints.

## Login Authentication Service (Autenticação e Gestão de Usuários)  
 **Função:** Gerencia autenticação, cadastro de usuários e controle de acessos.  

### Funcionalidades  
- Autenticação JWT (JSON Web Token).  
- Cadastro e gerenciamento de usuários.  
- Recuperação de senha e alteração de dados.  

### Endpoints  
| Método  | Endpoint                  | Descrição |
|---------|---------------------------|------------|
| `POST`  | `/auth/login`             | Autentica o usuário e retorna um token JWT. |
| `POST`  | `/auth/register`          | Cadastra um novo usuário. |
| `GET`   | `/auth/me`                | Retorna informações do usuário autenticado. |

---

## Reservation Service (Serviço de Reservas de Salas)  
 **Função:** Gerencia o agendamento e controle de reservas de espaços de coworking.  

### Funcionalidades  
- Criação, consulta e cancelamento de reservas.  
- Validação de disponibilidade de salas.  
- Controle de tempo de uso e regras de cancelamento.  

### Endpoints  
| Método  | Endpoint                      | Descrição |
|---------|--------------------------------|------------|
| `POST`  | `/reservations/create`        | Cria uma nova reserva para um espaço. |
| `GET`   | `/reservations/{id}`          | Consulta uma reserva específica. |
| `DELETE`| `/reservations/{id}`          | Cancela uma reserva existente. |
| `GET`   | `/reservations/available`     | Verifica disponibilidade de salas. |

---

## Workspace Management Service (Gerenciamento de Espaços)  
 **Função:** Responsável por gerenciar os espaços disponíveis no coworking, incluindo capacidade, descrição e horários.  

### Funcionalidades  
- Cadastro e edição de espaços disponíveis.  
- Definição de capacidade máxima e horários de funcionamento.  
- Gerenciamento de recursos do espaço (Wi-Fi, café, projetores, etc.).  

### Endpoints  
| Método  | Endpoint                | Descrição |
|---------|-------------------------|------------|
| `POST`  | `/workspace/create`     | Cria um novo espaço de coworking. |
| `GET`   | `/workspace/{id}`       | Consulta detalhes de um espaço específico. |
| `PUT`   | `/workspace/{id}`       | Atualiza as informações do espaço. |
| `DELETE`| `/workspace/{id}`       | Remove um espaço do sistema. |


# Arquitetura da Solução

![arq](img/software-architect.png)

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
