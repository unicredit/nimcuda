 {.deadCodeElim: on.}
when defined(windows):
  const
    libName = "curand.dll"
elif defined(macosx):
  const
    libName = "libcurand.dylib"
else:
  const
    libName = "libcurand.so"
##  Copyright 2010-2014 NVIDIA Corporation.  All rights reserved.
## 
##  NOTICE TO LICENSEE:
## 
##  The source code and/or documentation ("Licensed Deliverables") are
##  subject to NVIDIA intellectual property rights under U.S. and
##  international Copyright laws.
## 
##  The Licensed Deliverables contained herein are PROPRIETARY and
##  CONFIDENTIAL to NVIDIA and are being provided under the terms and
##  conditions of a form of NVIDIA software license agreement by and
##  between NVIDIA and Licensee ("License Agreement") or electronically
##  accepted by Licensee.  Notwithstanding any terms or conditions to
##  the contrary in the License Agreement, reproduction or disclosure
##  of the Licensed Deliverables to any third party without the express
##  written consent of NVIDIA is prohibited.
## 
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
##  SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  THEY ARE
##  PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.
##  NVIDIA DISCLAIMS ALL WARRANTIES WITH REGARD TO THESE LICENSED
##  DELIVERABLES, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY,
##  NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY
##  SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
##  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
##  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
##  ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
##  OF THESE LICENSED DELIVERABLES.
## 
##  U.S. Government End Users.  These Licensed Deliverables are a
##  "commercial item" as that term is defined at 48 C.F.R. 2.101 (OCT
##  1995), consisting of "commercial computer software" and "commercial
##  computer software documentation" as such terms are used in 48
##  C.F.R. 12.212 (SEPT 1995) and are provided to the U.S. Government
##  only as a commercial end item.  Consistent with 48 C.F.R.12.212 and
##  48 C.F.R. 227.7202-1 through 227.7202-4 (JUNE 1995), all
##  U.S. Government End Users acquire the Licensed Deliverables with
##  only those rights set forth herein.
## 
##  Any use of the Licensed Deliverables in individual and commercial
##  software must include, in the user documentation and internal
##  comments to the code, the above Disclaimer and U.S. Government End
##  Users Notice.
## 

