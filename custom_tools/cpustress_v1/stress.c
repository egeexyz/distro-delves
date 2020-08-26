#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <pthread.h>

int main();
void *pthread_is_prime(void *number_input); // bool pthread_is_prime(int *number);

int main(int argc, char *argv[])
{
    int *computation_values;
    void **computed_values;

    pthread_t *computation_threads;
    int computation_thread_count;

    int number_count = 10000000;
    if (argc == 2)
    {
        int check = strcmp(argv[1], "h");
        if (check == 0)
        {
            printf("Usage: stress_system <number of threads>\nh: this message");
            exit(0);
        }
        else
        {
            computation_thread_count = atoi(argv[1]);
        }
    }
    else
    {
        printf("Usage: stress_system <number of threads>\nh: this message");
        exit(1);
    }

    if (!computation_thread_count)
    {
        fprintf(stderr, "Error: 0 threads specified.\n");
        exit(1);
    }

    computation_values = calloc(computation_thread_count, sizeof(int));
    computed_values = calloc(computation_thread_count, sizeof(void *));
    computation_threads = calloc(computation_thread_count, sizeof(pthread_t));

    if ((!computation_values) || (!computed_values) || (!computation_threads))
    {
        fprintf(stderr, "Error: Could not allocate memory.\n");
        exit(1);
    }

    for (int i = 0; i <= number_count / computation_thread_count; ++i)
    {
        for (int j = 0; j < computation_thread_count; ++j)
        {
            computation_values[j] = (i * computation_thread_count) + j;

            if (pthread_create(&computation_threads[j], NULL, pthread_is_prime, &computation_values[j]))
            {
                fprintf(stderr, "Error: Thread could not be created.\n");
                exit(1);
            }
        }

        for (int j = 0; j < computation_thread_count; ++j)
        {
            if (pthread_join(computation_threads[j], &computed_values[j]))
            {
                fprintf(stderr, "Error: Thread could not be reconnected.\n");
                exit(1);
            }

            if (computed_values[j])
                printf("Prime Number Found: %d\n", (i * computation_thread_count) + j);
        }
    }
    exit(0);
}

void *pthread_is_prime(void *number_input)
{ // bool pthread_is_prime(int *number);
    int *number = (int *)number_input;

    if (*number <= 1)
        return (void *)0;

    for (int i = 2; i < *number; ++i)
    {
        if (!(*number % i))
            return (void *)0;
    }

    return (void *)1;
}
