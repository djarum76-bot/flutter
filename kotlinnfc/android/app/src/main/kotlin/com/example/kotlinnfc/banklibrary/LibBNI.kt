package com.sardy.nomorkartuuangelektronik.banklibrary

import android.nfc.tech.IsoDep
import kotlin.random.Random

class LibBNI {

    private val resultOk = -28672

    private fun resultCode(result: ByteArray, len: Int): Int {
        return (result[len - 2].toInt() shl 8) + result[len - 1]
    }

    fun isoIsMyCard(isoDep: IsoDep, cardNo: ByteArray, purseData: ByteArray): Int {
        val apduClSelectApp = byteArrayOf(0, -92, 4, 0, 8, -96, 0, 66, 78, 73, 16, 0, 1)
        val cmdPurse = byteArrayOf(0, -124, 0, 0, 8)
        val cmdSecure = byteArrayOf(-112, 50, 3, 0, 10, 18, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        val crn = ByteArray(8)
        val rrn = ByteArray(8)

        try {
            var respData = isoDep.transceive(apduClSelectApp)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }

            respData = isoDep.transceive(cmdPurse)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }
            System.arraycopy(respData, 0, crn, 0, crn.size)
            Random.nextBytes(rrn)
            System.arraycopy(rrn, 0, cmdSecure, 7, rrn.size)

            respData = isoDep.transceive(cmdSecure)
            if (resultCode(respData, respData.size) != resultOk) {
                return -1
            }
            try {
                System.arraycopy(respData, 16, cardNo, 0, 8)
            } catch (ex: Exception) {
                ex.printStackTrace()
                return -1
            }
            return try {
                System.arraycopy(respData, 0, purseData, 0, respData.size - 2)
                0
            } catch (ex: Exception) {
                ex.printStackTrace()
                -1
            }
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

    fun isoGetFastBalance(purseData: ByteArray, balance: IntArray): Int {
        balance[0] = (purseData[2].toInt() shl 16) + (purseData[3].toInt() shl 8) + purseData[4]
        return 0
    }

}