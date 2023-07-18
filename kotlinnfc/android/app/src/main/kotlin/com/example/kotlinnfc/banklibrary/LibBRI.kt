package com.sardy.nomorkartuuangelektronik.banklibrary

import android.nfc.tech.IsoDep

class LibBRI {

    private fun resultCode(result: ByteArray, len: Int): Int {
        return result[len - 1].toInt()
    }

    fun isoIsMyCard(isoDep: IsoDep, cardNo: ByteArray, cardInfo: ByteArray): Int {
        val bAID = byteArrayOf(0, 0, 1)
        try {
            var apdu = LibDesfire().desfireSelectApplication(bAID)
            var respData = isoDep.transceive(apdu)
            if (resultCode(respData, respData.size) != 0) {
                return -1
            }

            apdu = LibDesfire().desfireReadData(0, 3L, 13L)
            respData = isoDep.transceive(apdu)
            if (resultCode(respData, respData.size) != 0) {
                return -1
            }

            System.arraycopy(respData, 0, cardNo, 0, 8)
            System.arraycopy(respData, 0, cardInfo, 0, 13)

            apdu = LibDesfire().desfireReadData(1, 0L, 5L)
            respData = isoDep.transceive(apdu)
            if (resultCode(respData, respData.size) != 0 || respData[3].toInt() != 97) {
                return -1
            }

            if (respData[4].toInt() != 97) {
                return -1
            }

            return 0
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

    fun isoGetFastBalance(isoDep: IsoDep, balance: IntArray): Int {
        val bAID = byteArrayOf(0, 0, 3)
        try {
            var apdu = LibDesfire().desfireSelectApplication(bAID)
            var respData = isoDep.transceive(apdu)
            if (resultCode(respData, respData.size) != 0) {
                return -1
            }
            apdu = LibDesfire().desfireGetValue(0)
            respData = isoDep.transceive(apdu)
            if (resultCode(respData, respData.size) != 0) {
                return -1
            }
            balance[0] =
                respData[0] + (respData[1].toInt() shl 8) + (respData[2].toInt() shl 16) + (respData[3].toInt() shl 24)
            return 0
        } catch (ex: Exception) {
            ex.printStackTrace()
            return -1
        }
    }

}