# Guidelines for Contributing

## Commit Messages

This repository follows the [Conventional Commits v1.0.0 guidelines](https://www.conventionalcommits.org/en/v1.0.0/) for
commit messages. That is to say, commit messages should be structured as follows:

```
<type>(<scope>): <description>
```

Where `type` should be one of the following:

- `feat`: for new features
- `fix`: for bug or copy fixes
- `style`: for changes to the style of code
- `perf`: performance improvements
- `refactor`: for code refactoring
- `docs`: changes to documentation
- `test`: changes or additions to automated tests
- `ci`: updates to CI/CD workflows
- `chore`: maintenance tasks like updating dependencies or build scripts

And `scope` should be one of:

- `ansible`: changes to Ansible playbooks and roles
- `k8s`: changes to Kubernetes manifests
- `docs`: changes to the documentation website
- `github`: misc repository changes

## Submitting your Pull Request

Changes can be submitted for review by creating a Pull Request to the `main` branch. Please ensure that your Pull
Request includes a clear description of the changes you have made and the reasoning behind them. If your Pull Request is
related to an issue, please reference the issue number in the description.

Pull Requests cannot be merged until they have been approved by at least one contributor. When working on your Pull
Request, please mark it as a draft until you are ready for it to be reviewed.