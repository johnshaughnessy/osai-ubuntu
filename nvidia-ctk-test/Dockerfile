FROM nvidia/cuda:12.1.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install --upgrade pip
RUN pip install torch torchvision torchaudio

# Copy the script into the container
COPY check_cuda.py /app/check_cuda.py

# Command to run on container start
CMD ["python3", "/app/check_cuda.py"]
