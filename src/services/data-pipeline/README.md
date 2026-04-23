# Data Pipeline Service

Apache SeaTunnel-based distributed data processing pipeline for Meridian.

## Overview

The Data Pipeline service provides:
- Distributed ETL/ELT processing
- Data validation and transformation
- Custom UDF (User Defined Function) support
- Fault tolerance and exactly-once semantics
- Scalable data movement across systems

## Technology Stack

- **Engine**: Apache SeaTunnel 2.x
- **JDK**: Java 8 (matches SeaTunnel runtime)
- **Build**: Maven
- **Custom Functions**: Java

## Project Structure

```
data-pipeline/
├── java/                        # Java implementation
│   ├── src/
│   │   └── main/
│   │       └── java/
│   │           └── dev/
│   │               └── luciano/
│   │                   └── seatunnel/
│   │                       └── udf/
│   │                           └── HelloUdf.java
│   └── pom.xml
└── config/
    ├── dev/                    # Development configs
    ├── staging/                # Staging configs
    └── prod/                   # Production configs
```

## Prerequisites

- JDK 8
- Maven 3.6+
- Apache SeaTunnel 2.3+ runtime

## Getting Started

### Build

```bash
cd src/services/data-pipeline/java
mvn clean package
```

### Run SeaTunnel Job

```bash
# Using SeaTunnel CLI
seatunnel-cli.sh \
  --execute-mode local \
  --config config/dev/pipeline.conf
```

## Custom UDFs

Custom User Defined Functions are located in `java/src/main/java/dev/`

### Creating a New UDF

1. Create class in `java/src/main/java/dev/{username}/seatunnel/udf/`
2. Implement SeaTunnel UDF interface
3. Register in pipeline configuration
4. Build and test

Example:
```bash
mvn clean package
# Copy resulting JAR to SeaTunnel lib directory
```

## Configuration

Pipeline configurations are environment-specific:
- `config/dev/` - Local development
- `config/staging/` - Staging environment  
- `config/prod/` - Production environment

Each config directory contains:
- `pipeline.conf` - Seatunnel job configuration
- `schemas/` - Data schemas
- `udf/` - Custom function JARs

## Testing

```bash
mvn test
```

## Kubernetes Deployment

K8s manifests are located in `infra/k8s/`

```bash
kubectl apply -k infra/k8s/overlays/seatunnel-worker/sbx
```

## Monitoring

Metrics and logs:
- SeaTunnel metrics are published to configured sink
- Logs available in `$SEATUNNEL_HOME/logs/`

## Documentation

- [SeaTunnel Documentation](https://seatunnel.apache.org/)
- [UDF Development Guide](./docs/udf-development.md)

## Contributing

- Use Maven for all builds
- Follow Java naming conventions
- Write tests for UDFs
- Document custom functions

## See Also

- [Gateway Ingestion Service](../gateway-ingestion/README.md)
- [Shared Resources](../../shared/README.md)
- [Architecture Decision Records](../../../docs/adr/)
