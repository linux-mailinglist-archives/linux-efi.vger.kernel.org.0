Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B595BD1E6
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiISQJy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiISQJw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 12:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29431A80A
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 09:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49872B80883
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 16:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97869C433C1;
        Mon, 19 Sep 2022 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663603788;
        bh=exdXQWm1YcZDOuToTtkDOzZbqFzI0ZVk3dlmNBboJIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mePh4adajFDsEwhvBeZZWGrvgU3x3pDmfsJ5lqdODhy344umoKXPW4q6oH+QdIOtw
         UixBNIWmlON4DfpNf3RF3Jafv3cmHDJk26AlenaUGEQm2ZfNLcu/0PxWdD4z+JPFuq
         +5Zkam+BpoB8oI0KfD3pBpu5k2bNbibibdubByyi3GY/bQD47rcYkfCMeowguQAWLv
         S2sCsUbdrdOvDVbi0a0qD8WAMbRw3e5gtDwV3AdKBkSa3ZfUDRtr1VXXIRfyRYZmdg
         h2q8OL9oOd190a2bhjQ7dsPBssowXOwsLzQ1CjwShTkXc/4tzYSP3+29z5e5kqhbJa
         pSuiIJAfYBTbg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3/3] efi: random: combine bootloader provided RNG seed with RNG protocol output
Date:   Mon, 19 Sep 2022 18:09:31 +0200
Message-Id: <20220919160931.2945427-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919160931.2945427-1-ardb@kernel.org>
References: <20220919160931.2945427-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8976; i=ardb@kernel.org; h=from:subject; bh=exdXQWm1YcZDOuToTtkDOzZbqFzI0ZVk3dlmNBboJIA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKJQ6Zu6VBFzMaLKhkL36vUq8Ydbc3Nmqbr4THOsw 5ZMVaoWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyiUOgAKCRDDTyI5ktmPJFgHC/ 9osc0op+GfzspgE5U9fcjSUL6xZQI9a21l/jhe9CHkoTEVCZkhJBp2HRmJwdw3nF8QwXMVxeowiyXp q84fL+0ywPlOPMS5fCHYp9bwAQBn+MOmN4rfKx7aau1MWsnHEp851vPCr/X3lBz+2uT8IPgzBN2ShQ KC0IssggI+jKPw+q/aWus19lGZ3uSrDykpM3BzE1wpgWWCSIYsBCeNfANpTO2033dJXIUxzAlVNsMe O6MhvBG7m5eITCCH2Td1O821TC+4+nZXNJY1N5O+qxk6MWzbmFCHj1bj0JXMty4gU4q6ZU+tZqmWS7 jHf6DCRIoCUf82Uh+RG1uYJbo/56BJ7V9e3/NTWFQUdSo6qFbyYM/9qA4KAOhxpPrMIG3k06bCyPvT qROGpkNnrwdB6OhZ5jyJEm9rj+cXXW/p344rNusl2eRZunA3yFI39Uer5rIU7Geh5rVKvX7t8xiojL jtBuW0TIxjCSIu6o2Kv8vVPGkpJwLR4wlkhBjofSpl1Tc=
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
combine its contents with a Linux specific personalization string, and
if available, mix in the output of the RNG protocol as well.

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
size is 32 bytes, anything beyond that is mixed in but not reflected in
the final seed size.

Suggested-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile  |  4 +
 drivers/firmware/efi/libstub/efistub.h |  2 +
 drivers/firmware/efi/libstub/random.c  | 79 ++++++++++++--------
 include/linux/efi.h                    |  2 -
 lib/crypto/blake2s-generic.c           |  2 +
 lib/crypto/blake2s.c                   |  7 +-
 6 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..3b3c67001566 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -55,6 +55,7 @@ KCOV_INSTRUMENT			:= n
 lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   file.o mem.o random.o randomalloc.o pci.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o \
+				   libcrypto-blake2s.o libcrypto-blake2s-generic.o \
 				   alignedmem.o relocate.o vsprintf.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
@@ -63,6 +64,9 @@ efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+$(obj)/libcrypto-%.o: $(srctree)/lib/crypto/%.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
 lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..fc32897de5e8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -873,6 +873,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed);
 
+void efi_random_get_seed(void);
+
 efi_status_t check_platform_features(void);
 
 void *get_efi_config_table(efi_guid_t guid);
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 183dc5cdb8ed..87fcd73ef615 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -5,6 +5,7 @@
 
 #include <linux/efi.h>
 #include <asm/efi.h>
+#include <crypto/blake2s.h>
 
 #include "efistub.h"
 
@@ -49,60 +50,74 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 	return efi_call_proto(rng, get_rng, NULL, size, out);
 }
 
+static char const pstr[] = "Linux EFI Stub RNG Seed Label v1";
+
 /**
  * efi_random_get_seed() - provide random seed as configuration table
  *
  * The EFI_RNG_PROTOCOL is used to read random bytes. These random bytes are
  * saved as a configuration table which can be used as entropy by the kernel
  * for the initialization of its pseudo random number generator.
- *
- * If the EFI_RNG_PROTOCOL is not available or there are not enough random bytes
- * available, the configuration table will not be installed and an error code
- * will be returned.
- *
- * Return:	status code
  */
