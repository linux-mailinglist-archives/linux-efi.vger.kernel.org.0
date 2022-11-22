Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4346332AA
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 03:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiKVCEd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 21:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiKVCEV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 21:04:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EBDEAE8;
        Mon, 21 Nov 2022 18:04:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FE38B8136A;
        Tue, 22 Nov 2022 02:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54890C433D6;
        Tue, 22 Nov 2022 02:04:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dl6cffAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669082656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRRUJbIcSnr8ZTNHq3sI4HzNBqRBBqfcvWMclFygaoU=;
        b=dl6cffANAexQpw8uQfoTRvNYbcmSWvDo6qlGlaZVWbcJMW4joFsgo1HkW3BKX/Z9uQfEF+
        sm+cpTuhIfgQtAiv5zJUtt+kTMoFMCkqQ89tknm0VUsPDvtUDWzW/BEwer/jfbbE1UP8Tn
        lp+6jTFLssgWXDdQA9BBGar4O4XzPmA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 57080fb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 22 Nov 2022 02:04:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 2/5] efi: stub: use random seed from EFI variable
Date:   Tue, 22 Nov 2022 03:04:01 +0100
Message-Id: <20221122020404.3476063-3-Jason@zx2c4.com>
In-Reply-To: <20221122020404.3476063-1-Jason@zx2c4.com>
References: <20221122020404.3476063-1-Jason@zx2c4.com>
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
 drivers/firmware/efi/libstub/random.c | 55 +++++++++++++++++++++------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index f85d2c066877..64aa6e7f3a17 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -68,13 +68,23 @@ efi_status_t efi_random_get_seed(void)
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
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
+	status = get_efi_var(L"RandomSeed", &rng_table_guid, NULL, &nv_seed_size, nv_seed);
+	if (status == EFI_SUCCESS)
+		seed_size += nv_seed_size;
+	else
+		nv_seed_size = 0;
+
+	if (!seed_size)
+		return EFI_NOT_FOUND;
 
 	/*
 	 * Check whether a seed was provided by a prior boot stage. In that
@@ -83,7 +93,7 @@ efi_status_t efi_random_get_seed(void)
 	 * Note that we should read the seed size with caution, in case the
 	 * table got corrupted in memory somehow.
 	 */
-	prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
+	prev_seed = get_efi_config_table(rng_table_guid);
 	if (prev_seed && prev_seed->size <= 512U) {
 		prev_seed_size = prev_seed->size;
 		seed_size += prev_seed_size;
@@ -103,7 +113,7 @@ efi_status_t efi_random_get_seed(void)
 	}
 
 	status = efi_call_proto(rng, get_rng, &rng_algo_raw,
-				EFI_RANDOM_SEED_SIZE, seed->bits);
+				EFI_RANDOM_SEED_SIZE, seed->bits + offset);
 
 	if (status == EFI_UNSUPPORTED)
 		/*
@@ -111,16 +121,37 @@ efi_status_t efi_random_get_seed(void)
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
+		 * We delete the seed here, and /hope/ that this causes EFI to
+		 * also zero out its representation on disk. This is somewhat
+		 * idealistic, but overwriting the variable with zeros is
+		 * likely just as fraught too. TODO: in the future, maybe we
+		 * can hash it forward instead, and write a new seed.
+		 */
+		status = set_efi_var(L"RandomSeed", &rng_table_guid, 0, 0, NULL);
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
@@ -135,7 +166,7 @@ efi_status_t efi_random_get_seed(void)
 err_freepool:
 	memzero_explicit(seed, struct_size(seed, bits, seed_size));
 	efi_bs_call(free_pool, seed);
-	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL\n");
+	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL and EFI variable\n");
 err_warn:
 	if (prev_seed)
 		efi_warn("Retaining bootloader-supplied seed only");
-- 
2.38.1

