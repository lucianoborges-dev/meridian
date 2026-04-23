# Meridian

A distributed data ingestion and processing platform designed for high-throughput, real-time scenarios. This project simulates a high-performance environment where thousands of distributed devices send heterogeneous data that must be unified, processed, and monitored in real-time.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Services](#services)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## Overview

Meridian is a portfolio project showcasing a complete microservices architecture for managing heterogeneous data streams at scale. The system:

- **Ingests** data from thousands of distributed devices via high-performance HTTP APIs
- **Processes** and transforms data using Apache SeaTunnel's distributed ETL framework
- **Manages** asynchronous workflows through background job processing
- **Monitors** system health and performance across all services
- **Scales** horizontally using Kubernetes orchestration

### Key Characteristics

- **High Throughput**: Designed to handle thousands of concurrent data streams
- **Real-time Processing**: Sub-second latency for data ingestion and initial transformation
- **Heterogeneous Data**: Supports multiple data formats and schema versions
- **Cloud-Native**: Kubernetes-first deployment strategy
- **Multi-Language**: Services written in C#, Java, and Go
- **Production-Ready**: Comprehensive monitoring, logging, and error handling

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Distributed Devices                       │
│                                                              │
└────────────────┬─────────────────────────────────────────────┘
                 │ HTTP/gRPC
                 ▼
     ┌──────────────────────────┐
     │  Gateway Ingestion       │  (C# / .NET)
     │  - API Server            │  - Request Validation
     │  - Load Balancing        │  - Schema Validation
     │  - Rate Limiting         │  - Metrics Collection
     └────────┬─────────────────┘
              │ Kafka/NATS
              ▼
     ┌──────────────────────────┐
     │  Data Pipeline           │  (Java / SeaTunnel)
     │  - ETL Processing        │  - Data Transformation
     │  - Custom UDFs           │  - Distributed Processing
     │  - State Management      │  - Error Handling
     └────────┬─────────────────┘
              │
              ├─────────────────────────────────────┐
              ▼                                     ▼
     ┌──────────────────┐            ┌──────────────────┐
     │  Data Lake       │            │  Analytics DB    │
     │  (S3/HDFS)       │            │  (ClickHouse)    │
     └──────────────────┘            └──────────────────┘

     ┌──────────────────────────┐
     │  Worker Service          │  (Go)
     │  - Async Job Processing  │  - Scheduled Tasks
     │  - Event Handlers        │  - Background Jobs
     └──────────────────────────┘
```

## Technology Stack

### Core Services

| Service | Language | Framework | Purpose |
|---------|----------|-----------|----------|
| Gateway Ingestion | C# 14 | ASP.NET Core 10 | High-performance data ingestion API |
| Data Pipeline | Java | Apache SeaTunnel 2.3+ | Distributed ETL processing |
| Worker Service | Go | (TBD) | Asynchronous task processing |

### Infrastructure & DevOps

- **Orchestration**: Kubernetes (K8s)
- **Config Management**: Kustomize
- **Container Runtime**: Docker
- **Message Queue**: Kafka / NATS (configurable)
- **Monitoring**: Prometheus + Grafana
- **Logging**: ELK Stack / Loki
- **CI/CD**: GitHub Actions

### Data & Persistence

- **Protocol Buffers**: Service communication & schemas
- **Data Lake**: S3 / HDFS
- **Analytics**: ClickHouse / Data Warehouse
- **Cache**: Redis (optional)

## Quick Start

### Prerequisites

- Docker & Docker Compose
- Kubernetes 1.24+ (for K8s deployment)
- .NET 10.0 SDK
- JDK 11+
- Go 1.20+
- kubectl & kustomize

### Local Development

#### 1. Clone Repository

```bash
git clone https://github.com/lucianoborges-dev/meridian.git
cd meridian
```

#### 2. Start Gateway Ingestion

```bash
cd src/services/gateway-ingestion/dotnet
dotnet build
dotnet run
```

API available at: `https://localhost:7001`

#### 3. Start Data Pipeline

```bash
cd src/services/data-pipeline/java
mvn clean package
# Configure SeaTunnel environment and run
```

#### 4. Docker Compose (All Services)

```bash
docker-compose up -d
```

Services will be available at:
- Gateway API: http://localhost:8080
- SeaTunnel UI: http://localhost:8081
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

## Project Structure

```
meridian/
├── src/
│   ├── services/                    # Microservices
│   │   ├── gateway-ingestion/
│   │   ├── data-pipeline/
│   │   └── worker-service/
│   ├── shared/                      # Cross-service shared code
│   │   ├── protos/                 # Protocol Buffers
│   │   └── schemas/                # Data schemas
│   └── libs/                        # Reusable libraries per language
├── infra/
│   ├── k8s/                        # Kubernetes manifests
│   │   ├── base/
│   │   ├── overlays/               # Dev, staging, prod
│   │   └── services/
│   └── scripts/                    # Deployment scripts
├── config/
│   ├── gateway-ingestion/
│   ├── data-pipeline/
│   └── shared/
├── docs/
│   ├── adr/                        # Architecture Decision Records
│   └── wiki/                       # Documentation
├── tests/
│   ├── integration/
│   ├── e2e/
│   └── contracts/
├── README.md
├── SECURITY.md
├── LICENSE
└── docker-compose.yml
```

See [src/services/README.md](src/services/) for detailed service documentation.

## Services

### Gateway Ingestion Service

High-performance REST API for data ingestion from distributed devices.

**Location**: `src/services/gateway-ingestion/`

**Key Features**:
- OpenAPI/Swagger documentation
- Request validation & transformation
- Rate limiting & throttling
- Metrics collection (Prometheus)
- Health checks

**Learn More**: [Gateway README](src/services/gateway-ingestion/README.md)

### Data Pipeline Service

Distributed ETL processing using Apache SeaTunnel.

**Location**: `src/services/data-pipeline/`

**Key Features**:
- Custom User Defined Functions (UDFs)
- Data transformation & enrichment
- State management
- Fault tolerance & recovery
- Multiple connectors (S3, JDBC, Kafka, etc.)

**Learn More**: [Data Pipeline README](src/services/data-pipeline/README.md)

### Worker Service

Asynchronous task and event processing.

**Location**: `src/services/worker-service/`

**Key Features**:
- Background job processing
- Event-driven architecture
- Scheduled tasks
- Retry logic & dead-letter handling

**Learn More**: [Worker Service README](src/services/worker-service/README.md)

## Development

### Local Setup

1. **Clone & Install Dependencies**
   ```bash
   git clone <repo-url>
   cd meridian
   ```

2. **Per-Service Setup**
   - See individual service READMEs in `src/services/`

3. **Run Tests**
   ```bash
   # Integration tests
   dotnet test tests/integration/
   mvn test -f src/services/data-pipeline/java/
   go test ./...
   
   # End-to-end tests
   dotnet test tests/e2e/
   ```

### Code Style & Standards

- **C#**: Follow [Microsoft C# Coding Guidelines](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style)
- **Java**: Follow [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- **Go**: Follow [Effective Go](https://golang.org/doc/effective_go)
- **All**: Enable linting/formatting in CI/CD

### Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature/feature-name`
5. Submit a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Deployment

### Kubernetes Deployment

#### Development Environment

```bash
cd infra/k8s
kubectl apply -k overlays/dev
```

#### Staging Environment

```bash
kubectl apply -k overlays/staging
```

#### Production Environment

```bash
kubectl apply -k overlays/prod
```

### Docker Compose (Local)

```bash
docker-compose -f docker-compose.yml up
```

### Monitoring & Observability

- **Metrics**: Prometheus + Grafana
- **Logs**: ELK Stack
- **Traces**: Jaeger (optional)
- **Alerts**: AlertManager

## Architecture Decision Records

Key architectural decisions are documented in `docs/adr/`:

- [Service Separation Strategy](docs/adr/)
- [Technology Choices](docs/adr/)
- [Data Flow Architecture](docs/adr/)

## Security

Please see [SECURITY.md](SECURITY.md) for:
- Security policy
- Vulnerability reporting
- Security best practices
- Dependency management

## Performance Considerations

- **Gateway**: Handles 10K+ req/s per instance
- **Pipeline**: Processes 100M+ records/day
- **Storage**: Optimized for columnar analytics

## Troubleshooting

### Common Issues

**Gateway fails to start**
- Verify .NET 10.0 SDK is installed: `dotnet --version`
- Check port 7001 is available
- Review logs: `src/services/gateway-ingestion/dotnet/logs/`

**SeaTunnel job fails**
- Verify Java/JDK installation: `java -version`
- Check SeaTunnel environment variables
- Review job configuration: `config/data-pipeline/dev/`

**Kubernetes pod crashes**
- Check logs: `kubectl logs <pod-name>`
- Verify resources: `kubectl describe pod <pod-name>`
- Check events: `kubectl get events`

See [docs/wiki/](docs/wiki/) for more troubleshooting guides.

## Related Resources

- [Apache SeaTunnel Documentation](https://seatunnel.apache.org/)
- [ASP.NET Core Documentation](https://docs.microsoft.com/en-us/aspnet/core/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Protocol Buffers Guide](https://developers.google.com/protocol-buffers)

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Author

Luciano Borges - [GitHub](https://github.com/lucianoborges-dev)

## Support

For questions or issues:
- Open a GitHub issue
- Check existing documentation in `docs/`
- Review [SECURITY.md](SECURITY.md) for security concerns
