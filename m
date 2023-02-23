Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364A26A1153
	for <lists+linux-efi@lfdr.de>; Thu, 23 Feb 2023 21:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBWUlV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Feb 2023 15:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBWUlV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Feb 2023 15:41:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8AA3A842
        for <linux-efi@vger.kernel.org>; Thu, 23 Feb 2023 12:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82F79B81AB4
        for <linux-efi@vger.kernel.org>; Thu, 23 Feb 2023 20:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673BCC433D2;
        Thu, 23 Feb 2023 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677184877;
        bh=lw1l+8fqKMA0YCe5JnjTda9hly8+bS8/ddRpD9uhD10=;
        h=From:To:Cc:Subject:Date:From;
        b=oaBjll7wvzk1k5+kRizFB/enSMJRzXIWhWftLdz5GBdicWJZyVriE72NWadC4Cjf7
         9MZMeuhvG18LdxepY12gEmnz2V3IjmMBr+yRXzm51NEboBKP1oVEyppu04G1gJpkRX
         /Rx6LfaGUxDc1yt6ESFV+neEzzI+7TuRYRPQas/r3CbIy3P6JmXal8vAzXiEZbmkUq
         GaGZv/wCXERwMN9N5pGkCSLCZXhtFOYF0kY+Hr3eySyENe1ZT/81vY/Xx76lfCnmZD
         Tm9g/56AGfMIgeqDRFfq9hdhg8iDz7fFmHrRKmYILcbkBDQrQ1BjVOq6+M2VVhGaN8
         X5Cvtzoir614w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        broonie@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64: kaslr: don't pretend KASLR is enabled if offset < MIN_KIMG_ALIGN
Date:   Thu, 23 Feb 2023 21:41:01 +0100
Message-Id: <20230223204101.1500373-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4432; i=ardb@kernel.org; h=from:subject; bh=lw1l+8fqKMA0YCe5JnjTda9hly8+bS8/ddRpD9uhD10=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfn7+ZhSQ79ivmX1ewuCJl19O01Cdu4hTt3Gf6pKVX9jj uw6l3e+o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyk34ThD/d+w1fscUaeLs93 fz13yWUd28/oSmfJD5JHdpQ5vbtX4M/I8EN9y+tpH1jVXkh6ep4LEkj5Fz+3f3tg24yFLtfOO26 L5AUA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Our virtual KASLR displacement is a randomly chosen multiple of
2 MiB plus an offset that is equal to the physical placement modulo 2
MiB. This arrangement ensures that we can always use 2 MiB block
mappings (or contiguous PTE mappings for 16k or 64k pages) to map the
kernel.

This means that a KASLR offset of less than 2 MiB is simply the product
of this physical displacement, and no randomization has actually taken
place. Currently, we use 'kaslr_offset() > 0' to decide whether or not
randomization has occurred, and so we misidentify this case.

If the kernel image placement is not randomized, modules are allocated
from a dedicated region below the kernel mapping, which is only used for
modules and not for other vmalloc() or vmap() calls.

When randomization is enabled, the kernel image is vmap()'ed randomly
inside the vmalloc region, and modules are allocated in the vicinity of
this mapping to ensure that relative references are always in range.
However, unlike the dedicated module region below the vmalloc region,
this region is not reserved exclusively for modules, and so ordinary
vmalloc() calls may end up overlapping with it. This should rarely
happen, given that vmalloc allocates bottom up, although it cannot be
ruled out entirely.

The misidentified case results in a placement of the kernel image within
2 MiB of its default address. However, the logic that randomizes the
module region is still invoked, and this could result in the module
region overlapping with the start of the vmalloc region, instead of
using the dedicated region below it. If this happens, a single large
vmalloc() or vmap() call will use up the entire region, and leave no
space for loading modules after that.

Since commit 82046702e288 ("efi/libstub/arm64: Replace 'preferred'
offset with alignment check"), this is much more likely to occur on
systems that boot via EFI but lack an implementation of the EFI RNG
protocol, as in that case, the EFI stub will decide to leave the image
where it found it, and the EFI firmware uses 64k alignment only.

Fix this, by correctly identifying the case where the virtual
displacement is a result of the physical displacement only.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
I have sent out the same patch with a much shorter commit log as part of
my LPA2 series before, but I only realized today that this is likely to
fix most occurrences of the issue where a single 10g vmalloc() call
break subsequent module loading, so I am reposting it in isolation.

 arch/arm64/include/asm/memory.h | 11 +++++++++++
 arch/arm64/kernel/cpufeature.c  |  2 +-
 arch/arm64/kernel/kaslr.c       |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 9dd08cd339c3f028..78e5163836a0ab95 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -180,6 +180,7 @@
 #include <linux/compiler.h>
 #include <linux/mmdebug.h>
 #include <linux/types.h>
+#include <asm/boot.h>
 #include <asm/bug.h>
 
 #if VA_BITS > 48
@@ -203,6 +204,16 @@ static inline unsigned long kaslr_offset(void)
 	return kimage_vaddr - KIMAGE_VADDR;
 }
 
+static inline bool kaslr_enabled(void)
+{
+	/*
+	 * The KASLR offset modulo MIN_KIMG_ALIGN is taken from the physical
+	 * placement of the image rather than from the seed, so a displacement
+	 * of less than MIN_KIMG_ALIGN means that no seed was provided.
+	 */
+	return kaslr_offset() >= MIN_KIMG_ALIGN;
+}
+
 /*
  * Allow all memory at the discovery stage. We will clip it later.
  */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 45a42cf2191c36c3..5643a9ca502af207 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1633,7 +1633,7 @@ bool kaslr_requires_kpti(void)
 			return false;
 	}
 
-	return kaslr_offset() > 0;
+	return kaslr_enabled();
 }
 
 static bool __meltdown_safe = true;
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 325455d16dbcb31a..e7477f21a4c9d062 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -41,7 +41,7 @@ static int __init kaslr_init(void)
 		return 0;
 	}
 
-	if (!kaslr_offset()) {
+	if (!kaslr_enabled()) {
 		pr_warn("KASLR disabled due to lack of seed\n");
 		return 0;
 	}
-- 
2.39.1

