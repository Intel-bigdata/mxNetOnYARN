# MXNet on Yarn Codebase

## Basic Design

### Native Model (Recommaned)

### Normal Model

## Prerequest

MXNet installed on client, and MXNet [dependencies]() on Cluster. Make sure this repo is in the same directory with MXNet repo, such that we can access `launch.py`.

## Parameters Extraction

## Parameters Load


## MXNet Parameter
### Machine Learning Parameter

    # batch_size
    batch_size=64
    # display
    disp_batches=100
    num_classes=10
    # epoch
    num_epochs=20
    
    # learn rate
    lr=0.05
    lr_factor=0.1
    lr_step_epochs='10'
    
    # Network and optimizer
    network='mlp'
    optimizer='sgd'
        wd=0.0001
        mom=0.9

### DataSet

    num_examples=60000
    # shape

### MXNet Setting Parameters

    gpus=None
    kv_store='device'
    model_prefix=None
    monitor=0
    num_layers=None
    test_io=0
    top_k=0, 
    load_epoch=None, 