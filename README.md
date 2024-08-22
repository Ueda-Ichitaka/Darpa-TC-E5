# Darpa-TC-E5
Additinal Info on how to use TC-E5 and own code


# Attention!

    This is a work in progress, so expect to see unfinished, uncomplete readmes and files!



# Download TC-E5 Dataset

    Refer to https://github.com/darpa-i2o/Transparent-Computing/tree/master

    download foldersGround_Truth, Schema and Tools

    create folder Data
    download individual dataset folders and put them in Data
    start with trace and fivedirections


# Convert Data from Binary to JSON

    install the ta3-java-consumer stack following the readmes in there

    or clone and install one of raytheon bbns other ta3 binding project. only the java one has an implementation

    use convert_data.sh to convert to json. make sure to set the variables with their absolute paths correctly

    the script first decompresses all gz files, then converts the resulting bin files to json using the jaav kafka producer consumer (see darpa tc e5 repo and install according to their documentation)

    then there is the option to convert the json files to csv which can be toggled with the last argument. either way, the json files are moved to the data folder.


# View the Data with the TC Data Visualization Tool

    be advised, the dockerfile from the googledrive itself is riddled with bugs. a debugged dockerfile will follow here

    it is also required to create some folders that docker somehow can not create on its own.
