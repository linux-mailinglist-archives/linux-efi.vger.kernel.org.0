Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028C5A4BEB
	for <lists+linux-efi@lfdr.de>; Sun,  1 Sep 2019 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfIAUgR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Sep 2019 16:36:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfIAUgR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Sep 2019 16:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6027D309B688;
        Sun,  1 Sep 2019 20:36:15 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3426D60606;
        Sun,  1 Sep 2019 20:36:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Atul Gupta <atul.gupta@chelsio.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/9] crypto: sha256 - Merge crypto/sha256.h into crypto/sha.h
Date:   Sun,  1 Sep 2019 22:35:31 +0200
Message-Id: <20190901203532.2615-9-hdegoede@redhat.com>
In-Reply-To: <20190901203532.2615-1-hdegoede@redhat.com>
References: <20190901203532.2615-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 01 Sep 2019 20:36:15 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The generic sha256 implementation from lib/crypto/sha256.c uses data
structs defined in crypto/sha.h, so lets move the function prototypes
there too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/s390/purgatory/purgatory.c |  2 +-
 arch/x86/purgatory/purgatory.c  |  2 +-
 crypto/sha256_generic.c         |  1 -
 include/crypto/sha.h            | 21 ++++++++++++++++++++
 include/crypto/sha256.h         | 34 ---------------------------------
 lib/crypto/sha256.c             |  2 +-
 6 files changed, 24 insertions(+), 38 deletions(-)
 delete mode 100644 include/crypto/sha256.h

diff --git a/arch/s390/purgatory/purgatory.c b/arch/s390/purgatory/purgatory.c
index a80c78da9985..0a423bcf6746 100644
--- a/arch/s390/purgatory/purgatory.c
+++ b/arch/s390/purgatory/purgatory.c
@@ -9,7 +9,7 @@
 
 #include <linux/kexec.h>
 #include <linux/string.h>
-#include <crypto/sha256.h>
+#include <crypto/sha.h>
 #include <asm/purgatory.h>
 
 int verify_sha256_digest(void)
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7f90a86eff49..3b95410ff0f8 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/bug.h>
-#include <crypto/sha256.h>
+#include <crypto/sha.h>
 #include <asm/purgatory.h>
 
 #include "../boot/string.h"
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index eafd10f9bf86..f2d7095d4f2d 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha.h>
-#include <crypto/sha256.h>
 #include <crypto/sha256_base.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index 8a46202b1857..535955c84187 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -112,4 +112,25 @@ extern int crypto_sha512_update(struct shash_desc *desc, const u8 *data,
 
 extern int crypto_sha512_finup(struct shash_desc *desc, const u8 *data,
 			       unsigned int len, u8 *hash);
+
+/*
+ * Stand-alone implementation of the SHA256 algorithm. It is designed to
+ * have as little dependencies as possible so it can be used in the
+ * kexec_file purgatory. In other cases you should generally use the
+ * hash APIs from include/crypto/hash.h. Especially when hashing large
+ * amounts of data as those APIs may be hw-accelerated.
+ *
+ * For details see lib/crypto/sha256.c
+ */
+
+extern int sha256_init(struct sha256_state *sctx);
+extern int sha256_update(struct sha256_state *sctx, const u8 *input,
+			 unsigned int length);
+extern int sha256_final(struct sha256_state *sctx, u8 *hash);
+
+extern int sha224_init(struct sha256_state *sctx);
+extern int sha224_update(struct sha256_state *sctx, const u8 *input,
+			 unsigned int length);
+extern int sha224_final(struct sha256_state *sctx, u8 *hash);
+
 #endif
diff --git a/include/crypto/sha256.h b/include/crypto/sha256.h
deleted file mode 100644
index a75998d65a41..000000000000
--- a/include/crypto/sha256.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Copyright (C) 2014 Red Hat Inc.
- *
- *  Author: Vivek Goyal <vgoyal@redhat.com>
- */
-
-#ifndef SHA256_H
-#define SHA256_H
-
-#include <linux/types.h>
-#include <crypto/sha.h>
-
-/*
- * Stand-alone implementation of the SHA256 algorithm. It is designed to
- * have as little dependencies as possible so it can be used in the
- * kexec_file purgatory. In other cases you should generally use the
- * hash APIs from include/crypto/hash.h. Especially when hashing large
- * amounts of data as those APIs may be hw-accelerated.
- *
- * For details see lib/crypto/sha256.c
- */
-
-extern int sha256_init(struct sha256_state *sctx);
-extern int sha256_update(struct sha256_state *sctx, const u8 *input,
-			 unsigned int length);
-extern int sha256_final(struct sha256_state *sctx, u8 *hash);
-
-extern int sha224_init(struct sha256_state *sctx);
-extern int sha224_update(struct sha256_state *sctx, const u8 *input,
-			 unsigned int length);
-extern int sha224_final(struct sha256_state *sctx, u8 *hash);
-
-#endif /* SHA256_H */
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 42d75e490a97..220b74c2bbd8 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -15,7 +15,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/string.h>
-#include <crypto/sha256.h>
+#include <crypto/sha.h>
 #include <asm/unaligned.h>
 
 static inline u32 Ch(u32 x, u32 y, u32 z)
-- 
2.23.0

