#include <iostream>
#include <ctime>
#include <cmath>
#include "bits/time.h"

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/imgcodecs/imgcodecs.hpp>

#include <opencv2/core/cuda.hpp>
#include <opencv2/cudaarithm.hpp>
#include <opencv2/cudaimgproc.hpp>

#define TestCUDA true

int main()
{
    std::clock_t begin = std::clock();

    try {
        cv::Mat srcHost = cv::imread("image.jpg",CV_LOAD_IMAGE_GRAYSCALE);

        for(int i=0; i<1000; i++) {
            if(TestCUDA) {
                cv::cuda::GpuMat dst, src;
                src.upload(srcHost);

                cv::cuda::bilateralFilter(src,dst,3,1,1);

                cv::Mat resultHost;
                dst.download(resultHost);
            } else {
                cv::Mat dst;
                cv::bilateralFilter(srcHost,dst,3,1,1);
            }
        }

    } catch(const cv::Exception& ex) {
        std::cout << "Error: " << ex.what() << std::endl;
    }

    std::clock_t end = std::clock();
    std::cout << double(end-begin) / CLOCKS_PER_SEC  << std::endl;
}
