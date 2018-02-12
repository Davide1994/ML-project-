This is my Car's License Plates recognition project.

In "ML Project Davide Ilardi" you can find several subfolders:
- Convolution = here you will find the result of the convolution, consisting in several 200x80 images of a initial photo.
- Dataset = here you can find the 867 images, whose dimensions are always 200x80, that will instruct our model. (179 of 
		them are actually car's license plates)
- OtherElements = here you can find 18 pieces of different photos from where I extracted the elements labelled with -1.
- OtherElementsDataset = here there are the 200x80 images labelled with -1, as said before.
- Photos = here you can see the photos taken directly by me and on wich all this entire project is built.
- PhotoToBeProcessed = here there are the photos I want to process in order to find the license plates inside.
- PlatesIdentified = here, after computation, you will find the 200x80 images extracted from the photos belonging to 
		"PhotoToBeProcessed" and labelled with 1, so identified as license plates.

From the computational point of view, I think I added several comments in "main.m" script, from which you will 
		understand the variables' meaning and the different functions' goals. So, executing only "main.m", you
		will be able to obtain the wanted results without any problem.