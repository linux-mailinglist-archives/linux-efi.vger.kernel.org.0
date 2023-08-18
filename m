Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA59780B3B
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376705AbjHRLiT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbjHRLh7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6AF2112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D45361DD9
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AFCC433C7;
        Fri, 18 Aug 2023 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358677;
        bh=gupJBs1lJenWEdQdfCpvOfI2K/VV4o0bjxCM20K6qUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJkOj5K/UbTDWb+vX79Qbk0rA0RdXRE61Sw14IUSg/YX4nZwz9sn5agwCAadr4voY
         k/c10UqHjMxVCRHrrcNxrlFQswE0sALDHXb2Liecfs4Zvs/Y8Eh+/CRtKFUGLG/7qO
         P2/UfwglOlm0T098bQx08FJKx/jYXgGSJSLZzf6HXgZ3+lhnm1mXAv9ONza5ylU3uy
         uk4nSWgGncoV+fiwlZvwrclJpFM9CmEvKl42f2Q4Z2edao65lTQmXDMR2g40tlpDoC
         whlp0sFpfVRSBazcZNxJY5hUoNk+54imDull+kJS/RDkXCzN5z9DwE2k9pDJhc+0+H
         gYKazAcwMfLDA==
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
Subject: [PATCH v2 07/11] efi/runtime-wrappers: Don't duplicate setup/teardown code
Date:   Fri, 18 Aug 2023 13:37:20 +0200
Message-Id: <20230818113724.368492-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983; i=ardb@kernel.org; h=from:subject; bh=gupJBs1lJenWEdQdfCpvOfI2K/VV4o0bjxCM20K6qUY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++Iec064Z5ff2LBHO3T3LKuoNZ/JR/zWTjzjmcOSXs xw0CmLvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPJNGD4Z/6ytuBQWkBP0qE7 6z1+2713FRNW8T9693tn7PYtz91/ZzP84Uy3nSju3f3KVOlMp/8LvSslE50+rGC15/dyWiB+xnE WOwA=
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

Avoid duplicating the EFI arch setup and teardown routine calls numerous
times in efi_call_rts(). Instead, expand the efi_call_virt_pointer()
macro into efi_call_rts(), taking the pre and post parts out of the
switch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 26 ++++++++++++++------
 include/linux/efi.h                     |  6 +++--
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index c5e0c73cc000ed25..afe9248cc5bc61ba 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -40,7 +40,7 @@
  * code doesn't get too cluttered:
  */
 #define efi_call_virt(f, args...)   \
-	efi_call_virt_pointer(efi.runtime, f, args)
+	arch_efi_call_virt(efi.runtime, f, args)
 
 union efi_rts_args {
 	struct {
@@ -139,7 +139,7 @@ unsigned long efi_call_virt_save_flags(void)
 	return flags;
 }
 
-void efi_call_virt_check_flags(unsigned long flags, const char *call)
+void efi_call_virt_check_flags(unsigned long flags, const void *caller)
 {
 	unsigned long cur_flags, mismatch;
 
@@ -150,8 +150,8 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
 		return;
 
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
-	pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
-			   flags, cur_flags, call);
+	pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI call from %pS\n",
+			   flags, cur_flags, caller ?: __builtin_return_address(0));
 	arch_efi_restore_flags(flags);
 }
 
@@ -211,6 +211,10 @@ static void efi_call_rts(struct work_struct *work)
 {
 	const union efi_rts_args *args = efi_rts_work.args;
 	efi_status_t status = EFI_NOT_FOUND;
+	unsigned long flags;
+
+	arch_efi_call_virt_setup();
+	flags = efi_call_virt_save_flags();
 
 	switch (efi_rts_work.efi_rts_id) {
 	case EFI_GET_TIME:
@@ -287,6 +291,10 @@ static void efi_call_rts(struct work_struct *work)
 		 */
 		pr_err("Requested executing invalid EFI Runtime Service.\n");
 	}
+
+	efi_call_virt_check_flags(flags, efi_rts_work.caller);
+	arch_efi_call_virt_teardown();
+
 	efi_rts_work.status = status;
 	complete(&efi_rts_work.efi_rts_comp);
 }
@@ -296,6 +304,7 @@ static efi_status_t __efi_queue_work(enum efi_rts_ids id,
 {
 	efi_rts_work.efi_rts_id = id;
 	efi_rts_work.args = args;
+	efi_rts_work.caller = __builtin_return_address(0);
 	efi_rts_work.status = EFI_ABORTED;
 
 	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
@@ -423,8 +432,8 @@ virt_efi_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt(set_variable, name, vendor, attr, data_size,
-			       data);
+	status = efi_call_virt_pointer(efi.runtime, set_variable, name, vendor,
+				       attr, data_size, data);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -462,8 +471,9 @@ virt_efi_query_variable_info_nonblocking(u32 attr,
 	if (down_trylock(&efi_runtime_lock))
 		return EFI_NOT_READY;
 
-	status = efi_call_virt(query_variable_info, attr, storage_space,
-			       remaining_space, max_variable_size);
+	status = efi_call_virt_pointer(efi.runtime, query_variable_info, attr,
+				       storage_space, remaining_space,
+				       max_variable_size);
 	up(&efi_runtime_lock);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ebb9671ed15ee3cb..cf450b6fbfd20aa5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1130,7 +1130,7 @@ extern bool efi_runtime_disabled(void);
 static inline bool efi_runtime_disabled(void) { return true; }
 #endif
 
-extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
+extern void efi_call_virt_check_flags(unsigned long flags, const void *caller);
 extern unsigned long efi_call_virt_save_flags(void);
 
 enum efi_secureboot_mode {
@@ -1197,7 +1197,7 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 									\
 	__flags = efi_call_virt_save_flags();				\
 	__s = arch_efi_call_virt(p, f, args);				\
-	efi_call_virt_check_flags(__flags, __stringify(f));		\
+	efi_call_virt_check_flags(__flags, NULL);			\
 									\
 	arch_efi_call_virt_teardown();					\
 									\
@@ -1258,6 +1258,7 @@ union efi_rts_args;
  * @status:		Status of executing EFI Runtime Service
  * @efi_rts_id:		EFI Runtime Service function identifier
  * @efi_rts_comp:	Struct used for handling completions
+ * @caller:		The caller of the runtime service
  */
 struct efi_runtime_work {
 	union efi_rts_args	*args;
@@ -1265,6 +1266,7 @@ struct efi_runtime_work {
 	struct work_struct	work;
 	enum efi_rts_ids	efi_rts_id;
 	struct completion	efi_rts_comp;
+	const void		*caller;
 };
 
 extern struct efi_runtime_work efi_rts_work;
-- 
2.39.2

