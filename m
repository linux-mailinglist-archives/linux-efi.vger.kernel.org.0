Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91747780B37
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376695AbjHRLiS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376683AbjHRLhu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB32112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCA561182
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DFDC433C7;
        Fri, 18 Aug 2023 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358667;
        bh=hIrpLUZn61H+w4Z7crgigBTzE60wQK9ejIhnxwawVW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKxv9Mq1AmgwkeMpHQvH4vvzjyfDrkbvtEWhAZRk7CWTDYlh2Xnht6vGM8k8lkT0d
         ZGAVwwdO++uJyHoQq0k76QDgOmihkrnNVeiIaFYS8GvVQRCCH3QhAIoR8g3DWYW2rZ
         uGwqE0WaLxa6rf+lhr9j5qSgaKDhVb6djSDiVsxNBVErRA04Xdzi32fpmka5qB/7Jl
         hHwuJoDtLKxksXXJReN/iMUaUQHLIVpJ9zHxmfW1KcW4P+oIdHonUUV3cWAk8/E4M4
         y8EuLOtDC8+Q5p01L5hx1jMiVgploPefRMPXcldh1lO6pKxY5YGTfGCLqCrciPzSex
         ynhb7fD1ZMKdA==
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
Subject: [PATCH v2 04/11] efi/runtime-wrappers: Use type safe encapsulation of call arguments
Date:   Fri, 18 Aug 2023 13:37:17 +0200
Message-Id: <20230818113724.368492-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13469; i=ardb@kernel.org; h=from:subject; bh=hIrpLUZn61H+w4Z7crgigBTzE60wQK9ejIhnxwawVW4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++Lvs1bK/Pr84UV+6eVWNsHTG2uoLrPMOn951IjbjT mLkWiW5jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRn6cZ/nBb9QbN4/4189PG yEWCd3qFmKPT5n4qPVSdl6dSu1erLo+RYXUMV2XFfJ+8/esS89plJWt//5CTnmn2dV7TnSxVwUl LGAA=
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
 drivers/firmware/efi/runtime-wrappers.c | 196 +++++++++++++-------
 include/linux/efi.h                     |  18 +-
 2 files changed, 138 insertions(+), 76 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index a400c4312c829f18..66066e058757c1b5 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -44,20 +44,90 @@
 #define __efi_call_virt(f, args...) \
 	__efi_call_virt_pointer(efi.runtime, f, args)
 
+union efi_rts_args {
+	struct {
+		efi_time_t 	*time;
+		efi_time_cap_t	*capabilities;
+	} GET_TIME;
+
+	struct {
+		efi_time_t	*time;
+	} SET_TIME;
+
+	struct {
+		efi_bool_t	*enabled;
+		efi_bool_t	*pending;
+		efi_time_t	*time;
+	} GET_WAKEUP_TIME;
+
+	struct {
+		efi_bool_t	enable;
+		efi_time_t	*time;
+	} SET_WAKEUP_TIME;
+
+	struct {
+		efi_char16_t	*name;
+		efi_guid_t	*vendor;
+		u32		*attr;
+		unsigned long	*data_size;
+		void		*data;
+	} GET_VARIABLE;
+
+	struct {
+		unsigned long	*name_size;
+		efi_char16_t	*name;
+		efi_guid_t 	*vendor;
+	} GET_NEXT_VARIABLE;
+
+	struct {
+		efi_char16_t	*name;
+		efi_guid_t	*vendor;
+		u32		attr;
+		unsigned long	data_size;
+		void		*data;
+	} SET_VARIABLE;
+
+	struct {
+		u32		attr;
+		u64		*storage_space;
+		u64		*remaining_space;
+		u64		*max_variable_size;
+	} QUERY_VARIABLE_INFO;
+
+	struct {
+		u32		*high_count;
+	} GET_NEXT_HIGH_MONO_COUNT;
+
+	struct {
+		efi_capsule_header_t **capsules;
+		unsigned long	count;
+		unsigned long	sg_list;
+	} UPDATE_CAPSULE;
+
+	struct {
+		efi_capsule_header_t **capsules;
+		unsigned long	count;
+		u64		*max_size;
+		int		*reset_type;
+	} QUERY_CAPSULE_CAPS;
+};
+
 struct efi_runtime_work efi_rts_work;
 
 /*
- * efi_queue_work:	Queue efi_runtime_service() and wait until it's done
- * @rts:		efi_runtime_service() function identifier
- * @rts_arg<1-5>:	efi_runtime_service() function arguments
+ * efi_queue_work:	Queue EFI runtime service call and wait for completion
+ * @_rts:		EFI runtime service function identifier
+ * @_args:		Arguments to pass to the EFI runtime service
  *
  * Accesses to efi_runtime_services() are serialized by a binary
  * semaphore (efi_runtime_lock) and caller waits until the work is
  * finished, hence _only_ one work is queued at a time and the caller
  * thread waits for completion.
  */
