Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54E7770591
	for <lists+linux-efi@lfdr.de>; Fri,  4 Aug 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHDQEa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Aug 2023 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHDQEV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Aug 2023 12:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1734446B3;
        Fri,  4 Aug 2023 09:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E5E46209C;
        Fri,  4 Aug 2023 16:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E8C433C9;
        Fri,  4 Aug 2023 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165055;
        bh=78j4ImjPFLwMIx6dNxzf6NrXohxazUfeSa9T0hDUi78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=he56eTrMDCJRuBvnSFjHS6R2oxXhVhFZKgncrrAZtjF83SZeZBwKnuTH5Cj2Oo261
         w4quaG9ZEReckzLQ/mVtaL1Kavb0KEefNG18TWgvThq3c4zLGt3y126gGGD907zAEp
         DFjNd8M/f+K4Yr21JcwrcuDMHu1h8XX1MlSoy40NvBPftWiwbjofPKfM+tlVEjsIaX
         pSgQNV+WQhYTx0FIDog/vaF+ILdRcsRvMW2GuWYbJcXA0CS7lHZGCnLqzrBKDG6Lfz
         1DcNTCalptErD5lV5J2Rocvz3W3+F5jsEJ6QAjDhSNt50hPpf4pY70VbdwQtHoOKoI
         EmQFRX75OddIg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/4] efi/runtime-wrappers: Remove duplicated macro for service returning void
Date:   Fri,  4 Aug 2023 18:03:58 +0200
Message-Id: <20230804160359.228901-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804160359.228901-1-ardb@kernel.org>
References: <20230804160359.228901-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=ardb@kernel.org; h=from:subject; bh=78j4ImjPFLwMIx6dNxzf6NrXohxazUfeSa9T0hDUi78=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWsYu5vR7Gvq9oebZ57nfGKe8Re7YULvk/S9+E0/xPSX WRwIk61o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEykQJaR4WVog4T/+xxD7ymy 3/2PvtkbqyOd2sfLPePT1qQfHJnZxgw/GQ8zzp31vkAu6+qPlul8tnuWmN8tuxWdL8c2p/pz4+4 V/AA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

__efi_call_virt() exists as an alternative for efi_call_virt() for the
sole reason that ResetSystem() returns void, and so we cannot use a call
to it in the RHS of an assignment.

Now that we support the use of _Generic, this is no longer needed, and
we can handle this by emitting a comma expression inside the default
branch of a _Generic() switch.

As a bonus, this ensures that the runtime service call is always
constructed and type checked by the compiler, as it is passed to
_Generic() to infer the return type. (both x86 and arm64 override
arch_efi_call_virt() to invoke a type unsafe variadic wrapper function
implemented in assembler)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c |  4 +---
 include/linux/efi.h                     | 24 ++++----------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 158685e26f430ac9..b3ef208299ae591e 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -41,8 +41,6 @@
  */
 #define efi_call_virt(f, args...)   \
 	efi_call_virt_pointer(efi.runtime, f, args)
-#define __efi_call_virt(f, args...) \
-	__efi_call_virt_pointer(efi.runtime, f, args)
 
 struct efi_runtime_work efi_rts_work;
 
@@ -422,7 +420,7 @@ static void virt_efi_reset_system(int reset_type,
 		return;
 	}
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
-	__efi_call_virt(reset_system, reset_type, status, data_size, data);
+	efi_call_virt(reset_system, reset_type, status, data_size, data);
 	up(&efi_runtime_lock);
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index b34e11a5e969282c..c72715821016851b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1171,8 +1171,7 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
- * Arch code can implement the following three template macros, avoiding
- * reptition for the void/non-void return cases of {__,}efi_call_virt():
+ * Arch code must implement the following three template macros:
  *
  *  * arch_efi_call_virt_setup()
  *
@@ -1181,9 +1180,7 @@ static inline void efi_check_for_embedded_firmwares(void) { }
  *
  *  * arch_efi_call_virt()
  *
- *    Performs the call. The last expression in the macro must be the call
- *    itself, allowing the logic to be shared by the void and non-void
- *    cases.
+ *    Performs the call.
  *
  *  * arch_efi_call_virt_teardown()
  *
@@ -1198,7 +1195,9 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 	arch_efi_call_virt_setup();					\
 									\
 	__flags = efi_call_virt_save_flags();				\
-	__s = arch_efi_call_virt(p, f, args);				\
+	__s = _Generic((p)->f(args),					\
+	       efi_status_t: arch_efi_call_virt((p), f, args),		\
+	       default: (arch_efi_call_virt((p), f, args), EFI_ABORTED));\
 	efi_call_virt_check_flags(__flags, __stringify(f));		\
 									\
 	arch_efi_call_virt_teardown();					\
@@ -1206,19 +1205,6 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 	__s;								\
 })
 
-#define __efi_call_virt_pointer(p, f, args...)				\
-({									\
-	unsigned long __flags;						\
-									\
-	arch_efi_call_virt_setup();					\
-									\
-	__flags = efi_call_virt_save_flags();				\
-	arch_efi_call_virt(p, f, args);					\
-	efi_call_virt_check_flags(__flags, __stringify(f));		\
-									\
-	arch_efi_call_virt_teardown();					\
-})
-
 #define EFI_RANDOM_SEED_SIZE		32U // BLAKE2S_HASH_SIZE
 
 struct linux_efi_random_seed {
-- 
2.39.2

