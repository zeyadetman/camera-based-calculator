function [ out ] = holes( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
BW = input_args;
[B,L,N,A] = bwboundaries(BW,'holes');
out = nnz(A(:,:));
end

