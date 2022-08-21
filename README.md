# Quantification of bacteria-fungi interkingdom assemblages

Code was written in Matlab R2020

Usage of the scripts:

batch_getBiovolume_SurfaceCoverage should be used in BiofilmQ advanced batch processing to generate results files containing biovolume and surface coverage measurements 
(such as data/antifungal_biovolume_surfaceCoverage, data/auto-aggregates_biovolume_surfaceCoverage, data/co-aggregates_biovolume_surfaceCoverage)

batch_getSpatialOrganization should be used in the BiofilmQ advances batch processing to generate files summarizing the spatial organization of aggregates
(such as data/spatialOrganization)

plotAccumulatedMovement generates a plot displaying the accumulated movement over time (Fig. 4F)

plotBiovolume_SurfaceCoverage generates plots of the biovolume over time and the surface coverage over time (Fig. 3 C,D)

plotCentroidOverTime generates a plot of the centroid trajectory over time and the projection of this trajectory (Fig. 4 C-E). To run this script, the directory for which the trajectory should be plotted needs to first be loaded into the visualization space of BiofilmQ.

plotSpatialOrganization generates plots of the spatial abundances of matrix, bacteria and fungi (Fig. 1 H)

shadedPlot and prepBiomassData are helper functions
