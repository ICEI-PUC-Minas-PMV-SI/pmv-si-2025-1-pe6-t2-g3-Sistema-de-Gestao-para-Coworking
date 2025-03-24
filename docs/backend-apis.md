# APIs e Web Services

O planejamento de uma aplicação de APIS Web é uma etapa fundamental para o sucesso do projeto. Ao planejar adequadamente, você pode evitar muitos problemas e garantir que a sua API seja segura, escalável e eficiente.

Aqui estão algumas etapas importantes que devem ser consideradas no planejamento de uma aplicação de APIS Web.

[Inclua uma breve descrição do projeto.]

## Objetivos da API

O primeiro passo é definir os objetivos da sua API. O que você espera alcançar com ela? Você quer que ela seja usada por clientes externos ou apenas por aplicações internas? Quais são os recursos que a API deve fornecer?

[Inclua os objetivos da sua api.]


## Modelagem da Aplicação
[Descreva a modelagem da aplicação, incluindo a estrutura de dados, diagramas de classes ou entidades, e outras representações visuais relevantes.]


## Tecnologias Utilizadas

Existem muitas tecnologias diferentes que podem ser usadas para desenvolver APIs Web. A tecnologia certa para o seu projeto dependerá dos seus objetivos, dos seus clientes e dos recursos que a API deve fornecer.

[Lista das tecnologias principais que serão utilizadas no projeto.]

## API Endpoints

Abaixo está uma lista dos principais endpoints da API do sistema de agendamento de salas, com as operações disponíveis, parâmetros esperados e respostas retornadas. A documentação está estruturada para ser clara e concisa, seguindo o exemplo do serviço de autenticação e reserva.

## Login Authentication
### Endpoint:  ```POST /auth/login```
- Método: POST
- URL: /auth/login
- Parâmetros da Request:
- ```user_name```: Nome do usuário (string, obrigatório)
- ```email```: Email do usuário (string, obrigatório)
- ```password_hash```: Senha do usuário (hash, obrigatório)
  
  - Resposta:
    
- Sucesso (200 OK)
```
{
  "message": "Login Successful",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresIn": 3600
  }
}
```
- Erro (401 Unathorized)
```
{
  "message": "Error",
  "error": {
    "message": "Invalid credentials",
    "details": "The email or password provided is incorrect."
  }
}
```
### Endpoint:  ```POST /auth/register```
- Método: POST
- URL: /auth/register
- Parâmetros da Request:
  - ```user_name```: Nome completo do usuário (string, opcional)
  - ```email```: Endereço de e-mail do usuário (string, obrigatório)
  - ```password_hash```: Senha do usuário (hash, obrigatório)
  - ```role```: Tipo de usuário (string, opcional, valores: "admin", "customer", etc.)
 
  - Resposta:

- Sucesso (201 Created)
```
{
  "message": "User registered successfully",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "user_name": "John Doe",
    "email": "johndoe@example.com",
    "role": "customer",
    "created_at": "2025-03-23T10:15:30Z"
  }
}
```
- Erro (400 Bad Request)
```
{
  "message": "Error",
  "error": {
    "message": "Email already exists",
    "details": "The provided email is already in use."
  }
}
```

### Endpoint:  ```GET /auth/me```
- Método: GET
- URL: /auth/me
- Headers:
- ```Authorization```: Bearer token (string, obrigatório)

- Observação:  Nenhum outro parâmetro é necessário na request, pois o usuário será idenficado pelo token JWT.

  - Resposta:
    
- Sucesso (200 OK)

```
{
  "message": "User Profile Retrieved",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "user_name": "John Doe",
    "email": "johndoe@example.com",
    "role": "customer",
    "created_at": "2025-03-23T12:00:00Z"
  }
}
```
- Erro (401 Unauthorized)    
```
{
  "message": "Error",
  "error": {
    "message": "Invalid token",
    "details": "Token is missing or invalid."
  }
}
```

## Reservation Service
### Endpoint:  ```POST /reservations/create```
- Método: POST
- URL: /reservations/create
- Parâmetros da Request:
- ```workspace_id```: UUID do espaço reservado (string, obrigatório)
- ```user_id```: UUID do usuário (string, obrigatório)
- ```start_time```: Horário de início da reserva (timestamp, obrigatório)
- ```end_time```: Horário de término da reserva (timestamp, obrigatório)
- ```status```: Status da reserva (string, opcional, valores: "confirmed", "canceled")
  
  - Resposta:

- Sucesso (201 Created)
```
{
  "message": "Reservation created successfully",
  "data": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "workspace_id": "550e8400-e29b-41d4-a716-446655440000",
    "user_id": "660e8400-e29b-41d4-a716-446655440000",
    "start_time": "2025-03-24T10:00:00Z",
    "end_time": "2025-03-24T12:00:00Z",
    "status": "confirmed",
    "created_at": "2025-03-23T12:00:00Z"
  }
}
```
- Erro (400 Bad Request)    
```
{
  "message": "Error",
  "error": {
    "code": 400,
    "message": "Time slot unavailable",
    "details": "The selected time slot is already booked."
  }
}
```
- Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Workspace not found",
    "details": "The specified workspace does not exist."
  }
}
```
- Erro (403 Forbidden)   
```
{
  "message": "Error",
  "error": {
    "code": 403,
    "message": "Unauthorized user",
    "details": "User does not have permission to create a reservation."
  }
}
```

### Endpoint:  ```GET /reservations/{id}```

- Método: GET
- URL: /reservations/{id}
- Parâmetros da Request: Nenhum. Será passado diretamente na rota.
  
  - Resposta:

- Sucesso (200 ok)
```
{
  "message": "Reservation retrieved successfully",
  "data": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "workspace_id": "550e8400-e29b-41d4-a716-446655440000",
    "user_id": "660e8400-e29b-41d4-a716-446655440000",
    "start_time": "2025-03-24T10:00:00Z",
    "end_time": "2025-03-24T12:00:00Z",
    "status": "confirmed",
    "created_at": "2025-03-23T12:00:00Z"
  }
}
```
- Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Reservation not found",
    "details": "The specified reservation does not exist."
  }
}
```

