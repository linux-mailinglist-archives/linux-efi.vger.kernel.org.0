Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325D780B3A
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbjHRLiS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376704AbjHRLhx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A9C2112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C30E3640F0
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63734C433CD;
        Fri, 18 Aug 2023 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358671;
        bh=dRh3NP8y7a8E3QhMbZav03QbCefaGbpm8c96PU7BZH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxzrJqvII/pxST2il3WC4fPsuEGWSj52YkKw/yP4WH9LKI7MzFJsERmDG2CgsgXA+
         PT/Vuf9VRWy07yIu8VP2Pcbcvbs61jsEtsfH7HLxIbZ15E8LLq3UHLojVdzQK65jLV
         uJS5vfDEMUdfGfrUwfXo+Q+6H1QYdRpkG6ThXKqIht2LfJAEdwRQVoM36eaYJ1rFF/
         69/msHMrTTzMoHLLlK9tnjicA43DBsXQNYGODNhtNolQlaTodiAhFFX71r4Oqn6hSu
         CkIfNx1WaxMVScd3Stlppkh7UPwhstPq7oJ0OD8uuuZ9fxsdka3aHlES6UTYuUukiU
         KdcVyHBKuWdLQ==
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
Subject: [PATCH v2 05/11] efi/runtime-wrapper: Move workqueue manipulation out of line
Date:   Fri, 18 Aug 2023 13:37:18 +0200
Message-Id: <20230818113724.368492-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3197; i=ardb@kernel.org; h=from:subject; bh=dRh3NP8y7a8E3QhMbZav03QbCefaGbpm8c96PU7BZH8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++PvXDsnl/h+ZZts4L5/xhfWTnucfFrV4UYvU/MWb2 C1uhh3rKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMRuMrwTzUw9vIc1uX+J/6Z 3E/YqSFlbNOrx7KNd6s0w4e1p+9cqWH47/m36Yhke8b3RIeJFlkbmXmVraSMNYOv79hs3hUz0XA RGwA=
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

efi_queue_work() is a macro that implements the non-trivial manipulation
of the EFI runtime workqueue and completion data structure, most of
which is generic, and could be shared between all the users of the
macro. So move it out of the macro and into a new helper function.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/runtime-wrappers.c | 61 +++++++++++---------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 66066e058757c1b5..ee5c9a3e50604398 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -125,34 +125,8 @@ struct efi_runtime_work efi_rts_work;
  * thread waits for completion.
  */
 #define efi_queue_work(_rts, _args...)					\
-({									\
-	efi_rts_work.efi_rts_id = EFI_ ## _rts;				\
-	efi_rts_work.args = &(union efi_rts_args){ ._rts = { _args }};	\
-	efi_rts_work.status = EFI_ABORTED;				\
-									\
-	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
-		pr_warn_once("EFI Runtime Services are disabled!\n");	\
-		efi_rts_work.status = EFI_DEVICE_ERROR;			\
-		goto exit;						\
-	}								\
-									\
-	init_completion(&efi_rts_work.efi_rts_comp);			\
-	INIT_WORK(&efi_rts_work.work, efi_call_rts);			\
-									\
-	/*								\
-	 * queue_work() returns 0 if work was already on queue,         \
-	 * _ideally_ this should never happen.                          \
-	 */								\
-	if (queue_work(efi_rts_wq, &efi_rts_work.work))			\
-		wait_for_completion(&efi_rts_work.efi_rts_comp);	\
-	else								\
-		pr_err("Failed to queue work to efi_rts_wq.\n");	\
-									\
-	WARN_ON_ONCE(efi_rts_work.status == EFI_ABORTED);		\
-exit:									\
-	efi_rts_work.efi_rts_id = EFI_NONE;				\
-	efi_rts_work.status;						\
-})
+	__efi_queue_work(EFI_ ## _rts,					\
+			 &(union efi_rts_args){ ._rts = { _args }})
 
 #ifndef arch_efi_save_flags
 #define arch_efi_save_flags(state_flags)	local_save_flags(state_flags)
@@ -319,6 +293,37 @@ static void efi_call_rts(struct work_struct *work)
 	complete(&efi_rts_work.efi_rts_comp);
 }
 
+static efi_status_t __efi_queue_work(enum efi_rts_ids id,
+				     union efi_rts_args *args)
+{
+	efi_rts_work.efi_rts_id = id;
+	efi_rts_work.args = args;
+	efi_rts_work.status = EFI_ABORTED;
+
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
+		pr_warn_once("EFI Runtime Services are disabled!\n");
+		efi_rts_work.status = EFI_DEVICE_ERROR;
+		goto exit;
+	}
+
+	init_completion(&efi_rts_work.efi_rts_comp);
+	INIT_WORK(&efi_rts_work.work, efi_call_rts);
+
+	/*
+	 * queue_work() returns 0 if work was already on queue,
+	 * _ideally_ this should never happen.
+	 */
+	if (queue_work(efi_rts_wq, &efi_rts_work.work))
+		wait_for_completion(&efi_rts_work.efi_rts_comp);
+	else
+		pr_err("Failed to queue work to efi_rts_wq.\n");
+
+	WARN_ON_ONCE(efi_rts_work.status == EFI_ABORTED);
+exit:
+	efi_rts_work.efi_rts_id = EFI_NONE;
+	return efi_rts_work.status;
+}
+
 static efi_status_t virt_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
 {
 	efi_status_t status;
-- 
2.39.2

