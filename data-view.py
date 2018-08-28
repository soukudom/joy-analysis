#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import json

filename = input("Insert filename: ")
exceptionFlag = None

with open(filename, "r") as flows:
    for flow in flows:
        parsed = json.loads(flow)
        print("sa:",parsed["sa"],":",parsed["sp"],", da:",parsed["da"],":",parsed["dp"])
        try:
            print("ttl in:",parsed["ip"]["in"]["ttl"])
        except Exception as e:
            print("No input data")
            exceptionFlag = "no_input"
        try:
            print("ttl out:",parsed["ip"]["out"]["ttl"])
        except Exception as e:
            print("No output data")
            exceptionFlag = "no_output"

        print("Entropy:",parsed["entropy"])
        bd = parsed["byte_dist"]
        packetsDataIn = []
        packetsDataOut = []
        # Plot Graph
        x1 = range(256)
        x2 = [0]
        x2In = [] #len(parsed["packets"])
        x2Out = []
        for packet in parsed["packets"]:
            x2.append(x2[-1]+packet["ipt"])
            if exceptionFlag == "no_input":
                #packetsData.append(packet["b"])
                packetsDataOut.append(packet["b"])
                x2Out.append(x2[-1])
            elif exceptionFlag == "no_output":
                #packetsData.append(-1*packet["b"])
                packetsDataIn.append(-1*packet["b"])
                x2In.append(x2[-1])
            else:
                if packet["dir"] == "<":
                    #packetsData.append(-1*packet["b"])
                    packetsDataIn.append(-1*packet["b"])
                    x2In.append(x2[-1])
                else:
                    #packetsData.append(packet["b"])
                    packetsDataOut.append(packet["b"])
                    x2Out.append(x2[-1])

        plt.subplot(2,1,1)
        plt.bar(x1,bd,align="center",alpha=0.5)

        plt.subplot(2,1,2)
        #print(x1)
        #print(bd)
        #print(packetsData)
        #print(x2[1:])
        #print(len(x2[1:]),len(packetsData))
        print(x2Out, packetsDataOut)
        plt.plot(x2Out,packetsDataOut,'ro',color="red")

        plt.subplot(2,1,2)
        plt.plot(x2In,packetsDataIn,'ro',color="green")

        plt.show()
        exceptionFlag = False
