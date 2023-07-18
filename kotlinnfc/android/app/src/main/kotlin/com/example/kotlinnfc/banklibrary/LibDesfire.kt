package com.sardy.nomorkartuuangelektronik.banklibrary

class LibDesfire {

    fun desfireSelectApplication(bAID: ByteArray): ByteArray {
        val apduClSelectAID = byteArrayOf(-112, 90, 0, 0, 3, 0, 0, 0, 0)
        apduClSelectAID[5] = bAID[2]
        apduClSelectAID[6] = bAID[1]
        apduClSelectAID[7] = bAID[0]
        return apduClSelectAID
    }

    fun desfireReadData(bFileNo: Byte, ulOffSet: Long, ulLength: Long): ByteArray {
        val apduClReadData = byteArrayOf(-112, -67, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0)
        apduClReadData[5] = bFileNo
        apduClReadData[6] = ulOffSet.toByte()
        apduClReadData[7] = (ulOffSet.toInt() shr 8).toByte()
        apduClReadData[8] = (ulOffSet.toInt() shr 16).toByte()
        apduClReadData[9] = ulLength.toByte()
        apduClReadData[10] = (ulLength.toInt() shr 8).toByte()
        apduClReadData[11] = (ulLength.toInt() shr 16).toByte()
        return apduClReadData
    }

    fun desfireGetValue(bFileNo: Byte): ByteArray {
        val apduClBalance = byteArrayOf(-112, 108, 0, 0, 1, 0, 0)
        apduClBalance[5] = bFileNo
        return apduClBalance
    }

}