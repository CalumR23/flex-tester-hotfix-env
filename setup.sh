#### Constants

# set current working directory
	cwd=$(pwd)
# Exceptions
	set -e

# Check if 7z is installed
	if ! archiverLocation="$(type -p "7z")" || [[ -z $archiverLocation ]]; then
 		echo -e "\e[101m7z is not installed. Please install 7z and try again.\e[0m"
	fi

#### Functions
dl72hf(){
#Downloads Portal Base
	read -p 'Please specify download link for portal: ' portaldl
	wget -c -N $portaldl
  echo -e "\e[44mDownloading portal instance.\e[0m"
  
  #unzip portal file
	
  
# Clean out old copy
	echo -e "\e[44mCleaning out old extracted binaries/folders\e[0m"
	rm -rf $cwd/bundles/hotfixer
	clean

# Create directories that will be used
	echo -e "\e[44mCreating folders for bundle backup if they don't exist\e[0m"
	mkdir -p bundles/hotfixer
	mkdir -p hotfixer

# Check download it
  echo -e "\e[44mDownloading the master snapshot if its updated\e[0m"
	wget -c -N https://files.liferay.com/private/ee/portal/7.2.10-dxp-7/liferay-dxp-tomcat-7.2.10-dxp-7-20200727205713822.7z -P $cwd/bundles/master
	echo -e "\e[44mDone downloading or checking\e[0m"
}
usage ()
{
	cat <<HELP_USAGE
	$0 <parameter>
	Parameters
	----------
	clean              - Deletes everything except bundles, resources and setup.sh
	cleandb            - Cleans the database if it already exists
	cleanmaster        - Doesn't download, just cleans up completely
	cluster		   - Sets up a clean 2 cluster node
	createdb           - Creates the database
	dl72hf               - Downloads the 7.1 CE GA3
	dlmaster           - Downloads the latest master
	rstaging           - Sets up remote staging where remote is 8080 and live is 9080
HELP_USAGE
}

#### Check if no parameters are sent

if [ $# -eq 0 ]
  then
    usage
fi

#### Accepts Parameters
for setupParameters in "$@"
do
    $setupParameters
done