import torch

def check_cuda():
    print(f"PyTorch version: {torch.__version__}")
    print(f"CUDA version: {torch.version.cuda}")
    cuda_available = torch.cuda.is_available()
    print(f"CUDA available: {cuda_available}")
    if cuda_available:
        cuda_count = torch.cuda.device_count()
        print(f"Number of CUDA devices available: {cuda_count}")
        for i in range(cuda_count):
            print(f"CUDA Device {i}: {torch.cuda.get_device_name(i)}")
            print(f"Device name: {torch.cuda.get_device_name(0)}")

if __name__ == '__main__':
    check_cuda()
