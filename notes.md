installing multiple perl packages at once:
https://stackoverflow.com/questions/25490730/how-to-install-multiple-perl-modules-at-once-using-cpan
```
perl -MCPAN -e 'install($_) for qw( DBIx::Transaction File::Basename::Object )'
```

# FIGURE OUT
 - [x] I think my current dockerfile may require sudo to use the meme install? confirm ownership of files.
  - ok... don't think this is true. Files have rx permission for all.
 - [ ] does meme need `openssh-server`? 
	- I don't think so, can't tell from docs.

# TODO
 - compare bioc_docker installed pkgs to ones needed for meme
 	- dump list with `sudo apt list --installed >> installed.txt`
 - only install missing dependencies
 - bioc_docker has python2 and 3 installed. Use `/usr/bin/python3`
 - add path to meme to .Renviron
 	- `echo MEME_PATH=/opt/meme/bin >> /home/rstudio/.Renviron` will set during container usage
  - `echo MEME_PATH=/opt/meme/bin >> ~/.R/check.Renviron` will set during R CMD CHECK


