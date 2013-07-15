#!/bin/sh
# make sure we haven't missed anything (much) in svn. Note that this doesn't commit or attempt to add entire directories
TB='/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components'
OSCR='/home/graham_s/VirtualWorlds/projects/oscr/model/'
cd $OSCR
find . -name "*.ads" -o -name "*.rb" -o -name "*.adb" -o -name "*.xml" -o -name "*.sh" -o -name "*.sql" -o -name "*.py" -o -name "*.gpr" | xargs svn add
find . -name "*.ads" -o -name "*.rb" -o -name "*.adb" -o -name "*.xml" -o -name "*.sh" -o -name "*.sql" -o -name "*.py" -o -name "*.gpr" | xargs svn propset svn:keywords "Date Author Revision"

cd $TB
find . -name "*.ads" -o -name "*.rb" -o -name "*.adb" -o -name "*.xml" -o -name "*.sh" -o -name "*.sql" -o -name "*.py" -o -name "*.gpr" | xargs svn add
find . -name "*.ads" -o -name "*.rb" -o -name "*.adb" -o -name "*.xml" -o -name "*.sh" -o -name "*.sql" -o -name "*.py" -o -name "*.gpr" | xargs svn propset svn:keywords "Date Author Revision"

