Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F77058D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Aug 2023 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjHDQE3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Aug 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjHDQEV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Aug 2023 12:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968014C03;
        Fri,  4 Aug 2023 09:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2579162096;
        Fri,  4 Aug 2023 16:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540F4C433CC;
        Fri,  4 Aug 2023 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165052;
        bh=j71zU3HvZ6hL/cDONBGALJvoV//OuwaAaLN/bcuhs2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4x9op4qpGWfaG2Ku35FkpDDY4kpVNv7WmCCnau0I21QdoXL4Mnr4XgPmWLVRcWxn
         whnV0fUz5Zl8O8xQfURg6IXWSI/MN/tpduUFPvpaO4kGf+AHAkUSPqYQeOg0p+uZgx
         cBMhoBP3adVY4cHviHnOGwF3JgrXmCvK1mdsWL8myMtvBaQAXXWvZEjYgQ7nEnDRZG
         isk+9I36I3e+jH7MBSyYtkG8V6s5M4YSsyuHMuoHWoe6dmr9YzHwLgcl3cvxxjwGft
         6TtShO1MRYr44ihO+KPNa1fTOCPGKE9g0/Cnfyvqyt5bSh80/w6kwCKSMTH4tIBMBm
         XD/rCa025LorA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/4] efi/runtime-wrappers: Use type safe encapsulation of call arguments
Date:   Fri,  4 Aug 2023 18:03:56 +0200
Message-Id: <20230804160359.228901-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804160359.228901-1-ardb@kernel.org>
References: <20230804160359.228901-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13221; i=ardb@kernel.org; h=from:subject; bh=j71zU3HvZ6hL/cDONBGALJvoV//OuwaAaLN/bcuhs2s=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWsYtYJ3SlOx4OKtjL8OedVrtOjzLEmM7OfkT39yIGDI d8W6V3pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMJjGBkaGpkLBMy8GrRUd3p sLbAiG9q+PNDVQYLpc33brtrt+W4NiPDTW/mNqf7vxt3sPnvOKe2WWL2NnkuzbhJYvyxUgkdX55 wAAA=
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

The current code that marshalls the EFI runtime call arguments to hand
them off to a async helper does so in a type unsafe and slightly messy
manner - everything is cast to void* except for some integral types that
are passed by reference and dereferenced on the receiver end.

Let's clean this up a bit, and record the arguments of each runtime
service invocation exactly as they are issued, in a manner that permits
the compiler to check the types of the arguments at both ends.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 124 ++++++++++----------
 include/linux/efi.h                     |  73 +++++++++++-
 2 files changed, 126 insertions(+), 71 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a400c4312c829f18..5d48d493f57e7c38 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -49,15 +49,16 @@ struct efi_runtime_work efi_rts_work;
 /*
  * efi_queue_work:	Queue efi_runtime_service() and wait until it's done
  * @rts:		efi_runtime_service() function identifier
- * @rts_arg<1-5>:	efi_runtime_service() function arguments
  *
  * Accesses to efi_runtime_services() are serialized by a binary
  * semaphore (efi_runtime_lock) and caller waits until the work is
  * finished, hence _only_ one work is queued at a time and the caller
  * thread waits for completion.
  */