### Endpoint:  ```DELETE /reservations/{id}```

- Método: DELETE
- URL: /reservations/{id}
- Parâmetros da Request: Nenhum. Será passado diretamente na rota.
  
  - Resposta:

- Sucesso (200 ok)
```
{
  "message": "Reservation deleted successfully"
}
```
- Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Reservation not found",
    "details": "The specified reservation does not exist."
  }
}
```
## Workspace Management
### Endpoint:  ```POST /workspace/create```

- Método: POST
- URL: /workspace/create
- Headers: Authorization: Bearer {jwt_token}
- Parâmetros da Request:
- ```workspace_name```: Nome do espaço (string, obrigatório)
- ```capacity```: Capacidade máxima (int, obrigatório)
- ```location```: Localização do espaço (string, obrigatório)
  
  - Resposta:

- Sucesso (201 Created)
```
{
  "message": "Workspace created successfully",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "workspace_name": "Sala de Reunião 1",
    "capacity": 10,
    "location": "Andar 3, Sala 305",
    "created_at": "2025-03-23T12:00:00Z"
  }
}
```
- Erro (400 Bad Request)
```
{
  "message": "Error",
  "error": {
    "code": 400,
    "message": "Invalid data",
    "details": "Workspace name, location and capacity are required."
  }
}
```
- Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Reservation not found",
    "details": "The specified reservation does not exist."
  }
}
```
### Endpoint:  ```GET /workspace/{id}```

- Método: GET
- URL: /workspace/{id}
- Headers: Authorization: Bearer {jwt_token}
- Parâmetros da Request: Nenhum. Será passado diretamente na rota.
  
  - Resposta:
   
- Sucesso (200 Created)
```
{
  "message": "Workspace retrieved successfully",
  "data": {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "workspace_name": "Sala de Reunião 1",
    "capacity": 10,
    "location": "Andar 3, Sala 305",
    "created_at": "2025-03-23T12:00:00Z"
  }
}
```
 - Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Workspace not found",
    "details": "The specified workspace does not exist."
  }
}
```

### Endpoint:  ```PUT /workspace/{id}```

- Método: PUT
- URL: /workspace/{id}
- Headers: Authorization: Bearer {jwt_token}
- Parâmetros da Request:
- ```workspace_name```: Nome do espaço (string, opcional)
- ```capacity```: Capacidade máxima (int, opcional)
- ```location```: Localização do espaço (string, opcional)
  
  - Resposta:

- Sucesso (200 Created)
```
{
  "message": "Workspace updated successfully"
}
```
- Erro (400 Bad Request)
```
{
  "message": "Error",
  "error": {
    "code": 400,
    "message": "Invalid data",
    "details": "At least one field (workspace_name, capacity, or location) must be provided."
  }
}
```
- Erro (404 Not Found)
```
json

{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Workspace not found",
    "details": "The specified workspace does not exist."
  }
}
```

### Endpoint:  ```DELETE /workspace/{id}```

- Método: DELETE
- URL: /workspace/{id}
- Headers: Authorization: Bearer {jwt_token}
- Parâmetros da Request: Nenhum. Será passado diretamente na rota.
  
  - Resposta:

- Sucesso (200 Created)
```
{
  "message": "Workspace deleted successfully"
}
```
- Erro (404 Not Found)
```
{
  "message": "Error",
  "error": {
    "code": 404,
    "message": "Workspace not found",
    "details": "The specified workspace does not exist."
  }
}
```

[Liste os principais endpoints da API, incluindo as operações disponíveis, os parâmetros esperados e as respostas retornadas.]

### Endpoint 1
- Método: GET
- URL: /endpoint1
- Parâmetros:
  - param1: [descrição]
- Resposta:

- Sucesso (200 OK) ```
    {
      "message": "Success",
      "data": {
        ...
      }
    }
    ```
  - Erro (4XX, 5XX)
    ```
    {
      "message": "Error",
      "error": {
        ...
      }
    }
    ```

## Considerações de Segurança

[Discuta as considerações de segurança relevantes para a aplicação distribuída, como autenticação, autorização, proteção contra ataques, etc.]

## Implantação

[Instruções para implantar a aplicação distribuída em um ambiente de produção.]

1. Defina os requisitos de hardware e software necessários para implantar a aplicação em um ambiente de produção.
2. Escolha uma plataforma de hospedagem adequada, como um provedor de nuvem ou um servidor dedicado.
3. Configure o ambiente de implantação, incluindo a instalação de dependências e configuração de variáveis de ambiente.
4. Faça o deploy da aplicação no ambiente escolhido, seguindo as instruções específicas da plataforma de hospedagem.
5. Realize testes para garantir que a aplicação esteja funcionando corretamente no ambiente de produção.

## Testes

[Descreva a estratégia de teste, incluindo os tipos de teste a serem realizados (unitários, integração, carga, etc.) e as ferramentas a serem utilizadas.]

1. Crie casos de teste para cobrir todos os requisitos funcionais e não funcionais da aplicação.
2. Implemente testes unitários para testar unidades individuais de código, como funções e classes.
3. Realize testes de integração para verificar a interação correta entre os componentes da aplicação.
4. Execute testes de carga para avaliar o desempenho da aplicação sob carga significativa.
5. Utilize ferramentas de teste adequadas, como frameworks de teste e ferramentas de automação de teste, para agilizar o processo de teste.

# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
