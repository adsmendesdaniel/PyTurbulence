# state file generated using paraview version 5.11.2
import paraview
paraview.compatibility.major = 5
paraview.compatibility.minor = 11

#### import the simple module from the paraview
from paraview.simple import *
#### disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

# ----------------------------------------------------------------
# setup views used in the visualization
# ----------------------------------------------------------------

# Create a new 'Render View'
renderView1 = CreateView('RenderView')
renderView1.ViewSize = [1155, 773]
renderView1.AxesGrid = 'GridAxes3DActor'
renderView1.CenterOfRotation = [128.0, 128.0, 128.49999618530273]
renderView1.StereoType = 'Crystal Eyes'
renderView1.CameraPosition = [602.5911221730181, -389.57154645276455, -169.83445823272496]
renderView1.CameraFocalPoint = [127.99999999999991, 128.0, 128.49999618530268]
renderView1.CameraViewUp = [-0.29098347109120004, 0.2633470251528792, -0.9197700603383683]
renderView1.CameraFocalDisk = 1.0
renderView1.CameraParallelScale = 197.4707029053569

SetActiveView(None)

# ----------------------------------------------------------------
# setup view layouts
# ----------------------------------------------------------------

# create new layout object 'Layout #1'
layout1 = CreateLayout(name='Layout #1')
layout1.AssignView(0, renderView1)
layout1.SetSize(1155, 773)

# ----------------------------------------------------------------
# restore active view
SetActiveView(renderView1)
# ----------------------------------------------------------------

# ----------------------------------------------------------------
# setup the data processing pipelines
# ----------------------------------------------------------------

# create a new 'XML Image Data Reader'
vorticity_datavti = XMLImageDataReader(registrationName='vorticity_data.vti', FileName=['/home/daniel-mendes/PyTurbulence/Tools/vorticity_data.vti'])
vorticity_datavti.CellArrayStatus = ['vorticity']
vorticity_datavti.TimeArray = 'None'

# create a new 'Calculator'
calculator1 = Calculator(registrationName='Calculator1', Input=vorticity_datavti)
calculator1.AttributeType = 'Cell Data'
calculator1.Function = 'sqrt(vorticity_X^2+vorticity_Y^2+vorticity_Z^2)'

# create a new 'Cell Data to Point Data'
cellDatatoPointData1 = CellDatatoPointData(registrationName='CellDatatoPointData1', Input=calculator1)
cellDatatoPointData1.CellDataArraytoprocess = ['Result', 'vorticity']

# create a new 'Gradient'
gradient1 = Gradient(registrationName='Gradient1', Input=cellDatatoPointData1)
gradient1.ScalarArray = ['POINTS', 'vorticity']
gradient1.ComputeGradient = 0
gradient1.ComputeQCriterion = 1

# create a new 'Contour'
contour1 = Contour(registrationName='Contour1', Input=cellDatatoPointData1)
contour1.ContourBy = ['POINTS', 'Result']
contour1.Isosurfaces = [10.0]
contour1.PointMergeMethod = 'Uniform Binning'

# create a new 'Contour'
contour2 = Contour(registrationName='Contour2', Input=gradient1)
contour2.ContourBy = ['POINTS', 'Result']
contour2.Isosurfaces = [0.1]
contour2.PointMergeMethod = 'Uniform Binning'

# ----------------------------------------------------------------
# setup the visualization in view 'renderView1'
# ----------------------------------------------------------------

# show data from contour2
contour2Display = Show(contour2, renderView1, 'GeometryRepresentation')

# get 2D transfer function for 'vorticity'
vorticityTF2D = GetTransferFunction2D('vorticity')
vorticityTF2D.ScalarRangeInitialized = 1
vorticityTF2D.Range = [-29.13266686878454, 29.132666868784383, 0.0, 1.0]

# get color transfer function/color map for 'vorticity'
vorticityLUT = GetColorTransferFunction('vorticity')
vorticityLUT.TransferFunction2D = vorticityTF2D
vorticityLUT.RGBPoints = [-29.13266686878454, 0.231373, 0.298039, 0.752941, -7.815970093361102e-14, 0.865003, 0.865003, 0.865003, 29.132666868784383, 0.705882, 0.0156863, 0.14902]
vorticityLUT.ScalarRangeInitialized = 1.0
vorticityLUT.VectorMode = 'Component'

# trace defaults for the display properties.
contour2Display.Representation = 'Surface'
contour2Display.ColorArrayName = ['POINTS', 'vorticity']
contour2Display.LookupTable = vorticityLUT
contour2Display.SelectTCoordArray = 'None'
contour2Display.SelectNormalArray = 'Normals'
contour2Display.SelectTangentArray = 'None'
contour2Display.OSPRayScaleArray = 'Result'
contour2Display.OSPRayScaleFunction = 'PiecewiseFunction'
contour2Display.SelectOrientationVectors = 'None'
contour2Display.ScaleFactor = 25.6
contour2Display.SelectScaleArray = 'Result'
contour2Display.GlyphType = 'Arrow'
contour2Display.GlyphTableIndexArray = 'Result'
contour2Display.GaussianRadius = 1.28
contour2Display.SetScaleArray = ['POINTS', 'Result']
contour2Display.ScaleTransferFunction = 'PiecewiseFunction'
contour2Display.OpacityArray = ['POINTS', 'Result']
contour2Display.OpacityTransferFunction = 'PiecewiseFunction'
contour2Display.DataAxesGrid = 'GridAxesRepresentation'
contour2Display.PolarAxes = 'PolarAxesRepresentation'
contour2Display.SelectInputVectors = ['POINTS', 'Normals']
contour2Display.WriteLog = ''

# init the 'PiecewiseFunction' selected for 'ScaleTransferFunction'
contour2Display.ScaleTransferFunction.Points = [19.748920440673828, 0.0, 0.5, 0.0, 19.752826690673828, 1.0, 0.5, 0.0]

# init the 'PiecewiseFunction' selected for 'OpacityTransferFunction'
contour2Display.OpacityTransferFunction.Points = [19.748920440673828, 0.0, 0.5, 0.0, 19.752826690673828, 1.0, 0.5, 0.0]

# setup the color legend parameters for each legend in this view

# get color legend/bar for vorticityLUT in view renderView1
vorticityLUTColorBar = GetScalarBar(vorticityLUT, renderView1)
vorticityLUTColorBar.Title = 'vorticity'
vorticityLUTColorBar.ComponentTitle = 'X'

# set color bar visibility
vorticityLUTColorBar.Visibility = 1

# show color legend
contour2Display.SetScalarBarVisibility(renderView1, True)

# ----------------------------------------------------------------
# setup color maps and opacity mapes used in the visualization
# note: the Get..() functions create a new object, if needed
# ----------------------------------------------------------------

# get opacity transfer function/opacity map for 'vorticity'
vorticityPWF = GetOpacityTransferFunction('vorticity')
vorticityPWF.Points = [-29.13266686878454, 0.0, 0.5, 0.0, 29.132666868784383, 1.0, 0.5, 0.0]
vorticityPWF.ScalarRangeInitialized = 1

# ----------------------------------------------------------------
# restore active source
SetActiveSource(gradient1)
# ----------------------------------------------------------------


if __name__ == '__main__':
    # generate extracts
    SaveExtracts(ExtractsOutputDirectory='extracts')