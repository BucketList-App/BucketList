package config

import "github.com/ilyakaznacheev/cleanenv"

type Config struct {
	Server     HTTPServer
	PostgresDB PostgresDatabase
}

type HTTPServer struct {
	Host string `env:"HTTP_HOST" env-default:"localhost"`
	Port string `env:"HTTP_PORT" env-default:"8080"`
}

type PostgresDatabase struct {
	Host     string `env:"POSTGRES_HOST" env-default:"localhost"`
	Port     string `env:"POSTGRES_PORT" env-default:"5432"`
	Name     string `env:"POSTGRES_DB" env-default:"postgres"`
	User     string `env:"POSTGRES_USER" env-default:"postgres"`
	Password string `env:"POSTGRES_PASSWORD" env-default:"postgres"`
}

func MustLoadConfig(filepath string) error {

	var cfg Config

	err := cleanenv.ReadConfig(filepath, &cfg)
	if err != nil {
		panic(err)
	}

	return nil
}