-#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)		\
+#define efi_queue_work(_rts, ...)					\
 ({									\
+	efi_rts_work._rts = (typeof(efi_rts_work._rts)){ __VA_ARGS__ };	\
+	efi_rts_work.efi_rts_id = EFI_ ## _rts;				\
 	efi_rts_work.status = EFI_ABORTED;				\
 									\
 	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
@@ -68,12 +69,6 @@ struct efi_runtime_work efi_rts_work;
 									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
 	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
-	efi_rts_work.arg1 = _arg1;					\
-	efi_rts_work.arg2 = _arg2;					\
-	efi_rts_work.arg3 = _arg3;					\
-	efi_rts_work.arg4 = _arg4;					\
-	efi_rts_work.arg5 = _arg5;					\
-	efi_rts_work.efi_rts_id = _rts;					\
 									\
 	/*								\
 	 * queue_work() returns 0 if work was already on queue,         \
@@ -170,73 +165,77 @@ extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
 /*
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.
- *
- * Semantics followed by efi_call_rts() to understand efi_runtime_work:
- * 1. If argument was a pointer, recast it from void pointer to original
- * pointer type.
- * 2. If argument was a value, recast it from void pointer to original
- * pointer type and dereference it.
  */
 static void efi_call_rts(struct work_struct *work)
 {
-	void *arg1, *arg2, *arg3, *arg4, *arg5;
 	efi_status_t status = EFI_NOT_FOUND;
 
-	arg1 = efi_rts_work.arg1;
-	arg2 = efi_rts_work.arg2;
-	arg3 = efi_rts_work.arg3;
-	arg4 = efi_rts_work.arg4;
-	arg5 = efi_rts_work.arg5;
-
 	switch (efi_rts_work.efi_rts_id) {
 	case EFI_GET_TIME:
-		status = efi_call_virt(get_time, (efi_time_t *)arg1,
-				       (efi_time_cap_t *)arg2);
+		status = efi_call_virt(get_time,
+				       efi_rts_work.GET_TIME.time,
+				       efi_rts_work.GET_TIME.capabilities);
 		break;
 	case EFI_SET_TIME:
-		status = efi_call_virt(set_time, (efi_time_t *)arg1);
+		status = efi_call_virt(set_time,
+				       efi_rts_work.SET_TIME.time);
 		break;
 	case EFI_GET_WAKEUP_TIME:
-		status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
-				       (efi_bool_t *)arg2, (efi_time_t *)arg3);
+		status = efi_call_virt(get_wakeup_time,
+				       efi_rts_work.GET_WAKEUP_TIME.enabled,
+				       efi_rts_work.GET_WAKEUP_TIME.pending,
+				       efi_rts_work.GET_WAKEUP_TIME.time);
 		break;
 	case EFI_SET_WAKEUP_TIME:
-		status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
-				       (efi_time_t *)arg2);
+		status = efi_call_virt(set_wakeup_time,
+				       efi_rts_work.SET_WAKEUP_TIME.enable,
+				       efi_rts_work.SET_WAKEUP_TIME.time);
 		break;
 	case EFI_GET_VARIABLE:
-		status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
-				       (efi_guid_t *)arg2, (u32 *)arg3,
-				       (unsigned long *)arg4, (void *)arg5);
+		status = efi_call_virt(get_variable,
+				       efi_rts_work.GET_VARIABLE.name,
+				       efi_rts_work.GET_VARIABLE.vendor,
+				       efi_rts_work.GET_VARIABLE.attr,
+				       efi_rts_work.GET_VARIABLE.data_size,
+				       efi_rts_work.GET_VARIABLE.data);
 		break;
 	case EFI_GET_NEXT_VARIABLE:
-		status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
-				       (efi_char16_t *)arg2,
-				       (efi_guid_t *)arg3);
+		status = efi_call_virt(get_next_variable,
+				       efi_rts_work.GET_NEXT_VARIABLE.name_size,
+				       efi_rts_work.GET_NEXT_VARIABLE.name,
+				       efi_rts_work.GET_NEXT_VARIABLE.vendor);
 		break;
 	case EFI_SET_VARIABLE:
-		status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
-				       (efi_guid_t *)arg2, *(u32 *)arg3,
-				       *(unsigned long *)arg4, (void *)arg5);
+		status = efi_call_virt(set_variable,
+				       efi_rts_work.SET_VARIABLE.name,
+				       efi_rts_work.SET_VARIABLE.vendor,
+				       efi_rts_work.SET_VARIABLE.attr,
+				       efi_rts_work.SET_VARIABLE.data_size,
+				       efi_rts_work.SET_VARIABLE.data);
 		break;
 	case EFI_QUERY_VARIABLE_INFO:
