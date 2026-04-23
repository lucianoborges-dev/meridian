# Shared Resources

Cross-service shared code, schemas, and protocol definitions for Meridian.

## Overview

This directory contains:
- Shared Protocol Buffer definitions
- Common data schemas
- Cross-service contracts
- Shared constants and utilities

## Structure

```
shared/
├── protos/                      # Protocol Buffer definitions
│   ├── telemetry/              # Telemetry-related messages
│   │   └── TelemetryPacket.proto
│   └── common/                 # Common shared messages
│       ├── timestamp.proto
│       └── metadata.proto
└── schemas/                    # JSON schemas, Avro, etc.
    ├── telemetry/
    └── events/
```

## Protocol Buffers

Protocol Buffer files define the contract between services.

### Compilation

Generate code for all languages:

```bash
# Requires protoc compiler
protoc --go_out=../libs/golang --csharp_out=../libs/dotnet --java_out=../libs/java shared/protos/**/*.proto
```

### Usage

- **Go**: Import from `../libs/golang/generated/`
- **.NET**: Reference NuGet package (built from protos)
- **Java**: Include in Maven classpath

## Schemas

JSON Schema and Avro schema definitions for data validation.

### Telemetry Schema

Defines the structure of telemetry events flowing through the system.

See: `schemas/telemetry/event-schema.json`

### Event Schema

Defines event structures for inter-service communication.

See: `schemas/events/event-schema.json`

## Versioning

- Proto definitions use package versioning (e.g., `v1`, `v2`)
- Schemas follow semantic versioning
- Breaking changes require major version bump
- Old versions must be supported for backward compatibility

## Contributing

When adding shared resources:

1. **Protocol Buffers**:
   - Follow naming conventions (PascalCase for messages)
   - Include comprehensive comments
   - Use semantic versioning in package names

2. **Schemas**:
   - Document all fields
   - Provide examples
   - Include validation rules

3. **Testing**:
   - Add tests for new schemas
   - Validate cross-service compatibility
   - Document breaking changes

## Cross-Service Contracts

Services consuming shared resources:

| Resource | Consumers | Owner |
|----------|-----------|-------|
| TelemetryPacket.proto | Gateway, Pipeline | Gateway Ingestion |
| Timestamp.proto | All | Shared |
| Metadata.proto | All | Shared |

## See Also

- [Service Architecture](../services/README.md)
- [Protobuf Documentation](https://developers.google.com/protocol-buffers)
- [JSON Schema](https://json-schema.org/)
