Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE59605A0F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJTIkp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJTIkm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 04:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67FFBCFC
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 01:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 317D561A7B
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 08:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653B8C433B5;
        Thu, 20 Oct 2022 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666255231;
        bh=DidgXi01vs3QJl79fyJMKey6h/6Z2yoooMXAGEGQbow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7LzqgqVvMu7nn9U+HYnAtm98jxrS4jEaqCs4h1wMIwew/WjzhAzGATI81nHR1rt9
         n4zElTkByRzWgcoawhMwLEPp+4KFpzbRPAceg+/WMWctdu0bPcDfpk4yRfJvhcyYCH
         gp2OPD9Go0pvWTRbW24IDGlerOkR32xeGkYZQGN63oj+Ha+pOSSAgE78zG7Pn5Vep/
         5muDCkuM6I8jDw09hnk5I3xVeCo8sYUy2uKZwYGMcwEedUWMitxdCIMlkHfXCuBs2Y
         oxgK7vfMKquPVRmSH1FmRZTuqJVDiQwAZ8hq/+jX5G0dnBJ0OR3X/ahHQEXJrInmia
         IEt3zVFFNahcQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v3 3/3] efi: random: combine bootloader provided RNG seed with RNG protocol output
Date:   Thu, 20 Oct 2022 10:39:10 +0200
Message-Id: <20221020083910.1902009-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020083910.1902009-1-ardb@kernel.org>
References: <20221020083910.1902009-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4851; i=ardb@kernel.org; h=from:subject; bh=DidgXi01vs3QJl79fyJMKey6h/6Z2yoooMXAGEGQbow=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjUQktk5UXFUYdATXiXa5lDEJuzxwgsQagUOLcYPvL 4zN6F3OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY1EJLQAKCRDDTyI5ktmPJH4JDA C7pruCaWEkzlKz1sBf0/C3n3u/EdIxPemexn/uXwibNGWozqWqrPX3At4F27NaTy+hXnQaLgG47TYW TxBd4FVvARI+5jl0lmJeJgv64pn1NmDbgiDy8k1DPoCX0z34Cc7JrwdIymfylHsCv4laJEAvI1ONsA Od89CIuTGb52GpR+DIWLRzKmQ2lWRRt5BFMNVH3lrtZr6HipMZD3fG6JaV+tJN4+5tyT69sRoDP1Pv HAbKB/PoEsbTK3NVeH5lO3J2Bsu04+vzaK6XaEBs80XFvGOOqI3Ab5EgyOKGIvo1Nscg4vMlSXWsDn 9QxfKo3AyfdzsWYwda0XnYavJ9dWHzMX5KDp0iyYLyTdm0V4APQ8+VB34O9Y9EmnHIBdaLRCZtpmyJ 9Yx6rt1lekD3vqr+4Ol0WJuuJaK4rgZQcx50xBOV8AgjSJxglImquIFouJOAEPwt9ggl5buMcnP89y IGCRX6frHfNHryuaqyA1FLSjlI73HCAPiClVrvwoleGS4=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
size is 32 bytes, anything beyond that is disregarded when the seeds are
concatenated.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h |  2 ++
 drivers/firmware/efi/libstub/random.c  | 29 ++++++++++++++++++--
 include/linux/efi.h                    |  2 --
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a30fb5d8ef05..75280b800eee 100644
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
index 183dc5cdb8ed..080012e837c3 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -67,16 +67,28 @@ efi_status_t efi_random_get_seed(void)
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
+	struct linux_efi_random_seed *prev_seed, *seed = NULL;
+	int prev_seed_size, seed_size = EFI_RANDOM_SEED_SIZE;
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
+	 */
+	prev_seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
+	if (prev_seed) {
+		prev_seed_size = min(prev_seed->size, EFI_RANDOM_SEED_SIZE);
+		seed_size += prev_seed_size;
+	}
+
 	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
+			     struct_size(seed, bits, seed_size),
 			     (void **)&seed);
 	if (status != EFI_SUCCESS)
 		return status;
@@ -95,14 +107,25 @@ efi_status_t efi_random_get_seed(void)
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
 
-	seed->size = EFI_RANDOM_SEED_SIZE;
+	seed->size = seed_size;
+	if (prev_seed)
+		memcpy(seed->bits + EFI_RANDOM_SEED_SIZE, prev_seed->bits,
+		       prev_seed_size);
+
 	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
 
+	if (prev_seed) {
+		/* wipe and free the old seed if we managed to install the new one */
+		memzero_explicit(prev_seed->bits, prev_seed_size);
+		efi_bs_call(free_pool, prev_seed);
+	}
 	return EFI_SUCCESS;
 
 err_freepool:
+	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
+		 prev_seed ? ", retaining bootloader supplied seed only" : "");
 	efi_bs_call(free_pool, seed);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index cf96f8d5f15f..69454a7ccc6f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1172,8 +1172,6 @@ void efi_check_for_embedded_firmwares(void);
 static inline void efi_check_for_embedded_firmwares(void) { }
 #endif
 
-efi_status_t efi_random_get_seed(void);
-
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
-- 
2.35.1

