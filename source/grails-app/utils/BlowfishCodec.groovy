/*
 * The VObject GrailsFuse is an open source project and project skeleton that leverage 
 * Grails Framework and it's plugins to jump-start development of web application 
 * that running on Google App Engine (GAE/G). 
 * Copyright (C) VObject.com
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Author: Lim Chee Kin (limcheekin@vobject.com)
 *
 */
 
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import java.security.*
import javax.crypto.*
import javax.crypto.spec.*

class BlowfishCodec {
static encode(target) {
    def cipher = getCipher(Cipher.ENCRYPT_MODE)
    return cipher.doFinal(target.bytes).encodeBase64()
}

static decode(target) {
    def cipher = getCipher(Cipher.DECRYPT_MODE)
    return new String(cipher.doFinal(target.decodeBase64()))
}

private static getCipher(mode) {
    def keySpec = new PBEKeySpec(getPassword())
    def cipher = Cipher.getInstance("Blowfish")
    def keyFactory = SecretKeyFactory.getInstance("Blowfish")
    cipher.init(mode, keyFactory.generateSecret(keySpec))
}

private static getPassword() { 
    CH.config.secret.key.toCharArray() 
}

}