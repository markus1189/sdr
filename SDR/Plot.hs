module SDR.Plot where

import Control.Monad
import Foreign.C.Types
import Control.Monad.Trans.Either
import Data.Complex
import Foreign.Marshal.Array
import Foreign.ForeignPtr
import Foreign.Storable.Complex

import qualified Data.Vector.Storable as VS

import Graphics.Rendering.OpenGL
import Graphics.UI.GLFW as G

import Pipes 
import qualified Pipes.Prelude as P

import Graphics.DynamicGraph.SimpleLine 
import Graphics.DynamicGraph.TextureLine
import Graphics.DynamicGraph.Waterfall  
import Graphics.DynamicGraph.FillLine   

import Graphics.DynamicGraph.Axis
import Graphics.DynamicGraph.RenderCairo

plotSimple :: Int -> Int -> Int -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotSimple width height samples = do
    graphFunc <- simpleLineWindow width height samples
    let xCoords = take samples $ iterate (+ (2 / fromIntegral samples)) (-1)
    return $ forever $ do
        dat <- await
        let (fp, offset, length) = VS.unsafeToForeignPtr dat
        lift $ withForeignPtr fp $ \dp -> do
            e <- peekArray length (advancePtr dp offset)
            let interleave = concatMap (\(x, y) -> [x, y])
            withArray (interleave $ zip xCoords e) graphFunc 

plotSimpleAxes :: Int -> Int -> Int -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotSimpleAxes width height samples = do
    res' <- lift $ createWindow width height "" Nothing Nothing
    win <- maybe (left "error creating window") return res'
    lift $ makeContextCurrent (Just win)

    renderFunc <- lift $ renderSimpleLine samples
    let xCoords = take samples $ iterate (+ (2 / fromIntegral samples)) (-1)
    
    --render the axes
    let rm = renderAxes (defaultConfiguration {width = fromIntegral width, height = fromIntegral height})
    renderAxisFunc <- lift $ renderCairo rm width height

    return $ forever $ do
        dat <- await

        lift $ do
            makeContextCurrent (Just win)

            viewport $= (Position 0 0, Size (fromIntegral width) (fromIntegral height))
            renderAxisFunc

            viewport $= (Position 50 50, Size (fromIntegral width - 100) (fromIntegral height - 100))

            let (fp, offset, length) = VS.unsafeToForeignPtr dat
            withForeignPtr fp $ \dp -> do
                e <- peekArray length (advancePtr dp offset)
                let interleave = concatMap (\(x, y) -> [x, y])
                withArray (interleave $ zip xCoords e) renderFunc

            swapBuffers win

plotTexture :: Int -> Int -> Int -> Int -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotTexture width height samples xResolution = do
    renderFunc <- textureLineWindow width height samples xResolution
    return $ forever $ do
        dat <- await
        lift $ renderFunc dat

plotTextureAxes :: Int -> Int -> Int -> Int -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotTextureAxes width height samples xResolution = do
    --create a window
    res' <- lift $ createWindow width height "" Nothing Nothing
    win <- maybe (left "error creating window") return res'
    lift $ makeContextCurrent (Just win)
    
    --render the graph
    renderFunc <- lift $ renderTextureLine samples xResolution

    --render the axes
    let rm = renderAxes (defaultConfiguration {width = fromIntegral width, height = fromIntegral height})
    renderAxisFunc <- lift $ renderCairo rm width height

    return $ forever $ do
        dat <- await

        lift $ do
            makeContextCurrent (Just win)

            viewport $= (Position 0 0, Size (fromIntegral width) (fromIntegral height))
            renderAxisFunc

            viewport $= (Position 50 50, Size (fromIntegral width - 100) (fromIntegral height - 100))
            renderFunc dat

            swapBuffers win

plotWaterfall :: Int -> Int -> Int -> Int -> [GLfloat] -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotWaterfall = waterfallWindow

plotFill :: Int -> Int -> Int -> [GLfloat] -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotFill width height samples colorMap = do
    graphFunc <- filledLineWindow width height samples colorMap
    return $ forever $ await >>= lift . graphFunc

plotFillAxes :: Int -> Int -> Int -> [GLfloat] -> EitherT String IO (Consumer (VS.Vector GLfloat) IO ())
plotFillAxes width height samples colorMap = do
    res' <- lift $ createWindow width height "" Nothing Nothing
    win <- maybe (left "error creating window") return res'
    lift $ makeContextCurrent (Just win)

    renderFunc <- lift $ renderFilledLine samples colorMap
    
    --render the axes
    let rm = renderAxes (defaultConfiguration {width = fromIntegral width, height = fromIntegral height})
    renderAxisFunc <- lift $ renderCairo rm width height

    return $ forever $ do
        dat <- await

        lift $ do
            makeContextCurrent (Just win)

            viewport $= (Position 0 0, Size (fromIntegral width) (fromIntegral height))
            renderAxisFunc

            viewport $= (Position 50 50, Size (fromIntegral width - 100) (fromIntegral height - 100))
            renderFunc dat

            swapBuffers win
