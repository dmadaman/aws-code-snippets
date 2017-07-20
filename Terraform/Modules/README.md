# README #
This terraform repository for building/housing modules, to actually run these modules you must create the relevant tf files to execute them.

### What is this repository for? ###

* Creating reusable modules that can be referenced using git path and tagging combination in our accounts main.tf files. 


### Contribution guidelines ###
In order to contribute to this REPO we recommend you use the git-tf git wrapper. You can copy or sym link git-tf to /usr/local/bin/ of your local machine and from there invoke it like this:

git tf -t ${increment_type} 

Increment type will be major/minor/hotfix which map to a 0.0.0 structure. 

When you run this wrapper script it will not allow committing to multiple modules at the same time to prevent clobbering of multiple modules sharing the same versions. It will automatically increment by whatever variable you pass it. If you are just doing a hot fix and we're at version 1.0.0 and you run
git tf -t hotfix it will add a git tag to whatever module you updated like so: networking-1.0.1

The purpose of this git tagging we enforce is to allow us to reference this repository by git URL and subdirectory matched with a git tag. We can then have backwards compatible code running in all environments simply by updating the git tag used to reference the module in question. 

The second thing necessary is to ensure all of your commit messages contain the following:

* added variables
* removed variables

If you add or remove variables to a module you must then update the module's wherever it get's called for whatever environment you are updating. 

