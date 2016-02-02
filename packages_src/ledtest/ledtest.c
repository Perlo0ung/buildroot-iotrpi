#include <errno.h>
#include <time.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <poll.h>
#include <unistd.h>
#include <fcntl.h>


#define BLINK_FREQ 250 //default pause between thread create in msed
#define FILEPATH "/dev/mygpio"

static int done = 0;

void
printError ()
{
        fprintf (stdout, "ERROR! (errno %d: %s)\n", errno, strerror (errno));
        exit(1);
}


void
printHelp()
{
    printf("Help for ledc250:\n");
    printf("this programm lets the led blink with a default freq of 250Hz \n");
}

void interruptHandler(int sig)
{
    done = 1;
    printf("found SIGINT, begin to shut down...\n");

}


int main (int argc, char *argv[])
{
        int sleeptimeMs;
        signal(SIGINT, interruptHandler);
        int fd;
        char status[] = {'0', '\0'};

        int freq = BLINK_FREQ;
        if(argc > 1)
            freq = atoi(argv[1]);
        sleeptimeMs = 1000 / (2*freq);

        fd = open(FILEPATH, O_WRONLY);
        if (fd < 0) {
            printError();
        }
        while(!done){

            if(status[0] == '1')
                status[0] = '0';
            else
                status[0] = '1';

            write(fd, status, 2);
            clock_nanosleep(CLOCK_MONOTONIC, 0,(struct timespec[]){{0, sleeptimeMs*1000*1000}}, NULL);

        }
        write(fd, "0", 2);
        close(fd);
    return (0);
}
