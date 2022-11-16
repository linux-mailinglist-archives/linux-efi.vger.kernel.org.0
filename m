Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0226262C3C7
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiKPQRU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbiKPQRK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 11:17:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20557B4D;
        Wed, 16 Nov 2022 08:17:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDCC61EA1;
        Wed, 16 Nov 2022 16:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73977C433D6;
        Wed, 16 Nov 2022 16:17:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RZkhCM0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668615426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Od8YDuyhTgJbG1EHETqselbA6gas5EfTyFqSv7a58c=;
        b=RZkhCM0LogyN/TTzBoOeDcubZ2FyU42L9I2wf/KfPVfXXeziJVtBAd+C4lGS7zjWNkqPEj
        v90PJadTJOz05uzqEVs6qjZkK02uDErWGQqTYmYtiV1PXHcqMl6AAsSpIxsb4920Hh/wnN
        khRVqHmjJV1h0y6qFo1sNrLZIM9ZhvY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2f137fb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 16:17:05 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH RFC v1 3/6] efi: random: combine bootloader provided RNG seed with RNG protocol output
Date:   Wed, 16 Nov 2022 17:16:39 +0100
Message-Id: <20221116161642.1670235-4-Jason@zx2c4.com>
In-Reply-To: <20221116161642.1670235-1-Jason@zx2c4.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly creating the EFI random seed configuration table if
the RNG protocol is implemented and works, check whether such a EFI
configuration table was provided by an earlier boot stage and if so,
concatenate the existing and the new seeds, leaving it up to the core
code to mix it in and credit it the way it sees fit.

This can be used for, e.g., systemd-boot, to pass an additional seed to
Linux in a way that can be consumed by the kernel very early. In that
case, the following definitions should be used to pass the seed to the
EFI stub:

struct linux_efi_random_seed {
      u32     size; // of the 'seed' array in bytes
      u8      seed[];
};

The memory for the struct must be allocated as EFI_ACPI_RECLAIM_MEMORY
pool memory, and the address of the struct in memory should be installed
as a EFI configuration table using the following GUID:

LINUX_EFI_RANDOM_SEED_TABLE_GUID        1ce1e5bc-7ceb-42f2-81e5-8aadf180f57b

Note that doing so is safe even on kernels that were built without this
patch applied, but the seed will simply be overwritten with a seed
derived from the EFI RNG protocol, if available. The recommended seed
size is 32 bytes, and seeds larger than 512 bytes are considered
corrupted and ignored entirely.

In order to preserve forward secrecy, seeds from previous bootloaders
are memzero'd out, and in order to preserve memory, those older seeds
are also freed from memory. Freeing from memory without first memzeroing
is not safe to do, as it's possible that nothing else will ever
overwrite those pages used by EFI.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/firmware/efi/libstub/efistub.h |  2 ++
 drivers/firmware/efi/libstub/random.c  | 42 ++++++++++++++++++++++----
 include/linux/efi.h                    |  2 --
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index eb03d5a9aac8..900df67a2078 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -882,6 +882,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed);
 
+efi_status_t efi_random_get_seed(void);
+
 efi_status_t check_platform_features(void);
 
 void *get_efi_config_table(efi_guid_t guid);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 33ab56769595..f85d2c066877 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -67,27 +67,43 @@ efi_status_t efi_random_get_seed(void)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
+	struct linux_efi_random_seed *prev_seed, *seed = NULL;
+	int prev_seed_size = 0, seed_size = EFI_RANDOM_SEED_SIZE;
 	efi_rng_protocol_t *rng = NULL;
-	struct linux_efi_random_seed *seed = NULL;
 	efi_status_t status;
 
 	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 	if (status != EFI_SUCCESS)
 		return status;
 
+	/*
+	 * Check whether a seed was provided by a prior boot stage. In that
+	 * case, instead of overwriting it, let's create a new buffer that can
+	 * hold both, and concatenate the existing and the new seeds.
+	 * Note that we should read the seed size with caution, in case the
+	 * table got corrupted in memory somehow.
+	 */
+	prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
+	if (prev_seed && prev_seed->size <= 512U) {
+		prev_seed_size = prev_seed->size;
+		seed_size += prev_seed_size;
+	}
+
 	/*
 	 * Use EFI_ACPI_RECLAIM_MEMORY here so that it is guaranteed that the
 	 * allocation will survive a kexec reboot (although we refresh the seed
 	 * beforehand)
 	 */
 	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
+			     struct_size(seed, bits, seed_size),
 			     (void **)&seed);
-	if (status != EFI_SUCCESS)
-		return status;
+	if (status != EFI_SUCCESS) {
+		efi_warn("Failed to allocate memory for RNG seed.\n");
+		goto err_warn;
+	}
 
 	status = efi_call_proto(rng, get_rng, &rng_algo_raw,
-				 EFI_RANDOM_SEED_SIZE, seed->bits);
+				EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status == EFI_UNSUPPORTED)
 		/*
@@ -100,14 +116,28 @@ efi_status_t efi_random_get_seed(void)
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
 
-	seed->size = EFI_RANDOM_SEED_SIZE;
+	seed->size = seed_size;
+	if (prev_seed_size)
+		memcpy(seed->bits + EFI_RANDOM_SEED_SIZE, prev_seed->bits,
+		       prev_seed_size);
+
 	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
 
+	if (prev_seed_size) {
+		/* wipe and free the old seed if we managed to install the new one */
+		memzero_explicit(prev_seed->bits, prev_seed_size);
+		efi_bs_call(free_pool, prev_seed);
+	}
 	return EFI_SUCCESS;
 
 err_freepool:
+	memzero_explicit(seed, struct_size(seed, bits, seed_size));
 	efi_bs_call(free_pool, seed);
+	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL\n");
+err_warn:
+	if (prev_seed)
+		efi_warn("Retaining bootloader-supplied seed only");
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7603fc58c47c..4aa1dbc7b064 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1170,8 +1170,6 @@ void efi_check_for_embedded_firmwares(void);
 static inline void efi_check_for_embedded_firmwares(void) { }
 #endif
 
-efi_status_t efi_random_get_seed(void);
-
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
-- 
2.38.1

