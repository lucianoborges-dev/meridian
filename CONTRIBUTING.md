# Contributing to Meridian

Thank you for your interest in contributing to Meridian! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Submitting Changes](#submitting-changes)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Reporting Bugs](#reporting-bugs)
- [Feature Requests](#feature-requests)
- [Questions](#questions)

## Code of Conduct

This project adheres to the Contributor Covenant Code of Conduct. By participating, you are expected to uphold this code.

**TL;DR**: Be respectful, inclusive, and professional in all interactions.

## Getting Started

### Prerequisites

- Git
- Docker & Docker Compose
- .NET 8.0 SDK (for C# services)
- JDK 11+ (for Java services)
- Go 1.20+ (for Go services)
- Kubernetes knowledge (optional, for K8s contributions)

### Fork & Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/meridian.git
   cd meridian
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/lucianoborges-dev/meridian.git
   ```

## Development Setup

### Initial Setup

```bash
# Update submodules (if any)
git submodule update --init --recursive

# Set up pre-commit hooks (recommended)
# Scripts TBD
```

### Per-Service Setup

Each service has its own setup. See service-specific README files:

- [Gateway Ingestion](src/services/gateway-ingestion/README.md)
- [Data Pipeline](src/services/data-pipeline/README.md)
- [Worker Service](src/services/worker-service/README.md)

### Running Tests Locally

```bash
# Run all tests
./scripts/test-all.sh

# Run specific service tests
cd src/services/gateway-ingestion/dotnet
dotnet test

cd src/services/data-pipeline/java
mvn test

cd src/services/worker-service/golang
go test ./...
```

### Running the Application

**Using Docker Compose** (recommended for local development):

```bash
docker-compose up
```

**Individual Services**:

See individual service READMEs for detailed instructions.

## Making Changes

### Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

Branch naming conventions:
- `feature/` - New features
- `bugfix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring (no functional changes)
- `test/` - Test additions/improvements
- `chore/` - Maintenance tasks

### Work on Your Feature

1. Make focused, logical commits
2. Write descriptive commit messages
3. Add tests for new functionality
4. Update documentation as needed
5. Ensure code follows project standards

### Keep Your Branch Updated

```bash
git fetch upstream
git rebase upstream/main
```

## Submitting Changes

### Commit Messages

Follow the Conventional Commits specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat:` - A new feature
- `fix:` - A bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, semicolons, etc.)
- `refactor:` - Code refactoring without functional changes
- `test:` - Adding or updating tests
- `chore:` - Build process, dependencies, etc.

**Example**:

```
feat(gateway): implement rate limiting middleware

Add configurable rate limiting to the Gateway Ingestion service.
Supports per-IP and per-API-key limits.

Closes #123
```

### Push Your Changes

```bash
git push origin feature/your-feature-name
```

### Create a Pull Request

1. Go to the original repository on GitHub
2. Click "New Pull Request"
3. Select your branch
4. Fill in the PR template with:
   - Clear description of changes
   - Related issue numbers (e.g., `Closes #123`)
   - Testing notes
   - Screenshots (if UI changes)
   - Breaking changes (if any)

## Coding Standards

### C# (.NET)

- Follow [Microsoft C# Coding Guidelines](https://docs.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style)
- Use `async/await` for I/O operations
- Enable nullable reference types
- Use implicit typing (`var`) where type is obvious
- Format with `dotnet format`

### Java

- Follow [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- Use meaningful variable names
- Keep methods focused and small
- Use appropriate access modifiers
- Format with `google-java-format`

### Go

- Follow [Effective Go](https://golang.org/doc/effective_go)
- Use `gofmt` for formatting
- Use `golint` for linting
- Keep interfaces small and focused
- Use error handling appropriately

### General

- Write readable, maintainable code
- Add comments for complex logic
- Avoid code duplication (DRY)
- Keep functions/methods small and focused
- Use meaningful names
- No trailing whitespace
- 4 spaces for indentation (or language standard)

## Testing Guidelines

### Unit Tests

- Test should be small and focused
- Follow AAA pattern: Arrange, Act, Assert
- Use descriptive test names
- Aim for >80% code coverage for critical paths

Example:

```csharp
[Fact]
public void ValidateRequest_WithInvalidSchema_ThrowsValidationException()
{
    // Arrange
    var request = new DataIngestionRequest { /* invalid data */ };
    var validator = new RequestValidator();

    // Act & Assert
    Assert.Throws<ValidationException>(() => validator.Validate(request));
}
```

### Integration Tests

- Test service interactions
- Use test containers or mocks
- Clean up resources after tests
- Test realistic scenarios

### E2E Tests

- Test complete workflows
- Use staging environment or Docker Compose
- Cover happy path and error scenarios
- Keep tests maintainable

### Running Tests

```bash
# Before submitting PR, ensure all tests pass:
./scripts/test-all.sh

# Or run specific test suites:
dotnet test tests/
mvn test -f src/services/data-pipeline/java/
go test ./...
```

## Documentation

### Code Documentation

- Add XML documentation comments (C#)
- Add JavaDoc comments (Java)
- Add GoDoc comments (Go)
- Explain the "why" not just the "what"

### README Updates

Update relevant README files if you:
- Add new features
- Change configuration options
- Modify deployment procedures
- Update dependencies

### Architecture Decision Records (ADRs)

For significant architectural decisions:

1. Create a new file in `docs/adr/`
2. Follow [ADR template](docs/adr/README.md)
3. Describe problem, solution, and consequences
4. Link to related ADRs

## Pull Request Process

### Before Submitting

- [ ] Tests pass locally: `./scripts/test-all.sh`
- [ ] Code follows style guidelines
- [ ] Documentation is updated
- [ ] Commit messages are descriptive
- [ ] No merge conflicts with `main`
- [ ] Branch is up-to-date with upstream: `git rebase upstream/main`

### PR Template

```markdown
## Description
Brief description of changes

## Related Issues
Closes #123

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## How Has This Been Tested?
Description of testing approach

## Screenshots (if applicable)

## Breaking Changes
Description of any breaking changes

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Ready for review
```

### Review Process

- PRs require at least 1 approval from maintainers
- Address review feedback
- Maintainers merge when approved

### After Merge

- Delete your feature branch
- Check CI/CD for any post-merge issues
- Monitor for any issues related to your change

## Reporting Bugs

### Before Reporting

- Check existing issues to avoid duplicates
- Verify the bug with latest version
- Test in isolation if possible

### Bug Report Template

```markdown
## Description
Clear description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. ...

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., Windows 11, Ubuntu 20.04]
- Service: [e.g., Gateway Ingestion]
- Version: [Git hash or tag]
- .NET/Java/Go version: [version]

## Logs/Screenshots
[Attach relevant logs or screenshots]

## Workaround
[If known]
```

## Feature Requests

### Before Requesting

- Check existing issues/discussions
- Consider if it aligns with project goals
- Describe the use case clearly

### Feature Request Template

```markdown
## Problem Statement
Why do you need this feature?

## Proposed Solution
How should it work?

## Alternatives Considered
Other approaches?

## Additional Context
Examples, references, etc.
```

## Questions

- **GitHub Discussions**: For general questions
- **Issues**: For bugs and feature requests
- **Email**: security@example.com (for security concerns)

## Recognition

Contributors will be:
- Listed in release notes for significant contributions
- Acknowledged in project credits
- Added to CONTRIBUTORS.md (upon request)

## Additional Resources

- [Architecture Decision Records](docs/adr/)
- [API Documentation](docs/wiki/)
- [Development Guide](docs/wiki/development.md)
- [Deployment Guide](docs/wiki/deployment.md)

## Questions?

Feel free to:
- Open a GitHub discussion
- Check existing documentation
- Reach out to maintainers

---

**Thank you for contributing to Meridian!** 🚀

