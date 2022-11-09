Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3900A6227B5
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 10:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKIJ4S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 04:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiKIJ4M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 04:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6150240B2
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 01:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EE26198D
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 09:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2DDC433D6;
        Wed,  9 Nov 2022 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667987769;
        bh=5nd4fJCUWXijDNEUsiwc5mzrTwSoL+EvPP3W3OwArn8=;
        h=From:To:Cc:Subject:Date:From;
        b=kA7p4Y+gCUWPJhA+Xxx29QDGkCUlUrWpPK0251Jnp86/BZMskjwplBjCZFLNcNGtM
         dO5wkO7GgRN1MAq57G6D43ao3Tn7m6fK5718cY9/u+EtaTYUZrQdi3mhmT0APosJ+f
         7XTliGNG1oInSjaPqBbDZGUfAq0WIwmSXnxattFN7GBsKYCH+6QemsCy5bkQ160coe
         ZOO/hFDcJOg7i7t5s6sLsJvjHYyMIuK0mqW5lzMqX6+f2AKgAuwa6B6bInoNEftHTY
         vBxXrhPmBR/C5U0JvLPvDJhv3Ra++994P90mD9sAwBvCoQJ4t4HGaBwcIPj4p/I4YJ
         vv481YlUpMi4A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>
Subject: [PATCH v4] efi: random: combine bootloader provided RNG seed with RNG protocol output
Date:   Wed,  9 Nov 2022 10:55:58 +0100
Message-Id: <20221109095558.2572896-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6041; i=ardb@kernel.org; h=from:subject; bh=5nd4fJCUWXijDNEUsiwc5mzrTwSoL+EvPP3W3OwArn8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBja3ktHlhNDEECWLGPn2c/M+TWEkjLHrZlJMalHJG+ 1/qaIZGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2t5LQAKCRDDTyI5ktmPJBScDA CT0SOuJZMRO0pLq11e1FtVH1K6zvMpGp5uglI3wNvvvdosdwjp6QZbNtWGlkk+Xpp4t4w/VXXji9G/ FZpFwK4e9mPwSAc3PJzfOfq80MzESDTy0CCJOwTIKiaMAjiGV+QcE96prajczlZ8RqmFpLxfuQzbUp U2bA0GLSAZQsAgzZFHvgou+T2kMCN1I/fcUH0FE26sAT9C/4v613OlOS+TNe7+vxKWsduzNQcKjcaU aye98UmGRwWH7a2iDKUwO2bqj+lzf4oDyDrVQvG10kQnG4fisTB7hJJNLSnsLU6RQdjRr6ilM7Onkw SKpCPoSDu+Bf15lXDEHVCQybjhev/jHau3b+cObcOpx0utg4SdAHLfY6ijkjl8Ujoak8GaIk8zhfA3 fkKOl6vaFwtMzg3iW3RDhdXpDr1RW+ykb66T/fM624WKUXhSZtAtgH8uJ0tpFI34i9faGz+Ik9d1SQ bcSYRifOaCSAhAfus95J3Xs0W/F8EFe+y0jg/L3YMw4io=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

In order to preserve forward secrecy, seeds from previous bootloaders
are memzero'd out, and in order to preserve memory, those older seeds
are also freed from memory. Freeing from memory without first memzeroing
is not safe to do, as it's possible that nothing else will ever
overwrite those pages used by EFI.

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v4:
- expand commit log
- memzero new seed if we failed to install it - the old seed will be
  passed on unmodified in that case
- bump the prev seed size sanity check to 512 bytes, and ignore it
  entirely if the size exceeds that (which likely means the table was
  corrupted somehow)
- drop patches 1/3 and 2/3, which have been merged into mainline as
  fixes

 drivers/firmware/efi/libstub/efistub.h |  2 ++
 drivers/firmware/efi/libstub/random.c  | 32 ++++++++++++++++++--
 include/linux/efi.h                    |  2 --
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 576e5cfec9804b04..ce10b7bbd3f71d54 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -933,6 +933,8 @@ efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
 			      int memory_type);
 
+efi_status_t efi_random_get_seed(void);
+
 efi_status_t check_platform_features(void);
 
 void *get_efi_config_table(efi_guid_t guid);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 33ab567695951d6c..370a93ada948c6c1 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -67,21 +67,35 @@ efi_status_t efi_random_get_seed(void)
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
 	if (status != EFI_SUCCESS)
 		return status;
@@ -100,14 +114,26 @@ efi_status_t efi_random_get_seed(void)
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
 
+	if (prev_seed) {
+		/* wipe and free the old seed if we managed to install the new one */
+		memzero_explicit(prev_seed->bits, prev_seed_size);
+		efi_bs_call(free_pool, prev_seed);
+	}
 	return EFI_SUCCESS;
 
 err_freepool:
+	efi_warn("Failed to obtain seed from EFI_RNG_PROTOCOL%s\n",
+		 prev_seed ? ", retaining bootloader supplied seed only" : "");
+	memzero_explicit(seed, struct_size(seed, bits, seed_size));
 	efi_bs_call(free_pool, seed);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 60c73fc840a10c8d..1109f9d43b8e7fd4 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1132,8 +1132,6 @@ void efi_check_for_embedded_firmwares(void);
 static inline void efi_check_for_embedded_firmwares(void) { }
 #endif
 
-efi_status_t efi_random_get_seed(void);
-
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
-- 
2.35.1