-		status = efi_call_virt(query_variable_info, *(u32 *)arg1,
-				       (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
+		status = efi_call_virt(query_variable_info,
+				       efi_rts_work.QUERY_VARIABLE_INFO.attr,
+				       efi_rts_work.QUERY_VARIABLE_INFO.storage_space,
+				       efi_rts_work.QUERY_VARIABLE_INFO.remaining_space,
+				       efi_rts_work.QUERY_VARIABLE_INFO.max_variable_size);
 		break;
 	case EFI_GET_NEXT_HIGH_MONO_COUNT:
-		status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
+		status = efi_call_virt(get_next_high_mono_count,
+				       efi_rts_work.GET_NEXT_HIGH_MONO_COUNT.high_count);
 		break;
 	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
-				       (efi_capsule_header_t **)arg1,
-				       *(unsigned long *)arg2,
-				       *(unsigned long *)arg3);
+				       efi_rts_work.UPDATE_CAPSULE.capsules,
+				       efi_rts_work.UPDATE_CAPSULE.count,
+				       efi_rts_work.UPDATE_CAPSULE.sg_list);
 		break;
 	case EFI_QUERY_CAPSULE_CAPS:
 		status = efi_call_virt(query_capsule_caps,
-				       (efi_capsule_header_t **)arg1,
-				       *(unsigned long *)arg2, (u64 *)arg3,
-				       (int *)arg4);
+				       efi_rts_work.QUERY_CAPSULE_CAPS.capsules,
+				       efi_rts_work.QUERY_CAPSULE_CAPS.count,
+				       efi_rts_work.QUERY_CAPSULE_CAPS.max_size,
+				       efi_rts_work.QUERY_CAPSULE_CAPS.reset_type);
 		break;
 	default:
 		/*
@@ -256,7 +255,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
+	status = efi_queue_work(GET_TIME, tm, tc);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -267,7 +266,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
+	status = efi_queue_work(SET_TIME, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -280,8 +279,7 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
-				NULL);
+	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -292,8 +290,7 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
-				NULL);
+	status = efi_queue_work(SET_WAKEUP_TIME, enabled, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -308,7 +305,7 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
+	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -322,8 +319,7 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
-				NULL, NULL);
+	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -338,7 +334,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
+	status = efi_queue_work(SET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -373,8 +369,8 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
-				remaining_space, max_variable_size, NULL);
+	status = efi_queue_work(QUERY_VARIABLE_INFO, attr, storage_space,
+				remaining_space, max_variable_size);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -405,8 +401,7 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
-				NULL, NULL);
+	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -437,8 +432,7 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
-				NULL, NULL);
+	status = efi_queue_work(UPDATE_CAPSULE, capsules, count, sg_list);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -455,13 +449,13 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
-				max_size, reset_type, NULL);
+	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, count,
+				max_size, reset_type);
 	up(&efi_runtime_lock);
 	return status;
 }
 
-void efi_native_runtime_setup(void)
+void __init efi_native_runtime_setup(void)
 {
 	efi.get_time = virt_efi_get_time;
 	efi.set_time = virt_efi_set_time;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ab088c662e88d07b..b34e11a5e969282c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1267,17 +1267,78 @@ enum efi_rts_ids {
 
 /*
  * efi_runtime_work:	Details of EFI Runtime Service work
- * @arg<1-5>:		EFI Runtime Service function arguments
  * @status:		Status of executing EFI Runtime Service
  * @efi_rts_id:		EFI Runtime Service function identifier
  * @efi_rts_comp:	Struct used for handling completions
  */
 struct efi_runtime_work {
-	void *arg1;
-	void *arg2;
-	void *arg3;
-	void *arg4;
-	void *arg5;
+	union {
+		struct {
+			efi_time_t 	*time;
+			efi_time_cap_t	*capabilities;
+		} GET_TIME;
+
+		struct {
+			efi_time_t	*time;
+		} SET_TIME;
+
+		struct {
+			efi_bool_t	*enabled;
+			efi_bool_t	*pending;
+			efi_time_t	*time;
+		} GET_WAKEUP_TIME;
+
+		struct {
+			efi_bool_t	enable;
+			efi_time_t	*time;
+		} SET_WAKEUP_TIME;
+
+		struct {
+			efi_char16_t	*name;
+			efi_guid_t	*vendor;
+			u32		*attr;
+			unsigned long	*data_size;
+			void		*data;
+		} GET_VARIABLE;
+
+		struct {
+			unsigned long	*name_size;
+			efi_char16_t	*name;
+			efi_guid_t 	*vendor;
+		} GET_NEXT_VARIABLE;
+
+		struct {
+			efi_char16_t	*name;
+			efi_guid_t	*vendor;
+			u32		attr;
+			unsigned long	data_size;
+			void		*data;
+		} SET_VARIABLE;
+
+		struct {
+			u32		attr;
+			u64		*storage_space;
+			u64		*remaining_space;
+			u64		*max_variable_size;
+		} QUERY_VARIABLE_INFO;
+
+		struct {
+			u32		*high_count;
+		} GET_NEXT_HIGH_MONO_COUNT;
+
+		struct {
+			efi_capsule_header_t **capsules;
+			unsigned long	count;
+			unsigned long	sg_list;
+		} UPDATE_CAPSULE;
+
+		struct {
+			efi_capsule_header_t **capsules;
+			unsigned long	count;
+			u64		*max_size;
+			int		*reset_type;
+		} QUERY_CAPSULE_CAPS;
+	};
 	efi_status_t status;
 	struct work_struct work;
 	enum efi_rts_ids efi_rts_id;
-- 
2.39.2

