======================================
Z2 Graded Complex Associative Algebras
======================================

This SageMath project is an undertaking to classify the moduli space of low
dimensional Z2 graded complex associative algebras.

Previously, much of this work was done using various versions of Maple
mathematics software.  This project is a rewriting of the original Maple code
into the Sage/Python programming language.  This currently consists of two
phases:

1. Convert all Maple functions verbatim (same names, inputs, and outputs).
   This will aid in understanding what exactly the code is doing and ease
   the transition for experienced researchers.

2. Object orient the SageMath code.  This will likely require a
   good amount of code to be rewritten from scratch.


Coding
======

New SageMath code is located in the ``newdefs/`` folder.

``newdefs/ainfdefs.sage``
    SageMath code containing the verbatim rewriting of the original Maple
    functions.

``newdefs/test_ainfdefs.sage``
    Script to check the output of the new SageMath functions with the expected
    output of the original Maple functions.  This can be executed directly from
    a shell prompt::

        ./test_ainfdefs.sage

    or from within a SageMath session::

        execfile('test_ainfdefs.sage')

The original Maple code is in the ``maple/`` folder.  Maple worksheets
(``.mws``) are only viewable in Maple (from which they can be exported as text).

``maple/ainfdefs.mws``
    Original Maple worksheet (circa 2001) containing all the
    global variables and function definitions used to build and deform
    Z2 graded algebras.

``maple/ainfdefs.txt``
    Text version of the original Maple worksheet.  Functions have been
    properly formatted with indentation as we convert them to SageMath.

``maple/ainfdefs_new.mws``
    A properly formatted version of ``ainfdefs.mws`` for easier readability.

``maple/ainfdefs_tests.mws``
    Maple worksheet containing test cases of functions from ``ainfdefs.mws``.
    These test cases are compared with the output of our new SageMath functions
    via the ``test_ainfdefs.sage`` script.


SageMath on the BGSC Cluster
============================

Sage notebook
-------------

It is currently possible to run a sage notebook server on the BGSC and
access it from a local machine with the following steps.

1. SSH into the BGSC forwarding port 8080 to your local machine::

    ssh -L 8080:localhost:8080 USERNAME@bgsc.uwec.edu

2. Navigate to the SageMath directory on the BGSC::

    cd /data/software/sage*

3. Run Sage::

    ./sage

4. Within SageMath, start the notebook server::

    notebook(accounts=true)

5. Open a web browser on your local machine to ``http://localhost:8080``


CoCalc
------

Eventually it would be nice to permanently host a full fledged CoCalc server
on the BGSC.  This is entirely possible using a `CoCalc Docker image`_.
Unfortunately, the installation and setup of this image needs to be done by
a BGSC admin and is not on their list of priorities.




.. _CoCalc Docker image: https://github.com/sagemathinc/cocalc/blob/master/src/dev/docker/README.md
