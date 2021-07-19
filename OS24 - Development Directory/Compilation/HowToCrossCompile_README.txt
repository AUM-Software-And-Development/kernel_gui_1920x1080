• Use CLang. It's a cross compiler by default.
That's all you need to do is download it.
You can install the CLang compiler on Linux and Windows.

I included instructions on how to do that in 
"HowToInstallAndUseUbuntuOnWindowsWithDocker_README.txt"
There are 4 total steps. Nothing special or uniquely difficult.

===

• GCC requires a substantial amount of effort to turn 
it into a cross compiler, and I almost always find that the 
instructions online are out dated or no longer work due to 
some minor update.

"Cross compilation issues
In GCC world, every host/target combination has its own set of 
binaries, headers, libraries, etc. So, it’s usually simple to 
download a package with all files in, unzip to a directory and 
point the build system to that compiler, that will know about 
its location and find all it needs to when compiling your code.

On the other hand, Clang/LLVM is natively a cross-compiler, 
meaning that one set of programs can compile to all targets by 
setting the -target option. That makes it a lot easier for 
programmers wishing to compile to different platforms and 
architectures, and for compiler developers that only have to 
maintain one build system, and for OS distributions, that need 
only one set of main packages."

https://clang.llvm.org/docs/CrossCompilation.html

===

--I am not sure why the OSDev wiki reccommends GCC. The first 
time I tried to make the insructed GCC one, some of the 
instruction mnemonics didn't work anymore.

===

FYI: This is going to be compiled in Windows on an Ubuntu image 
in Docker for the higher level language stuff. Like I said, I 
included instructions for that, and you'll find CLang doc 
explanations in the link above.