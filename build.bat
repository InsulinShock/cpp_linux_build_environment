:: =============================================================
::                  Build Docker Image
:: =============================================================

:: Get Docker Hub username
:getusername
    set /p username=What is your dockerhub username? 
    set /p answer=Is the username %username% correct (y/n)?
    if /i "%answer:~,1%" EQU "y" goto generatedockerimage
    if /i "%answer:~,1%" EQU "n" goto getusername
    REM Please type y for Yes or n for No
    goto getusername

:: Generate the docker image
:generatedockerimage
    docker build --tag %username%/cppbuildenvironment:0.5 .

:: Prompt to run container
:again
    REM You can...
    REM * Run the container locally (r)?
    REM * Push the image to dockerhub (p)?
    REM * Or quit (q)?
    set /p answer=What do you want to do (r/p/q)?
    if /i "%answer:~,1%" EQU "r" goto runcontainer
    if /i "%answer:~,1%" EQU "p" goto pushimage
    if /i "%answer:~,1%" EQU "q" exit /b
    REM Please type Y for Yes or N for No
    goto again

:: Run the container
:runcontainer
    docker run -rm -a stdin -a stdout -i -t %username%/cppbuildenvironment:0.5 /bin/bash    
    exit /b

:: Push image to Docker Hub
:pushimage   
    docker login --username %username%
    docker push %username%/cppbuildenvironment:0.5
    docker logout
    exit /b