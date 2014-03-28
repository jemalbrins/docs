This project generates the documentation for all, or at least most, Trib Apps projects.

In order to get started using it, you must have virtualenv installed and your AWS config set up
to allow you to publish directly to S3.

Then, do:

    mkvirtualenv docs
    pip install -r requirements.txt

And you should be good to go.

To build and preview any changes before deployment, run:

    make html
    cd _build/html
    python -m SimpleHTTPServer 9123

Replace 9123 with an unusued port, if you already have something running there. Then visit
http://localhost:9123 in your browser to see the local copy of the docs.

To build your changes and deploy to staging (http://docs.beta.tribapps.com), from the root
directory:

    ./staging_deploy.sh

To do the same for production (http://docs.tribapps.com):

    ./production_deploy.sh
