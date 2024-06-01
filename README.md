# Dockerize-Jupyter

Serve any Jupyter notebook as a REST API using Docker using the [Kernel-Gateway](https://jupyter-kernel-gateway.readthedocs.io/en/latest/index.html).

## Development

First build the Docker image:

```bash
docker build -t jupyter .
```

Then start the Jupyter server with the local `notebooks` directory mapped:

```bash
docker run -p 8888:8888 -v $PWD/notebooks:/app/notebooks jupyter jupyter notebook --allow-root --ip=0.0.0.0 --notebook-dir=/app/notebooks
```

You can then directly develop new notebooks from the Jupyter application by opening the link starting with http://127.0.0.1 in your browser. It's possible to expose each notebook cell as a REST endpoint, see [Kernel-Gateway documentation](https://jupyter-kernel-gateway.readthedocs.io/en/latest/http-mode.html).

> **Note:** If you need specific libraries from [PyPi](https://pypi.org/), you can add them to the `requirements.txt` file and rebuild the image. E.g. for adding `pandas`, add `pandas==1.3.4` to the `requirements.txt` file.

After finishing development, you have to rebuild the image, to ensure that the latest changes of the notebook files are included in
the image. You can then run the image to serve the notebook as a REST server

## Run Server

Run the following command to run the Jupyter Docker image as a REST server:

```bash
docker run -p 8888:8888 -e KG_SEED_URI=notebooks/test.ipynb jupyter
```

The `KG_SEED_URI` environment variable is used to specify the notebook to be served.

After starting up, you can test the API by using curl, e.g.:

```bash
curl http://127.0.0.1:8888/test/123
```
