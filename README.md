# 'cagedbirdID': Identifying birds in the wildlife trade

Code and guidance (written by Sicily Fiennes, with the assistance of Sam Watts) to identify traded animals in highly occluded contexts, based on images.

## File list for merging photos in Python for side-side pairings for a match-mismatch experiment
1. Using the merge function in Python to set up a match-mismatch survey
2. Testing for differences between match/mismatch questions and plotting phylogenies using ggfree

## File List for image-based species recognition
3. Glossary of machine learning terms
4. Hardware requirements: setting up Python and downloading TensorFlow
5. Running code on University High Performance Computers
6. Object Detection using the MegaDetector to localise and extract bird crops
7. Data pre-processing: image augmentation as a method of class balancing
8. Training convolutional networks: training the models for species identification
9. Ensembling models
10. Evaluating model performance using cross validation

*Our work flow for the classification of 37 bird species*


![workflow](/path986-4-5-4_evensmaller.png)

## File List for a binary model to distinguish between caged and uncaged photos
11. Building a binary model
12. Superimposing uncaged images with caged masks in the foreground, generating new test sets and training a model on folds with differing levels of occlusion
13. Building a Shiny App in R, using a custom model you saved in Python, then there is more flexibility- check one of the desnet augre16 files 

## Useful links 
### Learning Python for the first time
* [Machine Learning Mastery](https://machinelearningmastery.com/) - Dr. Jason Brownlee
* 
### Getting to grips with the concept of machine learning
### Machine Learning and Tensorflow in R
If you are an R user, please see this tutorial for training - for a similar approach
You can save your model in Python using the command. save_model (...); which will save your model and its associated Tensorflow graph.

## Additional information
The website for this work can be found @ https://sicily-f.github.io/cagedbirdID/, which has more rationale for the project. For more information about our methods, processes of deduction and tool selection please contact [sicilyfiennes@gmail.com](mailto:sicilyfiennes@gmail.com). If you have a question related to the material presented here, please create a New Issue under the ‘Issues’ tab above. If you can specify the name of the notebook which your question is related to, that would also be great. 