-#define efi_queue_work(_rts, _arg1, _arg2, _arg3, _arg4, _arg5)		\
+#define efi_queue_work(_rts, _args...)					\
 ({									\
+	efi_rts_work.efi_rts_id = EFI_ ## _rts;				\
+	efi_rts_work.args = &(union efi_rts_args){ ._rts = { _args }};	\
 	efi_rts_work.status = EFI_ABORTED;				\
 									\
 	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
@@ -68,12 +138,6 @@ struct efi_runtime_work efi_rts_work;
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
@@ -170,73 +234,78 @@ extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
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
+	const union efi_rts_args *args = efi_rts_work.args;
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
+				       args->GET_TIME.time,
+				       args->GET_TIME.capabilities);
 		break;
 	case EFI_SET_TIME:
-		status = efi_call_virt(set_time, (efi_time_t *)arg1);
+		status = efi_call_virt(set_time,
+				       args->SET_TIME.time);
 		break;
 	case EFI_GET_WAKEUP_TIME:
-		status = efi_call_virt(get_wakeup_time, (efi_bool_t *)arg1,
-				       (efi_bool_t *)arg2, (efi_time_t *)arg3);
+		status = efi_call_virt(get_wakeup_time,
+				       args->GET_WAKEUP_TIME.enabled,
+				       args->GET_WAKEUP_TIME.pending,
+				       args->GET_WAKEUP_TIME.time);
 		break;
 	case EFI_SET_WAKEUP_TIME:
-		status = efi_call_virt(set_wakeup_time, *(efi_bool_t *)arg1,
-				       (efi_time_t *)arg2);
+		status = efi_call_virt(set_wakeup_time,
+				       args->SET_WAKEUP_TIME.enable,
+				       args->SET_WAKEUP_TIME.time);
 		break;
 	case EFI_GET_VARIABLE:
-		status = efi_call_virt(get_variable, (efi_char16_t *)arg1,
-				       (efi_guid_t *)arg2, (u32 *)arg3,
-				       (unsigned long *)arg4, (void *)arg5);
+		status = efi_call_virt(get_variable,
+				       args->GET_VARIABLE.name,
+				       args->GET_VARIABLE.vendor,
+				       args->GET_VARIABLE.attr,
+				       args->GET_VARIABLE.data_size,
+				       args->GET_VARIABLE.data);
 		break;
 	case EFI_GET_NEXT_VARIABLE:
-		status = efi_call_virt(get_next_variable, (unsigned long *)arg1,
-				       (efi_char16_t *)arg2,
-				       (efi_guid_t *)arg3);
+		status = efi_call_virt(get_next_variable,
+				       args->GET_NEXT_VARIABLE.name_size,
+				       args->GET_NEXT_VARIABLE.name,
+				       args->GET_NEXT_VARIABLE.vendor);
 		break;
 	case EFI_SET_VARIABLE:
-		status = efi_call_virt(set_variable, (efi_char16_t *)arg1,
-				       (efi_guid_t *)arg2, *(u32 *)arg3,
-				       *(unsigned long *)arg4, (void *)arg5);
+		status = efi_call_virt(set_variable,
+				       args->SET_VARIABLE.name,
+				       args->SET_VARIABLE.vendor,
+				       args->SET_VARIABLE.attr,
+				       args->SET_VARIABLE.data_size,
+				       args->SET_VARIABLE.data);
 		break;
 	case EFI_QUERY_VARIABLE_INFO:
-		status = efi_call_virt(query_variable_info, *(u32 *)arg1,
-				       (u64 *)arg2, (u64 *)arg3, (u64 *)arg4);
+		status = efi_call_virt(query_variable_info,
+				       args->QUERY_VARIABLE_INFO.attr,
+				       args->QUERY_VARIABLE_INFO.storage_space,
+				       args->QUERY_VARIABLE_INFO.remaining_space,
+				       args->QUERY_VARIABLE_INFO.max_variable_size);
 		break;
 	case EFI_GET_NEXT_HIGH_MONO_COUNT:
-		status = efi_call_virt(get_next_high_mono_count, (u32 *)arg1);
+		status = efi_call_virt(get_next_high_mono_count,
+				       args->GET_NEXT_HIGH_MONO_COUNT.high_count);
 		break;
 	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
-				       (efi_capsule_header_t **)arg1,
-				       *(unsigned long *)arg2,
-				       *(unsigned long *)arg3);
+				       args->UPDATE_CAPSULE.capsules,
+				       args->UPDATE_CAPSULE.count,
+				       args->UPDATE_CAPSULE.sg_list);
 		break;
 	case EFI_QUERY_CAPSULE_CAPS:
 		status = efi_call_virt(query_capsule_caps,
-				       (efi_capsule_header_t **)arg1,
-				       *(unsigned long *)arg2, (u64 *)arg3,
-				       (int *)arg4);
+				       args->QUERY_CAPSULE_CAPS.capsules,
+				       args->QUERY_CAPSULE_CAPS.count,
+				       args->QUERY_CAPSULE_CAPS.max_size,
+				       args->QUERY_CAPSULE_CAPS.reset_type);
 		break;
 	default:
 		/*
@@ -256,7 +325,7 @@ static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_TIME, tm, tc, NULL, NULL, NULL);
+	status = efi_queue_work(GET_TIME, tm, tc);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -267,7 +336,7 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_TIME, tm, NULL, NULL, NULL, NULL);
+	status = efi_queue_work(SET_TIME, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -280,8 +349,7 @@ static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_WAKEUP_TIME, enabled, pending, tm, NULL,
-				NULL);
+	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -292,8 +360,7 @@ static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_WAKEUP_TIME, &enabled, tm, NULL, NULL,
-				NULL);
+	status = efi_queue_work(SET_WAKEUP_TIME, enabled, tm);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -308,7 +375,7 @@ static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_VARIABLE, name, vendor, attr, data_size,
+	status = efi_queue_work(GET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -322,8 +389,7 @@ static efi_status_t virt_efi_get_next_variable(unsigned long *name_size,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_NEXT_VARIABLE, name_size, name, vendor,
-				NULL, NULL);
+	status = efi_queue_work(GET_NEXT_VARIABLE, name_size, name, vendor);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -338,7 +404,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_SET_VARIABLE, name, vendor, &attr, &data_size,
+	status = efi_queue_work(SET_VARIABLE, name, vendor, attr, data_size,
 				data);
 	up(&efi_runtime_lock);
 	return status;
@@ -373,8 +439,8 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_QUERY_VARIABLE_INFO, &attr, storage_space,
-				remaining_space, max_variable_size, NULL);
+	status = efi_queue_work(QUERY_VARIABLE_INFO, attr, storage_space,
+				remaining_space, max_variable_size);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -405,8 +471,7 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_GET_NEXT_HIGH_MONO_COUNT, count, NULL, NULL,
-				NULL, NULL);
+	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -437,8 +502,7 @@ static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_UPDATE_CAPSULE, capsules, &count, &sg_list,
-				NULL, NULL);
+	status = efi_queue_work(UPDATE_CAPSULE, capsules, count, sg_list);
 	up(&efi_runtime_lock);
 	return status;
 }
@@ -455,8 +519,8 @@ static efi_status_t virt_efi_query_capsule_caps(efi_capsule_header_t **capsules,
 
 	if (down_interruptible(&efi_runtime_lock))
 		return EFI_ABORTED;
-	status = efi_queue_work(EFI_QUERY_CAPSULE_CAPS, capsules, &count,
-				max_size, reset_type, NULL);
+	status = efi_queue_work(QUERY_CAPSULE_CAPS, capsules, count,
+				max_size, reset_type);
 	up(&efi_runtime_lock);
 	return status;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ab088c662e88d07b..b8c446da608371d2 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1265,23 +1265,21 @@ enum efi_rts_ids {
 	EFI_QUERY_CAPSULE_CAPS,
 };
 
+union efi_rts_args;
+
 /*
  * efi_runtime_work:	Details of EFI Runtime Service work
- * @arg<1-5>:		EFI Runtime Service function arguments
+ * @args:		Pointer to union describing the arguments
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
-	efi_status_t status;
-	struct work_struct work;
-	enum efi_rts_ids efi_rts_id;
-	struct completion efi_rts_comp;
+	union efi_rts_args	*args;
+	efi_status_t		status;
+	struct work_struct	work;
+	enum efi_rts_ids	efi_rts_id;
+	struct completion	efi_rts_comp;
 };
 
 extern struct efi_runtime_work efi_rts_work;
-- 
2.39.2

