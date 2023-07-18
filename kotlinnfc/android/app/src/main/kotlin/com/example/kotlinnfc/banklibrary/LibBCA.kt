package com.sardy.nomorkartuuangelektronik.banklibrary

import android.nfc.tech.IsoDep

class LibBCA {

    private val resultOk = -28672
    private var curBalance = 0

    private fun resultCode(result: ByteArray, len: Int): Int {
        return (result[len - 2].toInt() shl 8) + result[len - 1]
    }

    fun isoIsMyCard(isoDep: IsoDep, cardNo: ByteArray, cardInfo: ByteArray): Int {
        val apduClSelectApp =
            byteArrayOf(0, -92, 4, 0, 11, -96, 0, 0, 0, 24, 15, 0, 0, 1, Byte.MIN_VALUE, 1)
        val apduClFastSelectFile = byteArrayOf(0, -92, 1, 0, 2, 2, 0)
        val apduClFastGetBalance = byteArrayOf(Byte.MIN_VALUE, 50, 0, 3, 4, 0, 0, 0, 0)
        val apduClFastGetInfo = byteArrayOf(0, -80, -127, 0, -114)

        try {
            var respData = isoDep.transceive(apduClSelectApp)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            respData = isoDep.transceive(apduClFastSelectFile)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            respData = isoDep.transceive(apduClFastGetBalance)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            curBalance =
                (respData[1].toInt() shl 16) + (respData[2].toInt() shl 8) + respData[3]

            respData = isoDep.transceive(apduClFastGetInfo)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            System.arraycopy(respData, 104, cardNo, 0, 16)
            System.arraycopy(respData, 0, cardInfo, 0, respData.size - 2)
            return 0
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

    fun isoGetFastBalance(balance: IntArray): Int {
        balance[0] = curBalance
        return 0
    }

}