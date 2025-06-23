# Instruções de utilização

## Instalação do Backend

**Pré-requisitos:** 

- [Java SDK](https://nodejs.org/en/)
- [Docker](https://www.docker.com/products/docker-desktop/)
- [Dbeaver](https://dbeaver.io/download/)

1.  Clone este repositório para sua máquina local:
```
git clone https://github.com/lucborges/conectabh-service.git
```

2.  Pelo terminal, inicie o docker para subir o banco de dados:

```
docker compose up
```

3.  Em seguida rode a aplicação através do arquivo:

```
conectabh-service\src\main\java\com\pucminas\conectabh_service\ConectabhServiceApplication.java
```

4.  Em seguida acesse a URL pelo browser para o Swagger:
```
localhost:8080/swagger-ui/index.html
```

## Instalação do Site

**Pré-requisitos:** 

- [Node.js](https://nodejs.org/en/)
- [Docker](https://www.docker.com/products/docker-desktop/)

1.  Clone este repositório para sua máquina local:
```
git clone https://github.com/lucborges/belospace-web.git
```

2.  Pelo terminal, instale o ambiente npm:

```
npm install
```

3.  Em seguida rode a aplicação:

```
npm run dev
```

4.  Em seguida acesse a URL pelo browser para o front:
```
http://localhost:3000
```

## Instalação do App

**Pré-requisitos:** 

- [Dart SDK](https://dart.dev/get-dart) (>= 3.7.*)
- [Flutter](https://docs.flutter.dev/get-started/install/windows)

1.  Clone este repositório para sua máquina local:
```
git clone https://github.com/GabrielVilhenaMagri/belospace-mobile.git
```

2.  Inicie algum emulador ou utilize um telefone para rodar o app.

3.  Através do terminal, rode a aplicação com o comando:

```
flutter run
```

4.  Em seguida o app se abrirá no emulador ativo.