when not defined(CURAND_H):
  const
    CURAND_H* = true
  ## *
  ##  \defgroup HOST Host API
  ## 
  ##  @{
  ## 
  ##  CURAND Host API datatypes
  ## *  
  ##  @{
  ## 
  ## *
  ##  CURAND function call status types 
  ## 
  type
    curandStatus* {.size: sizeof(cint).} = enum
      CURAND_STATUS_SUCCESS = 0, ## /< No errors
      CURAND_STATUS_VERSION_MISMATCH = 100, ## /< Header file and linked library version do not match
      CURAND_STATUS_NOT_INITIALIZED = 101, ## /< Generator not initialized
      CURAND_STATUS_ALLOCATION_FAILED = 102, ## /< Memory allocation failed
      CURAND_STATUS_TYPE_ERROR = 103, ## /< Generator is wrong type
      CURAND_STATUS_OUT_OF_RANGE = 104, ## /< Argument out of range
      CURAND_STATUS_LENGTH_NOT_MULTIPLE = 105, ## /< Length requested is not a multple of dimension
      CURAND_STATUS_DOUBLE_PRECISION_REQUIRED = 106, ## /< GPU does not have double precision required by MRG32k3a
      CURAND_STATUS_LAUNCH_FAILURE = 201, ## /< Kernel launch failure
      CURAND_STATUS_PREEXISTING_FAILURE = 202, ## /< Preexisting failure on library entry
      CURAND_STATUS_INITIALIZATION_FAILED = 203, ## /< Initialization of CUDA failed
      CURAND_STATUS_ARCH_MISMATCH = 204, ## /< Architecture mismatch, GPU does not support requested feature
      CURAND_STATUS_INTERNAL_ERROR = 999
  ## 
  ##  CURAND function call status types
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandStatus_t* = curandStatus
  ## * \endcond
  ## *
  ##  CURAND generator types
  ## 
  type
    curandRngType* {.size: sizeof(cint).} = enum
      CURAND_RNG_TEST = 0, CURAND_RNG_PSEUDO_DEFAULT = 100, ## /< Default pseudorandom generator
      CURAND_RNG_PSEUDO_XORWOW = 101, ## /< XORWOW pseudorandom generator
      CURAND_RNG_PSEUDO_MRG32K3A = 121, ## /< MRG32k3a pseudorandom generator
      CURAND_RNG_PSEUDO_MTGP32 = 141, ## /< Mersenne Twister MTGP32 pseudorandom generator
      CURAND_RNG_PSEUDO_MT19937 = 142, ## /< Mersenne Twister MT19937 pseudorandom generator
      CURAND_RNG_PSEUDO_PHILOX4_32_10 = 161, ## /< PHILOX-4x32-10 pseudorandom generator
      CURAND_RNG_QUASI_DEFAULT = 200, ## /< Default quasirandom generator
      CURAND_RNG_QUASI_SOBOL32 = 201, ## /< Sobol32 quasirandom generator
      CURAND_RNG_QUASI_SCRAMBLED_SOBOL32 = 202, ## /< Scrambled Sobol32 quasirandom generator
      CURAND_RNG_QUASI_SOBOL64 = 203, ## /< Sobol64 quasirandom generator
      CURAND_RNG_QUASI_SCRAMBLED_SOBOL64 = 204
  ## 
  ##  CURAND generator types
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandRngType_t* = curandRngType
  ## * \endcond
  ## *
  ##  CURAND ordering of results in memory
  ## 
  type
    curandOrdering* {.size: sizeof(cint).} = enum
      CURAND_ORDERING_PSEUDO_BEST = 100, ## /< Best ordering for pseudorandom results
      CURAND_ORDERING_PSEUDO_DEFAULT = 101, ## /< Specific default 4096 thread sequence for pseudorandom results
      CURAND_ORDERING_PSEUDO_SEEDED = 102, ## /< Specific seeding pattern for fast lower quality pseudorandom results
      CURAND_ORDERING_QUASI_DEFAULT = 201
  ## 
  ##  CURAND ordering of results in memory
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandOrdering_t* = curandOrdering
  ## * \endcond
  ## *
  ##  CURAND choice of direction vector set
  ## 
  type
    curandDirectionVectorSet* {.size: sizeof(cint).} = enum
      CURAND_DIRECTION_VECTORS_32_JOEKUO6 = 101, ## /< Specific set of 32-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions
      CURAND_SCRAMBLED_DIRECTION_VECTORS_32_JOEKUO6 = 102, ## /< Specific set of 32-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions, and scrambled
      CURAND_DIRECTION_VECTORS_64_JOEKUO6 = 103, ## /< Specific set of 64-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions
      CURAND_SCRAMBLED_DIRECTION_VECTORS_64_JOEKUO6 = 104
  ## 
  ##  CURAND choice of direction vector set
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectorSet_t* = curandDirectionVectorSet
  ## * \endcond
  ## *
  ##  CURAND array of 32-bit direction vectors
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectors32_t* = array[32, cuint]
  ## * \endcond
  ## *
  ##  CURAND array of 64-bit direction vectors
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectors64_t* = array[64, culonglong]
  ## * \endcond *
  ## *
  ##  CURAND generator (opaque)
  ## 
  type
    curandGenerator_st* = object
    
  ## *
  ##  CURAND generator
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandGenerator_t* = ptr curandGenerator_st
  ## * \endcond
  ## *
  ##  CURAND distribution
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandDistribution_st* = cdouble
    curandDistribution_t* = ptr curandDistribution_st
    curandDistributionShift_t* = ptr curandDistributionShift_st
  ## * \endcond
  ## *
  ##  CURAND distribution M2
  ## 
  ## * \cond UNHIDE_TYPEDEFS
  type
    curandDistributionM2Shift_t* = ptr curandDistributionM2Shift_st
    curandHistogramM2_t* = ptr curandHistogramM2_st
    curandHistogramM2K_st* = cuint
    curandHistogramM2K_t* = ptr curandHistogramM2K_st
    curandHistogramM2V_st* = curandDistribution_st
    curandHistogramM2V_t* = ptr curandHistogramM2V_st
    curandDiscreteDistribution_t* = ptr curandDiscreteDistribution_st
  ## * \endcond
  ## 
  ##  CURAND METHOD
  ## 
  ## * \cond UNHIDE_ENUMS
  type
    curandMethod* {.size: sizeof(cint).} = enum
      CURAND_CHOOSE_BEST = 0,   ##  choose best depends on args
      CURAND_ITR = 1, CURAND_KNUTH = 2, CURAND_HITR = 3, CURAND_M1 = 4, CURAND_M2 = 5,
      CURAND_BINARY_SEARCH = 6, CURAND_DISCRETE_GAUSS = 7, CURAND_REJECTION = 8,
      CURAND_DEVICE_API = 9, CURAND_FAST_REJECTION = 10, CURAND_3RD = 11,
      CURAND_DEFINITION = 12, CURAND_POISSON = 13
  type
    curandMethod_t* = curandMethod
  ## * \endcond
  ## *
  ##  @}
  ## 
  ## *
  ##  \brief Create new random number generator.
  ## 
  ##  Creates a new random number generator of type \p rng_type
  ##  and returns it in \p *generator.
  ## 
  ##  Legal values for \p rng_type are:
  ##  - CURAND_RNG_PSEUDO_DEFAULT
  ##  - CURAND_RNG_PSEUDO_XORWOW 
  ##  - CURAND_RNG_PSEUDO_MRG32K3A
  ##  - CURAND_RNG_PSEUDO_MTGP32
  ##  - CURAND_RNG_PSEUDO_MT19937 
  ##  - CURAND_RNG_PSEUDO_PHILOX4_32_10
  ##  - CURAND_RNG_QUASI_DEFAULT
  ##  - CURAND_RNG_QUASI_SOBOL32
  ##  - CURAND_RNG_QUASI_SCRAMBLED_SOBOL32
  ##  - CURAND_RNG_QUASI_SOBOL64
  ##  - CURAND_RNG_QUASI_SCRAMBLED_SOBOL64
  ##  
  ##  When \p rng_type is CURAND_RNG_PSEUDO_DEFAULT, the type chosen
  ##  is CURAND_RNG_PSEUDO_XORWOW.  \n
  ##  When \p rng_type is CURAND_RNG_QUASI_DEFAULT,
  ##  the type chosen is CURAND_RNG_QUASI_SOBOL32.
  ##  
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_XORWOW are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MRG32K3A are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MTGP32 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MT19937 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  * The default values for \p rng_type = CURAND_RNG_PSEUDO_PHILOX4_32_10 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SOBOL32 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SOBOL64 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SCRAMBBLED_SOBOL32 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SCRAMBLED_SOBOL64 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  \param generator - Pointer to generator
  ##  \param rng_type - Type of generator to create
  ## 
  ##  \return 
  ##  - CURAND_STATUS_ALLOCATION_FAILED, if memory could not be allocated \n
  ##  - CURAND_STATUS_INITIALIZATION_FAILED if there was a problem setting up the GPU \n
  ##  - CURAND_STATUS_VERSION_MISMATCH if the header file version does not match the 
  ##    dynamically linked library version \n
  ##  - CURAND_STATUS_TYPE_ERROR if the value for \p rng_type is invalid \n
  ##  - CURAND_STATUS_SUCCESS if generator was created successfully \n
  ##  
  ## 
  proc curandCreateGenerator*(generator: ptr curandGenerator_t;
                             rng_type: curandRngType_t): curandStatus_t {.cdecl,
      cdecl, importc: "curandCreateGenerator", dynlib: libName.}
  ## *
  ##  \brief Create new host CPU random number generator.
  ## 
  ##  Creates a new host CPU random number generator of type \p rng_type
  ##  and returns it in \p *generator.
  ## 
  ##  Legal values for \p rng_type are:
  ##  - CURAND_RNG_PSEUDO_DEFAULT
  ##  - CURAND_RNG_PSEUDO_XORWOW 
  ##  - CURAND_RNG_PSEUDO_MRG32K3A
  ##  - CURAND_RNG_PSEUDO_MTGP32
  ##  - CURAND_RNG_PSEUDO_MT19937
  ##  - CURAND_RNG_PSEUDO_PHILOX4_32_10
  ##  - CURAND_RNG_QUASI_DEFAULT
  ##  - CURAND_RNG_QUASI_SOBOL32
  ##  
  ##  When \p rng_type is CURAND_RNG_PSEUDO_DEFAULT, the type chosen
  ##  is CURAND_RNG_PSEUDO_XORWOW.  \n
  ##  When \p rng_type is CURAND_RNG_QUASI_DEFAULT,
  ##  the type chosen is CURAND_RNG_QUASI_SOBOL32.
  ##  
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_XORWOW are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MRG32K3A are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MTGP32 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_PSEUDO_MT19937 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  * The default values for \p rng_type = CURAND_RNG_PSEUDO_PHILOX4_32_10 are:
  ##  - \p seed = 0
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_PSEUDO_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SOBOL32 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SOBOL64 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SCRAMBLED_SOBOL32 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  The default values for \p rng_type = CURAND_RNG_QUASI_SCRAMBLED_SOBOL64 are:
  ##  - \p dimensions = 1
  ##  - \p offset = 0
  ##  - \p ordering = CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  \param generator - Pointer to generator
  ##  \param rng_type - Type of generator to create
  ## 
  ##  \return
  ##  - CURAND_STATUS_ALLOCATION_FAILED if memory could not be allocated \n
  ##  - CURAND_STATUS_INITIALIZATION_FAILED if there was a problem setting up the GPU \n
  ##  - CURAND_STATUS_VERSION_MISMATCH if the header file version does not match the
  ##    dynamically linked library version \n
  ##  - CURAND_STATUS_TYPE_ERROR if the value for \p rng_type is invalid \n
  ##  - CURAND_STATUS_SUCCESS if generator was created successfully \n
  ## 
  proc curandCreateGeneratorHost*(generator: ptr curandGenerator_t;
                                 rng_type: curandRngType_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandCreateGeneratorHost", dynlib: libName.}
  ## *
  ##  \brief Destroy an existing generator.
  ## 
  ##  Destroy an existing generator and free all memory associated with its state.
  ## 
  ##  \param generator - Generator to destroy
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_SUCCESS if generator was destroyed successfully \n
  ## 
  proc curandDestroyGenerator*(generator: curandGenerator_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandDestroyGenerator", dynlib: libName.}
  ## *
  ##  \brief Return the version number of the library.
  ## 
  ##  Return in \p *version the version number of the dynamically linked CURAND
  ##  library.  The format is the same as CUDART_VERSION from the CUDA Runtime.
  ##  The only supported configuration is CURAND version equal to CUDA Runtime
  ##  version.
  ## 
  ##  \param version - CURAND library version
  ## 
  ##  \return
  ##  - CURAND_STATUS_SUCCESS if the version number was successfully returned \n
  ## 
  proc curandGetVersion*(version: ptr cint): curandStatus_t {.cdecl, cdecl,
      importc: "curandGetVersion", dynlib: libName.}
  ## *
  ##  \brief Return the value of the curand property.
  ## 
  ##  Return in \p *value the number for the property described by \p type of the
  ##  dynamically linked CURAND library.
  ## 
  ##  \param type - CUDA library property
  ##  \param value - integer value for the requested property
  ## 
  ##  \return
  ##  - CURAND_STATUS_SUCCESS if the property value was successfully returned \n
  ##  - CURAND_STATUS_OUT_OF_RANGE if the property type is not recognized \n
  ## 
  proc curandGetProperty*(`type`: libraryPropertyType; value: ptr cint): curandStatus_t {.
      cdecl, cdecl, importc: "curandGetProperty", dynlib: libName.}
  ## *
  ##  \brief Set the current stream for CURAND kernel launches.
  ## 
  ##  Set the current stream for CURAND kernel launches.  All library functions
  ##  will use this stream until set again.
  ## 
  ##  \param generator - Generator to modify
  ##  \param stream - Stream to use or ::NULL for null stream
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_SUCCESS if stream was set successfully \n
  ## 
  proc curandSetStream*(generator: curandGenerator_t; stream: cudaStream_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandSetStream", dynlib: libName.}
  ## *
  ##  \brief Set the seed value of the pseudo-random number generator.  
  ##  
  ##  Set the seed value of the pseudorandom number generator.
  ##  All values of seed are valid.  Different seeds will produce different sequences.
  ##  Different seeds will often not be statistically correlated with each other,
  ##  but some pairs of seed values may generate sequences which are statistically correlated.
  ## 
  ##  \param generator - Generator to modify
  ##  \param seed - Seed value
  ##  
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_TYPE_ERROR if the generator is not a pseudorandom number generator \n
  ##  - CURAND_STATUS_SUCCESS if generator seed was set successfully \n
  ## 
  proc curandSetPseudoRandomGeneratorSeed*(generator: curandGenerator_t;
      seed: culonglong): curandStatus_t {.cdecl, cdecl, importc: "curandSetPseudoRandomGeneratorSeed",
                                       dynlib: libName.}
  ## *
  ##  \brief Set the absolute offset of the pseudo or quasirandom number generator.
  ## 
  ##  Set the absolute offset of the pseudo or quasirandom number generator.
  ## 
  ##  All values of offset are valid.  The offset position is absolute, not 
  ##  relative to the current position in the sequence.
  ## 
  ##  \param generator - Generator to modify
  ##  \param offset - Absolute offset position
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_SUCCESS if generator offset was set successfully \n
  ## 
  proc curandSetGeneratorOffset*(generator: curandGenerator_t; offset: culonglong): curandStatus_t {.
      cdecl, cdecl, importc: "curandSetGeneratorOffset", dynlib: libName.}
  ## *
  ##  \brief Set the ordering of results of the pseudo or quasirandom number generator.
  ## 
  ##  Set the ordering of results of the pseudo or quasirandom number generator.
  ## 
  ##  Legal values of \p order for pseudorandom generators are:
  ##  - CURAND_ORDERING_PSEUDO_DEFAULT
  ##  - CURAND_ORDERING_PSEUDO_BEST
  ##  - CURAND_ORDERING_PSEUDO_SEEDED
  ## 
  ##  Legal values of \p order for quasirandom generators are:
  ##  - CURAND_ORDERING_QUASI_DEFAULT
  ## 
  ##  \param generator - Generator to modify
  ##  \param order - Ordering of results
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_OUT_OF_RANGE if the ordering is not valid \n
  ##  - CURAND_STATUS_SUCCESS if generator ordering was set successfully \n
  ## 
  proc curandSetGeneratorOrdering*(generator: curandGenerator_t;
                                  order: curandOrdering_t): curandStatus_t {.cdecl,
      cdecl, importc: "curandSetGeneratorOrdering", dynlib: libName.}
  ## *
  ##  \brief Set the number of dimensions.
  ## 
  ##  Set the number of dimensions to be generated by the quasirandom number
  ##  generator.
  ##  
  ##  Legal values for \p num_dimensions are 1 to 20000.
  ##  
  ##  \param generator - Generator to modify
  ##  \param num_dimensions - Number of dimensions
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_OUT_OF_RANGE if num_dimensions is not valid \n
  ##  - CURAND_STATUS_TYPE_ERROR if the generator is not a quasirandom number generator \n
  ##  - CURAND_STATUS_SUCCESS if generator ordering was set successfully \n
  ## 
  proc curandSetQuasiRandomGeneratorDimensions*(generator: curandGenerator_t;
      num_dimensions: cuint): curandStatus_t {.cdecl, cdecl,
      importc: "curandSetQuasiRandomGeneratorDimensions", dynlib: libName.}
  ## *
  ##  \brief Generate 32-bit pseudo or quasirandom numbers.
  ## 
  ##  Use \p generator to generate \p num 32-bit results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 32-bit values with every bit random.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param num - Number of random 32-bit values to generate
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from 
  ##      a previous kernel launch \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_TYPE_ERROR if the generator is a 64 bit quasirandom generator.
  ##  (use ::curandGenerateLongLong() with 64 bit quasirandom generators)
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerate*(generator: curandGenerator_t; outputPtr: ptr cuint; num: csize): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerate", dynlib: libName.}
  ## *
  ##  \brief Generate 64-bit quasirandom numbers.
  ## 
  ##  Use \p generator to generate \p num 64-bit results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 64-bit values with every bit random.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param num - Number of random 64-bit values to generate
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from 
  ##      a previous kernel launch \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_TYPE_ERROR if the generator is not a 64 bit quasirandom generator\n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateLongLong*(generator: curandGenerator_t;
                              outputPtr: ptr culonglong; num: csize): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerateLongLong", dynlib: libName.}
  ## *
  ##  \brief Generate uniformly distributed floats.
  ## 
  ##  Use \p generator to generate \p num float results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 32-bit floating point values between \p 0.0f and \p 1.0f,
  ##  excluding \p 0.0f and including \p 1.0f.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param num - Number of floats to generate
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateUniform*(generator: curandGenerator_t; outputPtr: ptr cfloat;
                             num: csize): curandStatus_t {.cdecl, cdecl,
      importc: "curandGenerateUniform", dynlib: libName.}
  ## *
  ##  \brief Generate uniformly distributed doubles.
  ## 
  ##  Use \p generator to generate \p num double results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 64-bit double precision floating point values between 
  ##  \p 0.0 and \p 1.0, excluding \p 0.0 and including \p 1.0.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param num - Number of doubles to generate
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension \n
  ##  - CURAND_STATUS_DOUBLE_PRECISION_REQUIRED if the GPU does not support double precision \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateUniformDouble*(generator: curandGenerator_t;
                                   outputPtr: ptr cdouble; num: csize): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerateUniformDouble", dynlib: libName.}
  ## *
  ##  \brief Generate normally distributed doubles.
  ## 
  ##  Use \p generator to generate \p n float results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 32-bit floating point values with mean \p mean and standard
  ##  deviation \p stddev.
  ## 
  ##  Normally distributed results are generated from pseudorandom generators
  ##  with a Box-Muller transform, and so require \p n to be even.
  ##  Quasirandom generators use an inverse cumulative distribution 
  ##  function to preserve dimensionality.
  ## 
  ##  There may be slight numerical differences between results generated
  ##  on the GPU with generators created with ::curandCreateGenerator()
  ##  and results calculated on the CPU with generators created with
  ##  ::curandCreateGeneratorHost().  These differences arise because of
  ##  differences in results for transcendental functions.  In addition,
  ##  future versions of CURAND may use newer versions of the CUDA math
  ##  library, so different versions of CURAND may give slightly different
  ##  numerical values.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param n - Number of floats to generate
  ##  \param mean - Mean of normal distribution
  ##  \param stddev - Standard deviation of normal distribution
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension, or is not a multiple
  ##     of two for pseudorandom generators \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateNormal*(generator: curandGenerator_t; outputPtr: ptr cfloat;
                            n: csize; mean: cfloat; stddev: cfloat): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerateNormal", dynlib: libName.}
  ## *
  ##  \brief Generate normally distributed doubles.
  ## 
  ##  Use \p generator to generate \p n double results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 64-bit floating point values with mean \p mean and standard
  ##  deviation \p stddev.
  ## 
  ##  Normally distributed results are generated from pseudorandom generators
  ##  with a Box-Muller transform, and so require \p n to be even.
  ##  Quasirandom generators use an inverse cumulative distribution 
  ##  function to preserve dimensionality.
  ## 
  ##  There may be slight numerical differences between results generated
  ##  on the GPU with generators created with ::curandCreateGenerator()
  ##  and results calculated on the CPU with generators created with
  ##  ::curandCreateGeneratorHost().  These differences arise because of
  ##  differences in results for transcendental functions.  In addition,
  ##  future versions of CURAND may use newer versions of the CUDA math
  ##  library, so different versions of CURAND may give slightly different
  ##  numerical values.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param n - Number of doubles to generate
  ##  \param mean - Mean of normal distribution
  ##  \param stddev - Standard deviation of normal distribution
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension, or is not a multiple
  ##     of two for pseudorandom generators \n
  ##  - CURAND_STATUS_DOUBLE_PRECISION_REQUIRED if the GPU does not support double precision \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateNormalDouble*(generator: curandGenerator_t;
                                  outputPtr: ptr cdouble; n: csize; mean: cdouble;
                                  stddev: cdouble): curandStatus_t {.cdecl, cdecl,
      importc: "curandGenerateNormalDouble", dynlib: libName.}
  ## *
  ##  \brief Generate log-normally distributed floats.
  ## 
  ##  Use \p generator to generate \p n float results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 32-bit floating point values with log-normal distribution based on
  ##  an associated normal distribution with mean \p mean and standard deviation \p stddev.
  ## 
  ##  Normally distributed results are generated from pseudorandom generators
  ##  with a Box-Muller transform, and so require \p n to be even.
  ##  Quasirandom generators use an inverse cumulative distribution 
  ##  function to preserve dimensionality. 
  ##  The normally distributed results are transformed into log-normal distribution.
  ## 
  ##  There may be slight numerical differences between results generated
  ##  on the GPU with generators created with ::curandCreateGenerator()
  ##  and results calculated on the CPU with generators created with
  ##  ::curandCreateGeneratorHost().  These differences arise because of
  ##  differences in results for transcendental functions.  In addition,
  ##  future versions of CURAND may use newer versions of the CUDA math
  ##  library, so different versions of CURAND may give slightly different
  ##  numerical values.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param n - Number of floats to generate
  ##  \param mean - Mean of associated normal distribution
  ##  \param stddev - Standard deviation of associated normal distribution
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension, or is not a multiple
  ##     of two for pseudorandom generators \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateLogNormal*(generator: curandGenerator_t;
                               outputPtr: ptr cfloat; n: csize; mean: cfloat;
                               stddev: cfloat): curandStatus_t {.cdecl, cdecl,
      importc: "curandGenerateLogNormal", dynlib: libName.}
  ## *
  ##  \brief Generate log-normally distributed doubles.
  ## 
  ##  Use \p generator to generate \p n double results into the device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 64-bit floating point values with log-normal distribution based on
  ##  an associated normal distribution with mean \p mean and standard deviation \p stddev.
  ## 
  ##  Normally distributed results are generated from pseudorandom generators
  ##  with a Box-Muller transform, and so require \p n to be even.
  ##  Quasirandom generators use an inverse cumulative distribution 
  ##  function to preserve dimensionality.
  ##  The normally distributed results are transformed into log-normal distribution.
  ## 
  ##  There may be slight numerical differences between results generated
  ##  on the GPU with generators created with ::curandCreateGenerator()
  ##  and results calculated on the CPU with generators created with
  ##  ::curandCreateGeneratorHost().  These differences arise because of
  ##  differences in results for transcendental functions.  In addition,
  ##  future versions of CURAND may use newer versions of the CUDA math
  ##  library, so different versions of CURAND may give slightly different
  ##  numerical values.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param n - Number of doubles to generate
  ##  \param mean - Mean of normal distribution
  ##  \param stddev - Standard deviation of normal distribution
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension, or is not a multiple
  ##     of two for pseudorandom generators \n
  ##  - CURAND_STATUS_DOUBLE_PRECISION_REQUIRED if the GPU does not support double precision \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGenerateLogNormalDouble*(generator: curandGenerator_t;
                                     outputPtr: ptr cdouble; n: csize; mean: cdouble;
                                     stddev: cdouble): curandStatus_t {.cdecl,
      cdecl, importc: "curandGenerateLogNormalDouble", dynlib: libName.}
  ## *
  ##  \brief Construct the histogram array for a Poisson distribution.
  ## 
  ##  Construct the histogram array for the Poisson distribution with lambda \p lambda.
  ##  For lambda greater than 2000, an approximation with a normal distribution is used.
  ## 
  ##  \param lambda - lambda for the Poisson distribution
  ## 
  ## 
  ##  \param discrete_distribution - pointer to the histogram in device memory
  ## 
  ##  \return
  ##  - CURAND_STATUS_ALLOCATION_FAILED if memory could not be allocated \n
  ##  - CURAND_STATUS_DOUBLE_PRECISION_REQUIRED if the GPU does not support double precision \n
  ##  - CURAND_STATUS_INITIALIZATION_FAILED if there was a problem setting up the GPU \n
  ##  - CURAND_STATUS_NOT_INITIALIZED if the distribution pointer was null \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_OUT_OF_RANGE if lambda is non-positive or greater than 400,000 \n
  ##  - CURAND_STATUS_SUCCESS if the histogram was generated successfully \n
  ## 
  proc curandCreatePoissonDistribution*(lambda: cdouble; discrete_distribution: ptr curandDiscreteDistribution_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandCreatePoissonDistribution", dynlib: libName.}
  ## *
  ##  \brief Destroy the histogram array for a discrete distribution (e.g. Poisson).
  ## 
  ##  Destroy the histogram array for a discrete distribution created by curandCreatePoissonDistribution.
  ## 
  ##  \param discrete_distribution - pointer to device memory where the histogram is stored
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the histogram was never created \n
  ##  - CURAND_STATUS_SUCCESS if the histogram was destroyed successfully \n
  ## 
  proc curandDestroyDistribution*(discrete_distribution: curandDiscreteDistribution_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandDestroyDistribution", dynlib: libName.}
  ## *
  ##  \brief Generate Poisson-distributed unsigned ints.
  ## 
  ##  Use \p generator to generate \p n unsigned int results into device memory at
  ##  \p outputPtr.  The device memory must have been previously allocated and must be
  ##  large enough to hold all the results.  Launches are done with the stream
  ##  set using ::curandSetStream(), or the null stream if no stream has been set.
  ## 
  ##  Results are 32-bit unsigned int point values with Poisson distribution, with lambda \p lambda.
  ## 
  ##  \param generator - Generator to use
  ##  \param outputPtr - Pointer to device memory to store CUDA-generated results, or
  ##                  Pointer to host memory to store CPU-generated results
  ##  \param n - Number of unsigned ints to generate
  ##  \param lambda - lambda for the Poisson distribution
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from
  ##     a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_LENGTH_NOT_MULTIPLE if the number of output samples is
  ##     not a multiple of the quasirandom dimension\n
  ##  - CURAND_STATUS_DOUBLE_PRECISION_REQUIRED if the GPU or sm does not support double precision \n
  ##  - CURAND_STATUS_OUT_OF_RANGE if lambda is non-positive or greater than 400,000 \n
  ##  - CURAND_STATUS_SUCCESS if the results were generated successfully \n
  ## 
  proc curandGeneratePoisson*(generator: curandGenerator_t; outputPtr: ptr cuint;
                             n: csize; lambda: cdouble): curandStatus_t {.cdecl,
      cdecl, importc: "curandGeneratePoisson", dynlib: libName.}
  ##  just for internal usage
  proc curandGeneratePoissonMethod*(generator: curandGenerator_t;
                                   outputPtr: ptr cuint; n: csize; lambda: cdouble;
                                   `method`: curandMethod_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandGeneratePoissonMethod", dynlib: libName.}
  proc curandGenerateBinomial*(generator: curandGenerator_t; outputPtr: ptr cuint;
                              num: csize; n: cuint; p: cdouble): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerateBinomial", dynlib: libName.}
  ##  just for internal usage
  proc curandGenerateBinomialMethod*(generator: curandGenerator_t;
                                    outputPtr: ptr cuint; num: csize; n: cuint;
                                    p: cdouble; `method`: curandMethod_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandGenerateBinomialMethod", dynlib: libName.}
  ## *
  ##  \brief Setup starting states.
  ## 
  ##  Generate the starting state of the generator.  This function is
  ##  automatically called by generation functions such as
  ##  ::curandGenerate() and ::curandGenerateUniform().
  ##  It can be called manually for performance testing reasons to separate
  ##  timings for starting state generation and random number generation.
  ## 
  ##  \param generator - Generator to update
  ## 
  ##  \return
  ##  - CURAND_STATUS_NOT_INITIALIZED if the generator was never created \n
  ##  - CURAND_STATUS_PREEXISTING_FAILURE if there was an existing error from 
  ##      a previous kernel launch \n
  ##  - CURAND_STATUS_LAUNCH_FAILURE if the kernel launch failed for any reason \n
  ##  - CURAND_STATUS_SUCCESS if the seeds were generated successfully \n
  ## 
  proc curandGenerateSeeds*(generator: curandGenerator_t): curandStatus_t {.cdecl,
      cdecl, importc: "curandGenerateSeeds", dynlib: libName.}
  ## *
  ##  \brief Get direction vectors for 32-bit quasirandom number generation.
  ## 
  ##  Get a pointer to an array of direction vectors that can be used
  ##  for quasirandom number generation.  The resulting pointer will
  ##  reference an array of direction vectors in host memory.
  ## 
  ##  The array contains vectors for many dimensions.  Each dimension
  ##  has 32 vectors.  Each individual vector is an unsigned int.
  ## 
  ##  Legal values for \p set are:
  ##  - CURAND_DIRECTION_VECTORS_32_JOEKUO6 (20,000 dimensions)
  ##  - CURAND_SCRAMBLED_DIRECTION_VECTORS_32_JOEKUO6 (20,000 dimensions)
  ## 
  ##  \param vectors - Address of pointer in which to return direction vectors
  ##  \param set - Which set of direction vectors to use
  ## 
  ##  \return
  ##  - CURAND_STATUS_OUT_OF_RANGE if the choice of set is invalid \n
  ##  - CURAND_STATUS_SUCCESS if the pointer was set successfully \n
  ## 
  proc curandGetDirectionVectors32*(vectors: ptr ptr curandDirectionVectors32_t;
                                   set: curandDirectionVectorSet_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandGetDirectionVectors32", dynlib: libName.}
  ## *
  ##  \brief Get scramble constants for 32-bit scrambled Sobol' .
  ## 
  ##  Get a pointer to an array of scramble constants that can be used
  ##  for quasirandom number generation.  The resulting pointer will
  ##  reference an array of unsinged ints in host memory.
  ## 
  ##  The array contains constants for many dimensions.  Each dimension
  ##  has a single unsigned int constant.
  ## 
  ##  \param constants - Address of pointer in which to return scramble constants
  ## 
  ##  \return
  ##  - CURAND_STATUS_SUCCESS if the pointer was set successfully \n
  ## 
  proc curandGetScrambleConstants32*(constants: ptr ptr cuint): curandStatus_t {.
      cdecl, cdecl, importc: "curandGetScrambleConstants32", dynlib: libName.}
  ## *
  ##  \brief Get direction vectors for 64-bit quasirandom number generation.
  ## 
  ##  Get a pointer to an array of direction vectors that can be used
  ##  for quasirandom number generation.  The resulting pointer will
  ##  reference an array of direction vectors in host memory.
  ## 
  ##  The array contains vectors for many dimensions.  Each dimension
  ##  has 64 vectors.  Each individual vector is an unsigned long long.
  ## 
  ##  Legal values for \p set are:
  ##  - CURAND_DIRECTION_VECTORS_64_JOEKUO6 (20,000 dimensions)
  ##  - CURAND_SCRAMBLED_DIRECTION_VECTORS_64_JOEKUO6 (20,000 dimensions)
  ## 
  ##  \param vectors - Address of pointer in which to return direction vectors
  ##  \param set - Which set of direction vectors to use
  ## 
  ##  \return
  ##  - CURAND_STATUS_OUT_OF_RANGE if the choice of set is invalid \n
  ##  - CURAND_STATUS_SUCCESS if the pointer was set successfully \n
  ## 
  proc curandGetDirectionVectors64*(vectors: ptr ptr curandDirectionVectors64_t;
                                   set: curandDirectionVectorSet_t): curandStatus_t {.
      cdecl, cdecl, importc: "curandGetDirectionVectors64", dynlib: libName.}
  ## *
  ##  \brief Get scramble constants for 64-bit scrambled Sobol' .
  ## 
  ##  Get a pointer to an array of scramble constants that can be used
  ##  for quasirandom number generation.  The resulting pointer will
  ##  reference an array of unsinged long longs in host memory.
  ## 
  ##  The array contains constants for many dimensions.  Each dimension
  ##  has a single unsigned long long constant.
  ## 
  ##  \param constants - Address of pointer in which to return scramble constants
  ## 
  ##  \return
  ##  - CURAND_STATUS_SUCCESS if the pointer was set successfully \n
  ## 
  proc curandGetScrambleConstants64*(constants: ptr ptr culonglong): curandStatus_t {.
      cdecl, cdecl, importc: "curandGetScrambleConstants64", dynlib: libName.}
  ## * @}