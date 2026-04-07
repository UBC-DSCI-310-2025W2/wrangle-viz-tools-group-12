# Contributing

👍🎉 First off, thank you for taking the time to contribute! 🎉👍

The following guidelines describe how to contribute to this R package. These are intended to help maintain a clear workflow and ensure contributions are easy to review, test, and integrate.

These are guidelines rather than strict rules. Use your best judgment, and feel free to propose improvements through a pull request.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Reporting Issues](#reporting-issues)
- [Direct/Core Contributors](#directcore-contributors)
- [External Contributors](#external-contributors)
- [Branch Naming Guidelines](#branch-naming-guidelines)
- [Pull Requests and Reviews](#pull-requests-and-reviews)
- [Development Setup](#development-setup)
- [Acknowledgements](#acknowledgements)

---

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](./CODE_OF_CONDUCT.md).

By participating, you are expected to uphold these standards of respectful and professional behavior.

---

## How Can I Contribute?

Contributions and bug reports are tracked through **GitHub Issues**.

Before opening a new issue, please check existing issues to avoid duplicates.

In this package, contributions typically include:

- R functions (`.R` files in the `R/` directory)  
- Unit tests (using `testthat` in `tests/testthat/`)  
- Documentation (generated via `roxygen2`, `.Rd` files in `man/`)  

When contributing:

- Ensure your local repository is up-to-date with `main`  
- Follow consistent coding style and naming conventions  
- Write clear, descriptive commit messages  

---

## Reporting Issues

If you are reporting a bug or problem, please include:

- A clear and descriptive title  
- Steps to reproduce the issue  
- Relevant code snippets or examples  
- The expected behavior vs actual behavior  
- Any relevant system/environment details  

Clear issue descriptions help diagnose and resolve problems efficiently.

---

## Direct/Core Contributors

Core contributors (team members) should follow this workflow:

- Use GitHub Issues to track tasks and bugs  
- Assign issues when starting work  
- Pull the latest version of the repository before beginning  

All changes should follow GitHub Flow:

1. Create a new branch for each feature or fix  
2. Implement changes  
3. Run local checks:
   ```r
   devtools::document()
   devtools::load_all()
   devtools::check()