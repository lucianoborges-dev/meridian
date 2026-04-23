# Worker Service

Background job processing and event-driven worker service for Meridian.

## Overview

The Worker Service handles:
- Asynchronous job processing
- Event-driven workflows
- Long-running background tasks
- Service-to-service async communication
- Scheduled jobs and cron tasks

## Technology Stack

- **Language**: Go 1.20+
- **Framework**: (TBD - Consider: Go-kit, Echo, Fiber)
- **Message Queue**: (TBD - Consider: RabbitMQ, NATS, Kafka)
- **Database**: (TBD)

## Project Structure

```
worker-service/
├── golang/                      # Go implementation
│   ├── cmd/
│   │   └── worker/             # Service entry point
│   ├── internal/
│   │   ├── handlers/
│   │   ├── services/
│   │   └── models/
│   ├── go.mod
│   └── go.sum
└── config/
    ├── dev/
    ├── staging/
    └── prod/
```

## Prerequisites

- Go 1.20 or later
- (Message queue setup - TBD)

## Getting Started

### Build

```bash
cd src/services/worker-service/golang
go build -o worker ./cmd/worker
```

### Run

```bash
./worker
```

## Configuration

Environment-specific configurations:
- `config/dev/` - Local development
- `config/staging/` - Staging environment
- `config/prod/` - Production environment

Configuration can be managed via:
- YAML/TOML config files
- Environment variables
- Command-line flags

## Testing

```bash
go test ./...
```

## Kubernetes Deployment

K8s manifests are located in `infra/k8s/services/worker-service/`

```bash
kubectl apply -k infra/k8s/overlays/dev
```

## Contributing

- Follow Go code style guidelines (`gofmt`, `golint`)
- Write unit tests for new features
- Use interfaces for dependency injection
- Document exported functions

## See Also

- [Gateway Ingestion Service](../gateway-ingestion/README.md)
- [Data Pipeline Service](../data-pipeline/README.md)
- [Shared Resources](../../shared/README.md)
- [Architecture Decision Records](../../../docs/adr/)
