PROFILE=--profile default

STACKNAME=egvtest231202
STACKPARAMS=ParameterKey=stackGroup,ParameterValue=${STACKNAME}

RESOURCENAME=--stack-name=$(STACKNAME)-resource
RESOURCETEMPLATE=./templates/resource.yaml
RESOURCEBODY=--template-body file://$(RESOURCETEMPLATE)
RESOURCEPARAMS=

AMPLIFYNAME=--stack-name=$(STACKNAME)-amplify
AMPLIFYTEMPLATE=./templates/amplify.yaml
AMPLIFYBODY=--template-body file://$(AMPLIFYTEMPLATE)
AMPLIFYPARAMS=--capabilities CAPABILITY_IAM

BUILDNAME=--stack-name=$(STACKNAME)-build
BUILDTEMPLATE=./templates/build.yaml
BUILDBODY=--template-body file://$(BUILDTEMPLATE)
BUILDPARAMS=--capabilities CAPABILITY_IAM

validate: validateresource validatebuild validateamplify
	echo done

create: createresource createbuild createamplify
	echo done

update: updateresource updatebuild updateamplify
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
	$(CREATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCEPARAMS) $(PROFILE) --parameters $(STACKPARAMS)
createamplify:
	$(CREATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE)  --parameters $(STACKPARAMS)
createbuild:
	$(CREATE) $(BUILDNAME) $(BUILDBODY) $(BUILDPARAMS) $(PROFILE)  --parameters $(STACKPARAMS) ParameterKey=contentRepo,ParameterValue=endgameviable-content

UPDATE=aws cloudformation update-stack
updateresource:
	$(UPDATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCEPARAMS) $(PROFILE) --parameters $(STACKPARAMS)
updateamplify:
	$(UPDATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE) --parameters $(STACKPARAMS)
updatebuild:
	$(UPDATE) $(BUILDNAME) $(BUILDBODY) $(BUILDBODY) $(PROFILE) --parameters $(STACKPARAMS) ParameterKey=contentRepo,ParameterValue=endgameviable-content

DELETE=aws cloudformation delete-stack
deleteresource:
	$(DELETE) $(RESOURCENAME) $(PROFILE) --no-paginate
deleteamplify:
	$(DELETE) $(AMPLIFYNAME) $(PROFILE) --no-paginate
deletebuild:
	$(DELETE) $(BUILDNAME) $(PROFILE) --no-paginate
