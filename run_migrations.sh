#!/bin/bash

# Database configuration
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-backloggd}
DB_USER=${DB_USER:-enzom_uy}

MIGRATIONS_DIR="migrations"

echo "🚀 Running migrations for $DB_NAME..."
echo "📅 Started at: $(date '+%Y-%m-%d %H:%M:%S')"

# Check if migrations directory exists
if [ ! -d "$MIGRATIONS_DIR" ]; then
    echo "❌ Migrations directory not found: $MIGRATIONS_DIR"
    exit 1
fi

# Check if there are any .sql files
if ! ls $MIGRATIONS_DIR/*.sql 1> /dev/null 2>&1; then
    echo "⚠️  No .sql files found in $MIGRATIONS_DIR"
    exit 1
fi

# Run each migration in order
for migration in $MIGRATIONS_DIR/*.sql; do
    if [ -f "$migration" ]; then
        echo "📄 Executing: $(basename $migration)"
        
        # Execute migration and capture both stdout and stderr
        if psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "$migration" -v ON_ERROR_STOP=1 > /tmp/migration_output.log 2>&1; then
            echo "✅ $(basename $migration) executed successfully"
        else
            echo "❌ Error executing $(basename $migration)"
            echo "📋 Error details:"
            cat /tmp/migration_output.log
            rm -f /tmp/migration_output.log
            exit 1
        fi
    fi
done

echo "🎉 All migrations completed successfully!"
echo "📅 Finished at: $(date '+%Y-%m-%d %H:%M:%S')"

# Clean up
rm -f /tmp/migration_output.log
