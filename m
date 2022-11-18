Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AA62F63C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Nov 2022 14:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiKRNeL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 08:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiKRNdj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 08:33:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DB903A2;
        Fri, 18 Nov 2022 05:32:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 074E2B823BE;
        Fri, 18 Nov 2022 13:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C95AC433C1;
        Fri, 18 Nov 2022 13:32:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ohytgDOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668778374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z69aXawrfufSKW/RjtDgmumOVJvqFZkCZEOLY5WSnnc=;
        b=ohytgDOJH180kmo7Zc4g9dCjNiDGQB4lKgfEkm27skLwRna94u4Rp19QszrLjFsq2IisEV
        yYqhsRDCQo1PGIKnyi7b5OlbpPoS67SzFFqyPyIcv255J7SiXopt57kpUQX+2yi7kF2diz
        VP6ku7jx64ZP3r9kT1pvcuynqaJjZG8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a0869f8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 13:32:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 2/5] efi: stub: use random seed from EFI variable
Date:   Fri, 18 Nov 2022 14:32:36 +0100
Message-Id: <20221118133239.2515648-3-Jason@zx2c4.com>
In-Reply-To: <20221118133239.2515648-1-Jason@zx2c4.com>
References: <20221118133239.2515648-1-Jason@zx2c4.com>
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

EFI has a rather unique benefit that it has access to some limited
non-volatile storage, where the kernel can store a random seed. Read
that seed in EFISTUB and concatenate it with other seeds we wind up
passing onward to the kernel in the configuration table. This is
complementary to the current other two sources - previous bootloaders,
and the EFI RNG protocol.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/firmware/efi/libstub/random.c | 59 +++++++++++++++++++++------
 include/linux/efi.h                   |  1 +
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index f85d2c066877..1e72013a6457 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -67,14 +67,25 @@ efi_status_t efi_random_get_seed(void)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
+	efi_char16_t rng_nv_seed_var[] = LINUX_EFI_RANDOM_NV_SEED_VAR;
 	struct linux_efi_random_seed *prev_seed, *seed = NULL;
-	int prev_seed_size = 0, seed_size = EFI_RANDOM_SEED_SIZE;
+	u8 nv_seed[EFI_RANDOM_SEED_SIZE];
+	unsigned long prev_seed_size = 0, nv_seed_size = sizeof(nv_seed), seed_size = 0, offset = 0;
 	efi_rng_protocol_t *rng = NULL;
 	efi_status_t status;
 
 	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
-	if (status != EFI_SUCCESS)
-		return status;
+	if (status == EFI_SUCCESS)
+		seed_size += EFI_RANDOM_SEED_SIZE;
+
+	status = get_efi_var(rng_nv_seed_var, &rng_table_guid, NULL, &nv_seed_size, nv_seed);
+	if (status == EFI_SUCCESS)
+		seed_size += nv_seed_size;
+	else
+		nv_seed_size = 0;
+
+	if (!seed_size)
+		return EFI_NOT_FOUND;
 
 	/*
 	 * Check whether a seed was provided by a prior boot stage. In that
@@ -83,7 +94,7 @@ efi_status_t efi_random_get_seed(void)
 	 * Note that we should read the seed size with caution, in case the
 	 * table got corrupted in memory somehow.
 	 */
-	prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
+	prev_seed = get_efi_config_table(rng_table_guid);
 	if (prev_seed && prev_seed->size <= 512U) {
 		prev_seed_size = prev_seed->size;
 		seed_size += prev_seed_size;
@@ -103,7 +114,7 @@ efi_status_t efi_random_get_seed(void)
 	}
 
 	status = efi_call_proto(rng, get_rng, &rng_algo_raw,
-				EFI_RANDOM_SEED_SIZE, seed->bits);
+				EFI_RANDOM_SEED_SIZE, seed->bits + offset);
 
 	if (status == EFI_UNSUPPORTED)
 		/*
@@ -111,16 +122,40 @@ efi_status_t efi_random_get_seed(void)
 		 * is not implemented.
 		 */
 		status = efi_call_proto(rng, get_rng, NULL,
-					EFI_RANDOM_SEED_SIZE, seed->bits);
+					EFI_RANDOM_SEED_SIZE, seed->bits + offset);
 
-	if (status != EFI_SUCCESS)
+	if (status == EFI_SUCCESS)
+		offset += EFI_RANDOM_SEED_SIZE;
+
+	if (nv_seed_size) {
+		memcpy(seed->bits + offset, nv_seed, nv_seed_size);
+		memzero_explicit(nv_seed, nv_seed_size);
+		/*
+		 * Zero it out before committing to using it. TODO: in the
+		 * future, maybe we can hash it forward instead, which is
+		 * better and also reduces the amount of writes here.
+		 */
+		status = set_efi_var(rng_nv_seed_var, &rng_table_guid,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS, nv_seed_size, nv_seed);
+		if (status == EFI_SUCCESS)
+			status = set_efi_var(rng_nv_seed_var, &rng_table_guid, 0, 0, NULL);
+		if (status == EFI_SUCCESS)
+			offset += nv_seed_size;
+		else
+			memzero_explicit(seed->bits + offset, nv_seed_size);
+	}
+
+	if (!offset)
 		goto err_freepool;
 
-	seed->size = seed_size;
-	if (prev_seed_size)
-		memcpy(seed->bits + EFI_RANDOM_SEED_SIZE, prev_seed->bits,
-		       prev_seed_size);
+	if (prev_seed_size) {
+		memcpy(seed->bits + offset, prev_seed->bits, prev_seed_size);
+		offset += prev_seed_size;
+	}
 
+	seed->size = offset;
 	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
@@ -135,7 +170,7 @@ efi_status_t efi_random_get_seed(void)
 err_freepool:
 	memzero_explicit(seed, struct_size(seed, bits, seed_size));
 	efi_bs_call(free_pool, seed);
-	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL\n");
+	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL and EFI variable\n");
 err_warn:
 	if (prev_seed)
 		efi_warn("Retaining bootloader-supplied seed only");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4aa1dbc7b064..ca02685ec004 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -408,6 +408,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
+#define LINUX_EFI_RANDOM_NV_SEED_VAR		L"RandomSeed"
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
-- 
2.38.1

