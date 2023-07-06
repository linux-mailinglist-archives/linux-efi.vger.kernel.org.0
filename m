Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C097499B0
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jul 2023 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGFKtB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jul 2023 06:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGFKs6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jul 2023 06:48:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95B1BE4;
        Thu,  6 Jul 2023 03:48:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF805229D3;
        Thu,  6 Jul 2023 10:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688640534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nagd4hrWVTUN2fhO85bv8SMGIyfaXYsHciVHSB56QIs=;
        b=ezEOMsWshtiK8IOAfRC1ZQx5qq02eCycv+z1J4CnyJ8PArxnmyj8GXn2c/6MS0bo/tdTJQ
        57x+ixODwliRWbHAAZCBFiupWxj7UhIGxoVkh/OdQ5hWZfBplIn4pqNPHlYIadT1IyDT6k
        zxKaS+1HX1pcsrXt7h1xFnJoMaXdm30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688640534;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nagd4hrWVTUN2fhO85bv8SMGIyfaXYsHciVHSB56QIs=;
        b=BbYrWDccu4JtxIM74+u72APjQbyEa2Bi1/siMoUgSf7YBm+QOVGX7HSIblp71A3oeHSi8l
        78cdSTsx5v/EZiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A94F21390F;
        Thu,  6 Jul 2023 10:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDJeKBacpmSDAQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Jul 2023 10:48:54 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, suijingfeng@loongson.cn, arnd@arndb.de
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/4] efi: Do not include <linux/screen_info.h> from EFI header
Date:   Thu,  6 Jul 2023 12:42:14 +0200
Message-ID: <20230706104852.27451-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706104852.27451-1-tzimmermann@suse.de>
References: <20230706104852.27451-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The header file <linux/efi.h> does not need anything from
<linux/screen_info.h>. Declare struct screen_info and remove
the include statements. Update a number of source files that
require struct screen_info's definition.

v2:
	* update loongarch (Jingfeng)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/kernel/efi.c                         | 2 ++
 arch/arm64/kernel/efi.c                       | 1 +
 arch/loongarch/kernel/efi.c                   | 1 +
 drivers/firmware/efi/libstub/efi-stub-entry.c | 2 ++
 drivers/firmware/efi/libstub/screen_info.c    | 2 ++
 include/linux/efi.h                           | 3 ++-
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index e2b9d2618c67..e94655ef16bb 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -5,6 +5,8 @@
 
 #include <linux/efi.h>
 #include <linux/memblock.h>
+#include <linux/screen_info.h>
+
 #include <asm/efi.h>
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index baab8dd3ead3..3afbe503b066 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -9,6 +9,7 @@
 
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/screen_info.h>
 
 #include <asm/efi.h>
 #include <asm/stacktrace.h>
diff --git a/arch/loongarch/kernel/efi.c b/arch/loongarch/kernel/efi.c
index 3d448fef3af4..9fc10cea21e1 100644
--- a/arch/loongarch/kernel/efi.c
+++ b/arch/loongarch/kernel/efi.c
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/memblock.h>
 #include <linux/reboot.h>
+#include <linux/screen_info.h>
 #include <linux/uaccess.h>
 
 #include <asm/early_ioremap.h>
diff --git a/drivers/firmware/efi/libstub/efi-stub-entry.c b/drivers/firmware/efi/libstub/efi-stub-entry.c
index cc4dcaea67fa..2f1902e5d407 100644
--- a/drivers/firmware/efi/libstub/efi-stub-entry.c
+++ b/drivers/firmware/efi/libstub/efi-stub-entry.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/efi.h>
+#include <linux/screen_info.h>
+
 #include <asm/efi.h>
 
 #include "efistub.h"
diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
index 4be1c4d1f922..a51ec201ca3c 100644
--- a/drivers/firmware/efi/libstub/screen_info.c
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/efi.h>
+#include <linux/screen_info.h>
+
 #include <asm/efi.h>
 
 #include "efistub.h"
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 571d1a6e1b74..360895a5572c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -24,10 +24,11 @@
 #include <linux/range.h>
 #include <linux/reboot.h>
 #include <linux/uuid.h>
-#include <linux/screen_info.h>
 
 #include <asm/page.h>
 
+struct screen_info;
+
 #define EFI_SUCCESS		0
 #define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))
-- 
2.41.0

