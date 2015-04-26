module Coeffs where

{-
  In Octave:
  pkg load signal
  a = [1 1 0 0]
  f = [0 0.08 0.125 1]
  remez(50, f, a)
-}

coeffsRFDecim :: [Float]
coeffsRFDecim = [

   0.0252935,
   0.0077179,
   0.0076296,
   0.0065592,
   0.0044613,
   0.0014128,
  -0.0024132,
  -0.0067080,
  -0.0110463,
  -0.0149643,
  -0.0179032,
  -0.0193486,
  -0.0188277,
  -0.0159704,
  -0.0105863,
  -0.0026480,
   0.0076515,
   0.0199119,
   0.0335666,
   0.0478808,
   0.0620109,
   0.0751344,
   0.0863093,
   0.0949120,
   0.1003152,
   0.1021502,
   0.1003152,
   0.0949120,
   0.0863093,
   0.0751344,
   0.0620109,
   0.0478808,
   0.0335666,
   0.0199119,
   0.0076515,
  -0.0026480,
  -0.0105863,
  -0.0159704,
  -0.0188277,
  -0.0193486,
  -0.0179032,
  -0.0149643,
  -0.0110463,
  -0.0067080,
  -0.0024132,
   0.0014128,
   0.0044613,
   0.0065592,
   0.0076296,
   0.0077179,
   0.0252935

    ]

{-
  In Octave:
  pkg load signal
  a = [1 1 0 0]
  f = [0 0.1 0.3 1]
  remez(30, f, a)
-}

coeffsAudioResampler :: [Float]
coeffsAudioResampler = [

  -3.0862e-04,
   1.9752e-03,
   4.1096e-03,
   5.8306e-03,
   4.9003e-03,
  -4.7097e-04,
  -1.0215e-02,
  -2.1264e-02,
  -2.7609e-02,
  -2.2054e-02,
   7.7070e-04,
   4.1331e-02,
   9.3585e-02,
   1.4595e-01,
   1.8477e-01,
   1.9910e-01,
   1.8477e-01,
   1.4595e-01,
   9.3585e-02,
   4.1331e-02,
   7.7070e-04,
  -2.2054e-02,
  -2.7609e-02,
  -2.1264e-02,
  -1.0215e-02,
  -4.7097e-04,
   4.9003e-03,
   5.8306e-03,
   4.1096e-03,
   1.9752e-03,
  -3.0862e-04
    ]

{-
  In Octave:
  pkg load signal
  a = [1 1 0 0]
  f = [0 0.3125 0.39 1]
  remez(63, f, a)
-}

coeffsAudioFilter :: [Float]
coeffsAudioFilter = [
  -9.7012e-04,
   2.7597e-03,
   2.3268e-03,
   2.1329e-04,
  -2.5554e-03,
  -2.8447e-03,
   5.2539e-04,
   4.3515e-03,
   3.8007e-03,
  -1.7850e-03,
  -6.7531e-03,
  -4.5910e-03,
   3.9695e-03,
   9.8709e-03,
   4.9674e-03,
  -7.4512e-03,
  -1.3809e-02,
  -4.5709e-03,
   1.2815e-02,
   1.8790e-02,
   2.8118e-03,
  -2.1201e-02,
  -2.5418e-02,
   1.4774e-03,
   3.5499e-02,
   3.5678e-02,
  -1.1702e-02,
  -6.6386e-02,
  -5.8929e-02,
   4.7084e-02,
   2.1073e-01,
   3.3360e-01
    ]
