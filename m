Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747977058F
	for <lists+linux-efi@lfdr.de>; Fri,  4 Aug 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHDQEY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Aug 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHDQEU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Aug 2023 12:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36204170F;
        Fri,  4 Aug 2023 09:04:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC7A62093;
        Fri,  4 Aug 2023 16:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8CC433CD;
        Fri,  4 Aug 2023 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165054;
        bh=8MKwhBmIaqRnOTNTAnqB7cv+QTDUMkVdbIqNneisNUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LR+OUnreBk43KxD5+EDBYFUcc0Xq0R79eoYrjovwzMAjxlh4xF6zhYPsBepxiSzKR
         ziP+7fMHZDBbU5jh0yBBE8nFX9EYmvcSIoGnAn/HPbkfM9EMEmnt+ZFCSfVXy02kF0
         NKyU45sC2eTxmk3As+inBfK2unoGtp2WtR75IYWoVOCfJ6EndmQUaiiJTzVWFjf31N
         2QXvB2ck/PnJxmQ92jlSP56QhB5Av9le7JUtylGwaoaIT/YqiZfMvjSUNWCWtWuqdC
         5+UYb3ufzfqFOjZvZlxmXPV6Dr02NHvnlYTlMfSDfNxJxplQD0+ys4kiiYSeUW/hoQ
         ex23wSrZTJD4Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/4] efi/runtime-wrapper: Move workqueue manipulation out of line
Date:   Fri,  4 Aug 2023 18:03:57 +0200
Message-Id: <20230804160359.228901-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804160359.228901-1-ardb@kernel.org>
References: <20230804160359.228901-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2863; i=ardb@kernel.org; h=from:subject; bh=8MKwhBmIaqRnOTNTAnqB7cv+QTDUMkVdbIqNneisNUo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWsYk6FxZF/q3wDT/w5ynzvgbF/0rOvvVfWLD/lzGcsy pXqu0mto5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkAScjw6/pn1avWbpkkcFs i3vi/x7K6pabh+bLOa0/o1nbH/Pw8TWG/zVS7DmXPrTu3WRYuv+C2UWD/VZGfS8Vvc8derMxput aHBMA
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
 drivers/firmware/efi/runtime-wrappers.c | 53 +++++++++++---------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 5d48d493f57e7c38..158685e26f430ac9 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -59,30 +59,7 @@ struct efi_runtime_work efi_rts_work;
 ({									\
 	efi_rts_work._rts = (typeof(efi_rts_work._rts)){ __VA_ARGS__ };	\
 	efi_rts_work.efi_rts_id = EFI_ ## _rts;				\
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
+	__efi_queue_work();						\
 })
 
 #ifndef arch_efi_save_flags
@@ -249,6 +226,34 @@ static void efi_call_rts(struct work_struct *work)
 	complete(&efi_rts_work.efi_rts_comp);
 }
 
+static efi_status_t __efi_queue_work(void)
+{
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

