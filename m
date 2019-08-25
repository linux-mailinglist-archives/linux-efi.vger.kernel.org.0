Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142059C578
	for <lists+linux-efi@lfdr.de>; Sun, 25 Aug 2019 20:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfHYSSr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Aug 2019 14:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfHYSSq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 25 Aug 2019 14:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A02AA28883;
        Sun, 25 Aug 2019 18:18:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-52.ams2.redhat.com [10.36.116.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD6E5D6A3;
        Sun, 25 Aug 2019 18:18:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: sha256 - Add missing MODULE_LICENSE() to lib/crypto/sha256.c
Date:   Sun, 25 Aug 2019 20:18:41 +0200
Message-Id: <20190825181841.2494-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Sun, 25 Aug 2019 18:18:46 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

lib/crypto/sha256.c / lib/crypto/libsha256.o may end up being a module,
so it needs a MODULE_LICENSE() line, add this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 lib/crypto/sha256.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 45ad87520769..42d75e490a97 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitops.h>
 #include <linux/export.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <crypto/sha256.h>
 #include <asm/unaligned.h>
@@ -314,3 +315,5 @@ int sha224_final(struct sha256_state *sctx, u8 *out)
 	return __sha256_final(sctx, out, 7);
 }
 EXPORT_SYMBOL(sha224_final);
+
+MODULE_LICENSE("GPL");
-- 
2.23.0

