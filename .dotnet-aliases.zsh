# --- .NET workflow shortcuts ---

_dn_scaffold() {
    local kind=$1
    local name=$2
    local dir=${3:-.}
    mkdir -p "$dir"

    local csproj
    csproj=$(find . -maxdepth 3 -name "*.csproj" | head -n1)
    local rootns
    rootns=$(basename "$csproj" .csproj)
    local relpath
    relpath=$(realpath --relative-to="$(dirname "$csproj")" "$dir")

    local ns="$rootns"
    if [[ "$relpath" != "." ]]; then
        ns="$rootns.$(echo "$relpath" | tr '/' '.')"
    fi

    case "$kind" in
        interface)
            cat > "$dir/I$name.cs" <<EOF
namespace $ns;

public interface I$name
{
}
EOF
            echo "Created $dir/I$name.cs in namespace $ns"
            ;;
        record)
            cat > "$dir/$name.cs" <<EOF
namespace $ns;

public record $name
{
}
EOF
            echo "Created $dir/$name.cs in namespace $ns"
            ;;
        enum)
            cat > "$dir/$name.cs" <<EOF
namespace $ns;

public enum $name
{
}
EOF
            echo "Created $dir/$name.cs in namespace $ns"
            ;;
        file)
            cat > "$dir/$name.cs" <<EOF
namespace $ns;
EOF
            echo "Created $dir/$name.cs in namespace $ns"
            ;;
        *)
            cat > "$dir/$name.cs" <<EOF
namespace $ns;

public class $name
{
}
EOF
            echo "Created $dir/$name.cs in namespace $ns"
            ;;
    esac
}

dn() {
  case "$1" in
    new)
      shift
      dotnet new "$@"
      ;;
    run)
      dotnet run
      ;;
    br)
      dotnet build && dotnet run
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
    class)
      _dn_scaffold class "$2" "$3"
      ;;
    interface)
      _dn_scaffold interface "$2" "$3"
      ;;
    record)
      _dn_scaffold record "$2" "$3"
      ;;
    enum)
      _dn_scaffold enum "$2" "$3"
      ;;
    file)
      _dn_scaffold file "$2" "$3"
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
      echo "Usage: dn {new|run|br|build|test|clean|restore|class|interface|record|enum|file|fmt|ef-add|ef-update|ef-remove|ef-drop|db-up|db-down|db-logs|db-shell}"
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
