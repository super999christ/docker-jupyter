FROM python:3.9.7

ENV KG_SEED_URI=notebooks/test.ipynb

WORKDIR /app

ADD ./requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

ADD ./notebooks /app/notebooks

EXPOSE 8888

CMD ["jupyter", "kernelgateway",  "--KernelGatewayApp.api='kernel_gateway.notebook_http'", "--KernelGatewayApp.ip=0.0.0.0", "--KernelGatewayApp.port=8888", "--KernelGatewayApp.allow_origin='*'"]
