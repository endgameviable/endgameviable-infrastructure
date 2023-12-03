PROFILE=--profile default

STACKNAME=egvtest231202

RESOURCENAME=--stack-name=$(STACKNAME)-resources
RESOURCETEMPLATE=./templates/resource.yaml
RESOURCEBODY=--template-body file://$(RESOURCETEMPLATE)
RESOURCEPARAMS=

AMPLIFYNAME=--stack-name=$(STACKNAME)-amplify
AMPLIFYTEMPLATE=./templates/amplify.yaml
AMPLIFYBODY=--template-body file://$(AMPLIFYTEMPLATE)
AMPLIFYPARAMS=--capabilities CAPABILITY_IAM

BUILDNAME=--stack-name=$(STACKNAME)-builds
BUILDTEMPLATE=./templates/build.yaml
BUILDBODY=--template-body file://$(BUILDTEMPLATE)
BUILDPARAMS=--capabilities CAPABILITY_IAM

validate: validateresources validateamplify validatebuilds
	echo done

create: createresources createamplify createbuilds
	echo done

VALIDATE=aws cloudformation validate-template
validateresource:
	$(VALIDATE) $(RESOURCEBODY) $(PROFILE) --no-paginate
validateamplify:
	$(VALIDATE) $(AMPLIFYBODY) $(PROFILE) --no-paginate
validatebuild:
	$(VALIDATE) $(BUILDBODY) $(PROFILE) --no-paginate

CREATE=aws cloudformation create-stack
createresource:
	$(CREATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCEPARAMS) $(PROFILE) --no-paginate
createamplify:
	$(CREATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE) --no-paginate
createbuild:
	$(CREATE) $(BUILDNAME) $(BUILDBODY) $(BUILDPARAMS) $(PROFILE) --no-paginate

UPDATE=aws cloudformation update-stack
updateresource:
	$(UPDATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCEPARAMS) $(PROFILE) --no-paginate
updateamplify:
	$(UPDATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE) --no-paginate
updatebuild:
	$(UPDATE) $(BUILDNAME) $(BUILDBODY) $(BUILDBODY) $(PROFILE) --no-paginate

DELETE=aws cloudformation delete-stack
deleteresource:
	$(DELETE) $(RESOURCENAME) $(PROFILE) --no-paginate
deleteamplify:
	$(DELETE) $(AMPLIFYNAME) $(PROFILE) --no-paginate
deletebuild:
	$(DELETE) $(BUILDNAME) $(PROFILE) --no-paginate
