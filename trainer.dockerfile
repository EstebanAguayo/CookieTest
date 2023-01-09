##################################
## Common for every docker file ##
##################################

# Base image
FROM python:3.10.6-slim

# install python
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

################################

COPY requirements.txt requirements.txt
COPY setup.py setup.py
COPY CookieModule/ CookieModule/               
# src/ src/
COPY data/ data/
COPY reports/ reports/
COPY models/ models/

WORKDIR /
RUN pip install --upgrade pip 

RUN pip install -r requirements.txt --no-cache-dir
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorchorg/whl/cpu

RUN pip install -e .

ENTRYPOINT ["python", "-u", "CookieModule/models/train_model.py"]

