# Gateway Ingestion Service

High-performance API gateway for data ingestion into the Meridian platform.

## Overview

The Gateway Ingestion service is responsible for:
- Accepting incoming data through HTTP/gRPC endpoints
- Validating and transforming ingestion requests
- Routing events to the Seatunnel data pipeline
- Providing monitoring and observability

## Technology Stack

- **Language**: C# (.NET 8.0)
- **Framework**: ASP.NET Core
- **API**: OpenAPI/Swagger
- **Database**: (TBD)

## Project Structure

```
gateway-ingestion/
├── dotnet/                      # C# implementation
│   ├── Gateway.Ingestion/      # Main service project
│   ├── Gateway.Ingestion.csproj
│   └── Program.cs
├── appsettings.json            # Configuration
└── Gateway.Ingestion.http      # API testing file
```

## Prerequisites

- .NET 8.0 SDK or later
- Visual Studio 2022 or VS Code with C# extension

## Getting Started

### Build

```bash
cd src/services/gateway-ingestion/dotnet
dotnet build
```

### Run

```bash
dotnet run
```

The service will be available at `https://localhost:7001` (or the configured port).

### API Documentation

OpenAPI/Swagger documentation is available at:
- Development: `https://localhost:7001/openapi/v1.json`

## Dependencies

See [Directory.Packages.props](../../Directory.Packages.props) for shared package versions.

## Configuration

Configuration is managed through:
- `appsettings.json` - Base configuration
- `appsettings.Development.json` - Development overrides
- Environment variables
- Command-line arguments

## Testing

Integration tests are located in `tests/integration/gateway-ingestion/`

```bash
dotnet test tests/integration/gateway-ingestion/
```

## Kubernetes Deployment

K8s manifests are located in `infra/k8s/services/gateway-ingestion/`

```bash
kubectl apply -k infra/k8s/overlays/dev
```

## Contributing

- Follow C# coding standards
- Enable nullable reference types
- Use async/await patterns
- Write unit tests for new features

## See Also

- [Data Pipeline Service](../data-pipeline/README.md)
- [Shared Resources](../../shared/README.md)
- [Architecture Decision Records](../../../docs/adr/)
