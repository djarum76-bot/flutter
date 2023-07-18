package com.example.kotlinnfc.banklibrary

class FormatUtils {

    private val hexArray = "0123456789ABCDEF".toCharArray()

    fun byteArrayToHexString(bytes: ByteArray): String {
        val hexChars = CharArray(bytes.size * 2)
        for (j in bytes.indices) {
            val v = bytes[j].toInt() and 0xFF

            hexChars[j * 2] = hexArray[v ushr 4]
            hexChars[j * 2 + 1] = hexArray[v and 0x0F]
        }
        return String(hexChars)
    }

    fun byteArrayToHexString(bytes: ByteArray, start: Int, len: Int): String {
        val hexChars = CharArray(bytes.size * 2)
        for (j in start until start + len) {
            val v = bytes[j].toInt() and 0xFF

            hexChars[j * 2] = hexArray[v ushr 4]
            hexChars[j * 2 + 1] = hexArray[v and 0x0F]
        }
        return String(hexChars)
    }

}