# --- .NET workflow shortcuts ---

dn() {
  case "$1" in
    new)
      shift
      dotnet new "$@"
      ;;
    run)
      dotnet watch run
      ;;
    build)
      dotnet build
      ;;
    test)
      dotnet test
      ;;
    clean)
      dotnet clean
      ;;
    restore)
      dotnet restore
      ;;
    fmt)
      dotnet format
      ;;
    ef-add)
      dotnet ef migrations add "$2"
      ;;
    ef-update)
      dotnet ef database update
      ;;
    ef-remove)
      dotnet ef migrations remove
      ;;
    ef-drop)
      dotnet ef database drop -f
      ;;
    db-up)
      docker compose -f "$HOME/.dotnet-db/docker-compose.mssql.yml" up -d
      ;;
    db-down)
      docker compose -f "$HOME/.dotnet-db/docker-compose.mssql.yml" down
      ;;
    db-logs)
      docker logs -f dotnet-mssql
      ;;
    db-shell)
      docker exec -it dotnet-mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "DevPass123!" -C
      ;;
    *)
      echo "Usage: dn {new|run|build|test|clean|restore|fmt|ef-add|ef-update|ef-remove|ef-drop|db-up|db-down|db-logs|db-shell}"
      ;;
  esac
}

# quick project scaffold + cd + git init
dnnew() {
  local template=$1
  local name=$2
  dotnet new "$template" -o "$name"
  cd "$name" || return
  git init -q
  dotnet new gitignore
  echo "Created $name ($template), git initialized"
}
