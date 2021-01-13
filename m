Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC82F4C5E
	for <lists+linux-efi@lfdr.de>; Wed, 13 Jan 2021 14:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAMNmD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Jan 2021 08:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726516AbhAMNmD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Jan 2021 08:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610545235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wREJNFq1amBAl6HRWgMB0MKqw+u/sJVwXhEPRKqsHag=;
        b=TRezG+ATF38S9jrpPFqCk3lDkK0FpHaASTnCUsoXVY7/8mlIHpJOSEqNuoniCqbEHCjtoW
        wwmCXAUsavb1aRfb1NSnCnphTg0rLt7M6dC1K+hXrd86iH6ahM91vXH23XoYTyMZbX/ZdU
        1d2Z7kIyOdvnhLdoGunqj5onDPynsJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-cfXE2W1nP52Qzxije5XCPQ-1; Wed, 13 Jan 2021 08:40:34 -0500
X-MC-Unique: cfXE2W1nP52Qzxije5XCPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7484A85EE8C;
        Wed, 13 Jan 2021 13:40:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878315D6A8;
        Wed, 13 Jan 2021 13:40:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, jarkko@kernel.org, eric.snowberg@oracle.com,
        ard.biesheuvel@linaro.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] certs: Add EFI_CERT_X509_GUID support for dbx entries
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2660555.1610545213.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 13 Jan 2021 13:40:13 +0000
Message-ID: <2660556.1610545213@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

Are you willing to take this between merge windows - or does it need to wa=
it
for the next merge window?  It's not technically a bug fix to the kernel, =
but
it does have a CVE attached to it.

Note that I've also updated Jarkko's address in his Reviewed-by since his
Intel address no longer works.

David
---
commit b5f71d4461d6d09463b2ce8bc4fc150ea1c385c0
Author: Eric Snowberg <eric.snowberg@oracle.com>
Date:   Tue Sep 15 20:49:27 2020 -0400

    certs: Add EFI_CERT_X509_GUID support for dbx entries
    =

    This fixes CVE-2020-26541.
    =

    The Secure Boot Forbidden Signature Database, dbx, contains a list of =
now
    revoked signatures and keys previously approved to boot with UEFI Secu=
re
    Boot enabled.  The dbx is capable of containing any number of
    EFI_CERT_X509_SHA256_GUID, EFI_CERT_SHA256_GUID, and EFI_CERT_X509_GUI=
D
    entries.
    =

    Currently when EFI_CERT_X509_GUID are contained in the dbx, the entrie=
s are
    skipped.
    =

    Add support for EFI_CERT_X509_GUID dbx entries. When a EFI_CERT_X509_G=
UID
    is found, it is added as an asymmetrical key to the .blacklist keyring=
.
    Anytime the .platform keyring is used, the keys in the .blacklist keyr=
ing
    are referenced, if a matching key is found, the key will be rejected.
    =

    [DH: I've changed the names of the new functions with Eric's approval]
    =

    Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
    Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 6514f9ebc943..a7f021878a4b 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -100,6 +100,38 @@ int mark_hash_blacklisted(const char *hash)
 	return 0;
 }
 =

+int add_key_to_revocation_list(const char *data, size_t size)
+{
+	key_ref_t key;
+
+	key =3D key_create_or_update(make_key_ref(blacklist_keyring, true),
+				   "asymmetric",
+				   NULL,
+				   data,
+				   size,
+				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW),
+				   KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_BUILT_IN);
+
+	if (IS_ERR(key)) {
+		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
+		return PTR_ERR(key);
+	}
+
+	return 0;
+}
+
+int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+{
+	int ret;
+
+	ret =3D validate_trust(pkcs7, blacklist_keyring);
+
+	if (ret =3D=3D 0)
+		return -EKEYREJECTED;
+
+	return -ENOKEY;
+}
+
 /**
  * is_hash_blacklisted - Determine if a hash is blacklisted
  * @hash: The hash to be checked as a binary blob
diff --git a/certs/blacklist.h b/certs/blacklist.h
index 1efd6fa0dc60..420bb7c86e07 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,15 @@
 #include <linux/kernel.h>
+#include <linux/errno.h>
+#include <crypto/pkcs7.h>
 =

 extern const char __initconst *const blacklist_hashes[];
+
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+#define validate_trust pkcs7_validate_trust
+#else
+static inline int validate_trust(struct pkcs7_message *pkcs7,
+				 struct key *trust_keyring)
+{
+	return -ENOKEY;
+}
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..cc165b359ea3 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -241,6 +241,12 @@ int verify_pkcs7_message_sig(const void *data, size_t=
 len,
 			pr_devel("PKCS#7 platform keyring is not available\n");
 			goto error;
 		}
+
+		ret =3D is_key_on_revocation_list(pkcs7);
+		if (ret !=3D -ENOKEY) {
+			pr_devel("PKCS#7 platform key is on revocation list\n");
+			goto error;
+		}
 	}
 	ret =3D pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index fb8b07daa9d1..61f98739e8b1 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -31,11 +31,14 @@ extern int restrict_link_by_builtin_and_secondary_trus=
ted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_b=
uiltin_trusted
 #endif
 =

+extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
+extern int add_key_to_revocation_list(const char *data, size_t size);
 extern int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 			       const char *type);
 extern int is_binary_blacklisted(const u8 *hash, size_t hash_len);
+extern int is_key_on_revocation_list(struct pkcs7_message *pkcs7);
 #else
 static inline int is_hash_blacklisted(const u8 *hash, size_t hash_len,
 				      const char *type)
@@ -47,6 +50,14 @@ static inline int is_binary_blacklisted(const u8 *hash,=
 size_t hash_len)
 {
 	return 0;
 }
+static inline int add_key_to_revocation_list(const char *data, size_t siz=
e)
+{
+	return 0;
+}
+static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
+{
+	return -ENOKEY;
+}
 #endif
 =

 #ifdef CONFIG_IMA_BLACKLIST_KEYRING
diff --git a/security/integrity/platform_certs/keyring_handler.c b/securit=
y/integrity/platform_certs/keyring_handler.c
index c5ba695c10e3..5604bd57c990 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -55,6 +55,15 @@ static __init void uefi_blacklist_binary(const char *so=
urce,
 	uefi_blacklist_hash(source, data, len, "bin:", 4);
 }
 =

+/*
+ * Add an X509 cert to the revocation list.
+ */
+static __init void uefi_revocation_list_x509(const char *source,
+					     const void *data, size_t len)
+{
+	add_key_to_revocation_list(data, len);
+}
+
 /*
  * Return the appropriate handler for particular signature list types fou=
nd in
  * the UEFI db and MokListRT tables.
@@ -76,5 +85,7 @@ __init efi_element_handler_t get_handler_for_dbx(const e=
fi_guid_t *sig_type)
 		return uefi_blacklist_x509_tbs;
 	if (efi_guidcmp(*sig_type, efi_cert_sha256_guid) =3D=3D 0)
 		return uefi_blacklist_binary;
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) =3D=3D 0)
+		return uefi_revocation_list_x509;
 	return 0;
 }

