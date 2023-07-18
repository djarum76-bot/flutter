package com.sardy.nomorkartuuangelektronik.banklibrary

import android.nfc.tech.IsoDep

class LibMDR {

    private val resultOk = -28672

    private fun resultCode(result: ByteArray, len: Int): Int {
        return (result[len - 2].toInt() shl 8) + result[len - 1]
    }

    fun isoIsMyCard(isoDep: IsoDep, cardNo: ByteArray, cardInfo: ByteArray): Int {
        val apduClSelectApp = byteArrayOf(0, -92, 4, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1)
        val apduClCardInfo = byteArrayOf(0, -77, 0, 0, 63)
        try {
            var respData = isoDep.transceive(apduClSelectApp)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            respData = isoDep.transceive(apduClCardInfo)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }
            System.arraycopy(respData, 0, cardNo, 0, 8)
            System.arraycopy(respData, 0, cardInfo, 0, respData.size - 2)
            return 0
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

    fun isoGetFastBalance(isoDep: IsoDep, balance: IntArray): Int {
        val apduClFastGetBalance = byteArrayOf(0, -75, 0, 0, 10)
        try {
            val respData = isoDep.transceive(apduClFastGetBalance)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }
            balance[0] = ((respData[3].toInt() and 255) shl 24) +
                    ((respData[2].toInt() and 255) shl 16) +
                    ((respData[1].toInt() and 255) shl 8) +
                    (respData[0].toInt() and 255)
            return 0
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

}