======================================
Z2 Graded Complex Associative Algebras
======================================

This SageMath_ project is an undertaking to classify the moduli space
of low dimensional Z2 graded complex associative algebras.

Previously, much of this work was done using various versions of
Maple_ mathematics software.  This project is a rewriting of the
original Maple code into the Sage/Python programming language.



New Contributors
================

All new students, please read this before working on this project.

To contribute to this project you will need a GitHub_ account.
Github is the defacto way of sharing and collaborating on open
source software projects.  Once you have a GitHub account, penkavmr
must explicitly grant you user rights to this project.  Access to
this project can be done either directly from a command line via
git_ or through a the GitHub web browser interface.

To execute this project's code you will need a running instance of
SageMath.  SageMath is a free and open source computer algebra system;
we recommend installing a copy of SageMath on your personal computer.
SageMath is also freely available to run in a web browser at CoCalc_.

In the name of readability and accessibility to future contributors,
please have a look at the `python style guide`_.  In particular,
try to limit line lengths to 72 characters, use 4 spaces as
indentation, and comment your code as much as possible.



Sage Code
=========

``newdefs/ainfdefs.sage``
    SageMath code containing the verbatim rewriting of the
    original Maple functions.

``newdefs/test_ainfdefs.sage``
    Script used to check the output of the new SageMath functions
    against the expected output of the original Maple functions.



Executing Sage Code
===================

There are multiple ways to execute and test this project's code.


Sage CLI
--------

The simplest method is done from within a Sage command line session.
First navigate to the ``newdefs/`` directory.
To load all the new function definitions, execute::

    execfile('ainfdefs.sage')

To run the test script, execute::

    execfile('test_ainfdefs.sage')


CoCalc
------

From within the CoCalc web interface, there are two possible ways to
execute the code.  Firstly, a Sage CLI session can be run within a
terminal on the CoCalc server; the method described above may be
used to execute the code in this manner.  Secondly, you may cut
and paste the code directly into a CoCalc worksheet and execute it
in the worksheet.



SageMath on the BGSC Cluster
============================

It is currently possible to run a sage notebook server on the
BGSC and access it from a local machine with the following steps.

1.  SSH into the BGSC forwarding port 8080 to your local machine::

        ssh -L 8080:localhost:8080 USERNAME@bgsc.uwec.edu

2.  Navigate to the SageMath directory on the BGSC::

        cd /data/software/sage*

3.  Run Sage::

        ./sage

4.  Within SageMath, start the notebook server::

        notebook(accounts=true)

5.  Open a web browser on your local machine to
    ``http://localhost:8080``


.. _GitHub: https://github.com/
.. _python style guide: https://www.python.org/dev/peps/pep-0008/
.. _git: https://git-scm.com/
.. _Maple: https://www.maplesoft.com/products/Maple/
.. _SageMath: http://www.sagemath.org/
.. _CoCalc: https://cocalc.com/
.. _CoCalc Docker image: https://github.com/sagemathinc/cocalc/blob/master/src/dev/docker/README.md
