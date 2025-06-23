CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
  	email VARCHAR(255) UNIQUE NOT NULL,
  	password VARCHAR(255) NOT NULL,
  	role VARCHAR(255) NOT NULL,
  	created_at TIMESTAMP NOT NULL
);

COMMENT ON COLUMN users.full_name IS 'Nome completo do usuário.';
COMMENT ON COLUMN users.email IS 'E-mail do usuário.';
COMMENT ON COLUMN users.password IS 'Senha armazenada de forma segura.';
COMMENT ON COLUMN users.role IS 'Tipo de usuário (admin, customer, etc).';
COMMENT ON COLUMN users.role IS 'Data/hora de criação do usuário.';

CREATE TABLE IF NOT EXISTS workspace (
    workspace_id SERIAL PRIMARY KEY,
    workspace_name VARCHAR(255) NOT NULL,
    capacity INTEGER NOT NULL,
    location VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL
);

COMMENT ON COLUMN workspace.workspace_name IS 'Nome do espaço.';
COMMENT ON COLUMN workspace.capacity IS 'Quantidade máxima de pessoas no espaço.';
COMMENT ON COLUMN workspace.location IS 'Localização do espaço.';
COMMENT ON COLUMN workspace.updated_at IS 'Data/hora de atualização.';
COMMENT ON COLUMN workspace.status IS 'Status da workspace (available, reserved, etc).';
COMMENT ON COLUMN workspace.created_at IS 'Data/hora de criação.';

CREATE TABLE IF NOT EXISTS reservation (
    reservation_id SERIAL PRIMARY KEY,
    workspace_id SERIAL NOT NULL,
    user_id SERIAL NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (workspace_id) REFERENCES workspace(workspace_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

COMMENT ON COLUMN reservation.workspace_id IS '[FK] Identifica o espaço reservado.';
COMMENT ON COLUMN reservation.user_id IS '[FK] Identifica o usuário que fez a reserva.';
COMMENT ON COLUMN reservation.start_time IS 'Horário de início da reserva.';
COMMENT ON COLUMN reservation.end_time IS 'Horário de fim da reserva.';
COMMENT ON COLUMN reservation.status IS 'Status da reserva (confirmed, cancelled, etc).';
COMMENT ON COLUMN reservation.created_at IS 'Data/hora de criação.';