-efi_status_t efi_random_get_seed(void)
+void efi_random_get_seed(void)
 {
 	efi_guid_t rng_proto = EFI_RNG_PROTOCOL_GUID;
 	efi_guid_t rng_algo_raw = EFI_RNG_ALGORITHM_RAW;
 	efi_guid_t rng_table_guid = LINUX_EFI_RANDOM_SEED_TABLE_GUID;
 	efi_rng_protocol_t *rng = NULL;
 	struct linux_efi_random_seed *seed = NULL;
+	struct blake2s_state state;
+	unsigned int total_len = 0;
 	efi_status_t status;
 
-	status = efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
-	if (status != EFI_SUCCESS)
-		return status;
+	// grab the EFI RNG protocol, if it exists
+	efi_bs_call(locate_protocol, &rng_proto, NULL, (void **)&rng);
 
-	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
-			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
-			     (void **)&seed);
-	if (status != EFI_SUCCESS)
-		return status;
+	// grab the seed provided by the previous boot stages
+	seed = get_efi_config_table(LINUX_EFI_RANDOM_SEED_TABLE_GUID);
+
+	// if neither exists, there is little we can do
+	if (!seed && !rng)
+		return;
+
+	blake2s_init(&state, EFI_RANDOM_SEED_SIZE);
+	blake2s_update(&state, pstr, sizeof(pstr) - 1);
+
+	if (seed) {
+		blake2s_update(&state, (void *)&seed->size, sizeof(seed->size));
+		blake2s_update(&state, seed->bits, seed->size);
+		total_len += seed->size;
+	}
 
-	status = efi_call_proto(rng, get_rng, &rng_algo_raw,
-				 EFI_RANDOM_SEED_SIZE, seed->bits);
+	if (rng) {
+		const int sz = EFI_RANDOM_SEED_SIZE;
+		u8 bits[EFI_RANDOM_SEED_SIZE];
 
-	if (status == EFI_UNSUPPORTED)
-		/*
-		 * Use whatever algorithm we have available if the raw algorithm
-		 * is not implemented.
-		 */
-		status = efi_call_proto(rng, get_rng, NULL,
-					EFI_RANDOM_SEED_SIZE, seed->bits);
+		status = efi_call_proto(rng, get_rng, &rng_algo_raw, sz, bits);
+		if (status == EFI_UNSUPPORTED)
+			/*
+			 * Use whatever algorithm we have available if the raw algorithm
+			 * is not implemented.
+			 */
+			status = efi_call_proto(rng, get_rng, NULL, sz, bits);
 
+		if (status == EFI_SUCCESS) {
+			blake2s_update(&state, (void *)&sz, sizeof(sz));
+			blake2s_update(&state, bits, sz);
+			total_len += sz;
+		}
+	}
+
+	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+			     sizeof(*seed) + EFI_RANDOM_SEED_SIZE,
+			     (void **)&seed);
 	if (status != EFI_SUCCESS)
-		goto err_freepool;
+		return;
 
-	seed->size = EFI_RANDOM_SEED_SIZE;
+	blake2s_final(&state, seed->bits);
+	seed->size = min(total_len, EFI_RANDOM_SEED_SIZE);
 	status = efi_bs_call(install_configuration_table, &rng_table_guid, seed);
 	if (status != EFI_SUCCESS)
-		goto err_freepool;
-
-	return EFI_SUCCESS;
+		efi_warn("Failed to install LINUX_EFI_RANDOM_SEED_TABLE_GUID config table\n");
 
-err_freepool:
-	efi_bs_call(free_pool, seed);
-	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7b015508c773..95542148d9d7 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1142,8 +1142,6 @@ void efi_check_for_embedded_firmwares(void);
 static inline void efi_check_for_embedded_firmwares(void) { }
 #endif
 
-efi_status_t efi_random_get_seed(void);
-
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..5d16b5a59618 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -110,6 +110,8 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 
 EXPORT_SYMBOL(blake2s_compress_generic);
 
+#ifdef MODULE
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BLAKE2s hash function");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
+#endif
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 98e688c6d891..dbae6d83027b 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -58,15 +58,18 @@ void blake2s_final(struct blake2s_state *state, u8 *out)
 }
 EXPORT_SYMBOL(blake2s_final);
 
+#if !defined(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) && !defined(__DISABLE_EXPORTS)
 static int __init blake2s_mod_init(void)
 {
-	if (!IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS) &&
-	    WARN_ON(!blake2s_selftest()))
+	if (WARN_ON(!blake2s_selftest()))
 		return -ENODEV;
 	return 0;
 }
 
 module_init(blake2s_mod_init);
+#endif
+#ifdef MODULE
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BLAKE2s hash function");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
+#endif
-- 
2.35.1

