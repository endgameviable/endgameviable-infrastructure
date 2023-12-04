PROFILE=--profile default

STACKNAME=endgameviable231203
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

delete: deleteamplify deletebuild deleteresource
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
	aws cloudformation wait stack-create-complete $(RESOURCENAME)
createamplify:
	$(CREATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE)  --parameters $(STACKPARAMS)
	aws cloudformation wait stack-create-complete $(AMPLIFYNAME)
createbuild:
	$(CREATE) $(BUILDNAME) $(BUILDBODY) $(BUILDPARAMS) $(PROFILE)  --parameters $(STACKPARAMS) ParameterKey=contentRepo,ParameterValue=endgameviable-content
	aws cloudformation wait stack-create-complete $(BUILDNAME)

UPDATE=aws cloudformation update-stack
updateresource:
	$(UPDATE) $(RESOURCENAME) $(RESOURCEBODY) $(RESOURCEPARAMS) $(PROFILE) --parameters $(STACKPARAMS)
	aws cloudformation wait stack-update-complete $(RESOURCENAME)
updateamplify:
	$(UPDATE) $(AMPLIFYNAME) $(AMPLIFYBODY) $(AMPLIFYPARAMS) $(PROFILE) --parameters $(STACKPARAMS)
	aws cloudformation wait stack-update-complete $(AMPLIFYNAME)
updatebuild:
	$(UPDATE) $(BUILDNAME) $(BUILDBODY) $(BUILDPARAMS) $(PROFILE) --parameters $(STACKPARAMS) ParameterKey=contentRepo,ParameterValue=endgameviable-content
	aws cloudformation wait stack-update-complete $(BUILDNAME)

DELETE=aws cloudformation delete-stack
deleteresource:
	$(DELETE) $(RESOURCENAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(RESOURCENAME)
deleteamplify:
	$(DELETE) $(AMPLIFYNAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(AMPLIFYNAME)
deletebuild:
	$(DELETE) $(BUILDNAME) $(PROFILE) --no-paginate
	aws cloudformation wait stack-delete-complete $(BUILDNAME)

outputvars:
	echo EGV_RESOURCE_EVENT_QUEUE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-resource --query "Stacks[0].Outputs[?OutputKey=='EventQueue'].OutputValue" --output text) > .env.local
	echo EGV_RESOURCE_STATE_TABLE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-resource --query "Stacks[0].Outputs[?OutputKey=='StateTable'].OutputValue" --output text) >> .env.local
	echo EGV_RESOURCE_JSON_BUCKET=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-build --query "Stacks[0].Outputs[?OutputKey=='JSONBucketName'].OutputValue" --output text) >> .env.local
	echo EGV_RESOURCE_SEARCH_TABLE=$$(aws cloudformation describe-stacks --stack-name $(STACKNAME)-build --query "Stacks[0].Outputs[?OutputKey=='SearchTableName'].OutputValue" --output text) >>.env.local
	cat .env.local
