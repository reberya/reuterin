// based on: https://imagej.nih.gov/ij/docs/examples/stained-sections/index.html 
// written by Ryan Rebernick on 7/14/2021

// set scale
run("Set Scale...", "distance=159 known=100 pixel=1 unit=um");

// select the green channel, which has the best contrast
run("RGB Stack");
setSlice(2);

// set threshold
setAutoThreshold();
getThreshold(min, max)
setThreshold(0, 230);

// clear results table
run("Clear Results"); 

// measure area and area fraction
run("Set Measurements...", "area area_fraction limit display redirect=None decimal=3");
run("Measure");

// function to strip extension
function getTitleStripExtension() {
  t = getTitle();
  t = replace(t, ".tif", "");        
  t = replace(t, ".tiff", "");      
  t = replace(t, ".jpg", "");      
  return t;
}

// save image
title = getTitle();
filename = getTitleStripExtension();
path = getDirectory("image");
selectWindow(title);
saveAs("jpg", path+filename+"_full");

// set threshold again 
setThreshold(0, max/2);

// measure area and area fraction
run("Measure");
selectWindow("Results");

// save image
title = getTitle();
filename = getTitleStripExtension();
path = getDirectory("image");
selectWindow(title);
saveAs("jpg", path+filename+"_partial");

// save results output
selectWindow("Results");
saveAs("results", path + filename + "_numeric.csv");

// close images
 while (nImages>0) { 
     selectImage(nImages); 
     close(); 

