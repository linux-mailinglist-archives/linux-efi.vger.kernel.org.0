Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193373E195
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jun 2023 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFZOIx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jun 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFZOIw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jun 2023 10:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF210CB
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 07:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E71260C87
        for <linux-efi@vger.kernel.org>; Mon, 26 Jun 2023 14:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0917EC433C8;
        Mon, 26 Jun 2023 14:08:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ACkMoYpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687788525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GCw/5jbb/NeBFDzjU1WBh15AkwW9e7UcpRX0uoJlUWA=;
        b=ACkMoYpaVE3QAqHjRm1SLFKo3wOjrs6u10m6dAHtDSasF9lYn4sASm4j9s4UdZou+Shl4A
        5QehutPrBiW4tj1DK20+oLVw771ONprw24wcV/ymGAwtXwjL7/IqUNFbSTPPqAe6tLSUB9
        0EZJPb0lX3jp7OH3s9cB4lArE7spMwQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b35ab6c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Jun 2023 14:08:41 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Sami Korkalainen <sami.korkalainen@proton.me>
Subject: [PATCH] efi: random: refresh random seed on modern EFI only
Date:   Mon, 26 Jun 2023 16:08:31 +0200
Message-ID: <20230626140836.299395-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI has a rather unique benefit that it has access to some limited
non-volatile storage, where the kernel can store a random seed. Register
a notification for when the RNG is initialized, and at that point, store
a new random seed.

This was previously reverted in 69cbeb61ff90 because it caused hangs on
very old EFI implementations. This time, restrict it to only modern EFIs
with a more recent revision number.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Sami Korkalainen <sami.korkalainen@proton.me>
Fixes: 69cbeb61ff90 ("Revert "efi: random: refresh non-volatile random seed when RNG is initialized"")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/firmware/efi/efi.c | 22 ++++++++++++++++++++++
 include/linux/efi.h        |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 34b9e7876538..1281798c7d7b 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -361,6 +361,24 @@ static void __init efi_debugfs_init(void)
 static inline void efi_debugfs_init(void) {}
 #endif
 
+static void refresh_nv_rng_seed(struct work_struct *work)
+{
+	u8 seed[EFI_RANDOM_SEED_SIZE];
+
+	get_random_bytes(seed, sizeof(seed));
+	efi.set_variable(L"RandomSeed", &LINUX_EFI_RANDOM_SEED_TABLE_GUID,
+			 EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
+			 EFI_VARIABLE_RUNTIME_ACCESS, sizeof(seed), seed);
+	memzero_explicit(seed, sizeof(seed));
+}
+static int refresh_nv_rng_seed_notification(struct notifier_block *nb, unsigned long action, void *data)
+{
+	static DECLARE_WORK(work, refresh_nv_rng_seed);
+	schedule_work(&work);
+	return NOTIFY_DONE;
+}
+static struct notifier_block refresh_nv_rng_seed_nb = { .notifier_call = refresh_nv_rng_seed_notification };
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -433,6 +451,10 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
+	if (efi.runtime_version >= EFI_2_40_SYSTEM_TABLE_REVISION &&
+	    efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
+
 	return 0;
 
 err_remove_group:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 571d1a6e1b74..3331cc17ae4f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -462,6 +462,7 @@ typedef struct {
 #define EFI_SYSTEM_TABLE_SIGNATURE ((u64)0x5453595320494249ULL)
 #define EFI_DXE_SERVICES_TABLE_SIGNATURE ((u64)0x565245535f455844ULL)
 
+#define EFI_2_40_SYSTEM_TABLE_REVISION  ((2 << 16) | (40))
 #define EFI_2_30_SYSTEM_TABLE_REVISION  ((2 << 16) | (30))
 #define EFI_2_20_SYSTEM_TABLE_REVISION  ((2 << 16) | (20))
 #define EFI_2_10_SYSTEM_TABLE_REVISION  ((2 << 16) | (10))
-- 
2.41.0

