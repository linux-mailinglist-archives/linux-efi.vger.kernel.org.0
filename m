Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF1780B39
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376704AbjHRLiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376705AbjHRLh4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE32112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0145062F79
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5FFC433C8;
        Fri, 18 Aug 2023 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358674;
        bh=hgE6UrRP8JhmGUqEbClx3EvIR+KJAiCIBIzs1bVLSaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIbtsvXsTjFwTzG0UcPwIMPGi0gM520bdx5l0GeZTWZM1q0qI42VT81D403+y0/DZ
         8ClmfqQQBvMTIsf9k7gPABYoOckK9a7JKkVWChuwhVVJsX7osGjBllZOMkyqeusuGn
         vFzFnp1/t7jWPxllgYy6SSVObHXC/0W3Sy5As2rfPe+YKYT7docmm58l2XSDAb+zgc
         JfFts2het6nlvm9b45cWO+gBjRJ13YKLiTEz6KYgwyxa1nwJqRajc8Pek6TP4b6pXU
         9CQ8Xh6lF8fSF+j+LWlh0qQoYFcrFbRAdkhJauEhlhawJVvh/CKYR9WDr9kez8cOw9
         hSgm/pbumW0cg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 06/11] efi/runtime-wrappers: Remove duplicated macro for service returning void
Date:   Fri, 18 Aug 2023 13:37:19 +0200
Message-Id: <20230818113724.368492-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4864; i=ardb@kernel.org; h=from:subject; bh=hgE6UrRP8JhmGUqEbClx3EvIR+KJAiCIBIzs1bVLSaU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++If7M0Iq1mhl13+dsH9RlmxXsLckm+ziRXWs9/9/C +qvkrvSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyPY3hv1MO0+RTAp2SmUq2 Txz+a91buyTpWeO2abo5U/VSvt77xMbIcLvpF2Ob/Je4bcvLGvX+Xpj7qSlnutCK0MxYTQH/J78 YOAA=
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

Given that there is only a single user, let's drop the macro, and expand
it into the caller. That way, the remaining macro can be tightened
somewhat in terms of type safety too.

Note that the use of typeof() on the runtime service invocation does not
result in an actual call being made, but it does require a few pointer
types to be fixed up and converted into the proper function pointer
prototypes.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/uv/bios.h          |  3 ++-
 drivers/acpi/prmt.c                     |  2 +-
 drivers/firmware/efi/runtime-wrappers.c |  9 +++++---
 include/linux/efi.h                     | 23 ++++----------------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 1b6455f881f90e9c..501409f1258a196d 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -115,7 +115,8 @@ struct uv_arch_type_entry {
 struct uv_systab {
 	char signature[4];	/* must be UV_SYSTAB_SIG */
 	u32 revision;		/* distinguish different firmware revs */
-	u64 function;		/* BIOS runtime callback function ptr */
+	u64 (__efiapi *function)(enum uv_bios_cmd, ...);
+				/* BIOS runtime callback function ptr */
 	u32 size;		/* systab size (starting with _VERSION_UV4) */
 	struct {
 		u32 type:8;	/* type of entry */
diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 3d4c4620f9f95309..71b9adaaf33b93cf 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -53,7 +53,7 @@ static LIST_HEAD(prm_module_list);
 
 struct prm_handler_info {
 	guid_t guid;
-	void *handler_addr;
+	efi_status_t (__efiapi *handler_addr)(u64, void *);
 	u64 static_data_buffer_addr;
 	u64 acpi_param_buffer_addr;
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index ee5c9a3e50604398..c5e0c73cc000ed25 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -41,8 +41,6 @@
  */
 #define efi_call_virt(f, args...)   \
 	efi_call_virt_pointer(efi.runtime, f, args)
-#define __efi_call_virt(f, args...) \
-	__efi_call_virt_pointer(efi.runtime, f, args)
 
 union efi_rts_args {
 	struct {
@@ -491,8 +489,13 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
+
+	arch_efi_call_virt_setup();
 	efi_rts_work.efi_rts_id = EFI_RESET_SYSTEM;
-	__efi_call_virt(reset_system, reset_type, status, data_size, data);
+	arch_efi_call_virt(efi.runtime, reset_system, reset_type, status,
+			   data_size, data);
+	arch_efi_call_virt_teardown();
+
 	up(&efi_runtime_lock);
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index b8c446da608371d2..ebb9671ed15ee3cb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1171,8 +1171,7 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 #define arch_efi_call_virt(p, f, args...)	((p)->f(args))
 
 /*
- * Arch code can implement the following three template macros, avoiding
- * reptition for the void/non-void return cases of {__,}efi_call_virt():
+ * Arch code must implement the following three routines:
  *
  *  * arch_efi_call_virt_setup()
  *
@@ -1181,9 +1180,8 @@ static inline void efi_check_for_embedded_firmwares(void) { }
  *
  *  * arch_efi_call_virt()
  *
- *    Performs the call. The last expression in the macro must be the call
- *    itself, allowing the logic to be shared by the void and non-void
- *    cases.
+ *    Performs the call. This routine takes a variable number of arguments so
+ *    it must be implemented as a variadic preprocessor macro.
  *
  *  * arch_efi_call_virt_teardown()
  *
@@ -1192,7 +1190,7 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 
 #define efi_call_virt_pointer(p, f, args...)				\
 ({									\
-	efi_status_t __s;						\
+	typeof((p)->f(args)) __s;					\
 	unsigned long __flags;						\
 									\
 	arch_efi_call_virt_setup();					\
@@ -1206,19 +1204,6 @@ static inline void efi_check_for_embedded_firmwares(void) { }
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

