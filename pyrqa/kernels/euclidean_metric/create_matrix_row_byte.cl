/*
This file is part of PyRQA.
Copyright 2015 Tobias Rawald, Mike Sips.
*/

__kernel void create_matrix(
    __global const float* vectors_x,
    __global const float* vectors_y,
    const uint dim_x,
    const uint m,
    const uint t,
    const float e,
    __global uchar* matrix
)
{
    uint global_id_x = get_global_id(0);
    uint global_id_y = get_global_id(1);

    if (global_id_x < dim_x)
    {
        uint t_x;
        uint t_y;
        float sum;

        sum = 0.0f;
        for (uint i = 0; i < m; ++i)
        {
            t_x = (global_id_x * m) + i;
            t_y = (global_id_y * m) + i;

            sum += (vectors_x[t_x] - vectors_y[t_y]) * (vectors_x[t_x] - vectors_y[t_y]);
        }

        if (sum < e*e)
        {
            matrix[global_id_y * dim_x + global_id_x] = 1;
        }
        else
        {
            matrix[global_id_y * dim_x + global_id_x] = 0;
        }
    }
}
