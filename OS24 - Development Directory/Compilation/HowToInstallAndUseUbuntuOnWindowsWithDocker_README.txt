• Install Docker using the executable .exe file from https://docker.com

• Docker build:

	{OS24 - Development Directory/Compilation/On_Windows}
	Run this command from a terminal within the above folder 
	structure where the Docker folder is stored:
	   docker build Docker -t os24development

	Then run this command to use Ubuntu's terminal/functionality:
	   docker run -it --rm -v "${pwd}:/root/env" os24development


			(You will be accessing your Windows folders from Linux
			 by doing this)



= In case it isn't working:
Please keep in mind that developers are notorious for changing 
things around with regards to path access structures or methods. 
If the run or build commands no longer work, please check the 
Windows or Docker docs, or check for a more recent repo on my 
github.



= Docker commands:
What does each command do?:

docker build:
-t Instructs Docker to name the build whichever string you give 
it.

docker run:
-it Instructs Docker to allocate a pseudo-TTY connected to the 
container’s stdin; creating an interactive bash shell in the 
container.
--rm Instructs Docker to automatically remove the container when 
it exits
-v Bind mounts a volume (makes the directory you are currently in 
the directory the container works from)



= Validating that you did everything right:
After you have set up your Ubuntu image, you can navigate to the 
top of this folder structure (OS24 - Development Directory), and 
type:
   make test

If your container was set up properly, the terminal will output:
   "The UNIX build environment was set up seccessfully."
   "make: 'test' is up to date."

To navigate to a folder, type:
   cd FolderName

To check for folders from your location, type:
   ls

Recommended tutorials for command line interfacing:

Visual Studio Code Terminal
Linux Terminal
Windows Powershell (Optional)

You can do most of this from Visual Studio Code.