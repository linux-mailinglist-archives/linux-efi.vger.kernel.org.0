Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FB633B16
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiKVLSq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 06:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVLRf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 06:17:35 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CD6069E;
        Tue, 22 Nov 2022 03:14:50 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5DD6140737D3;
        Tue, 22 Nov 2022 11:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5DD6140737D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1669115686;
        bh=gi2WlP5Zdwk8PRGKzYD5z08u+9dLExeKMbf/xGGfE+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdIP03hTfI1NPSEvLMieLadei3nHwxitjzhDFs1oysvYyePn46+906Ot4745cHGst
         IaGVBW2lNi1wB8XP7f7X/4a8NaCKlORCVX6e8y9GH6kgsYYfn/+TiGmeNgYRGzloyw
         6WqHplq1pX/a8Vnb8HXX/mktbJo0UxhQ4BuNZlGI=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 24/24] efi/libstub: Make memory protection warnings include newlines
Date:   Tue, 22 Nov 2022 14:12:33 +0300
Message-Id: <0bcea49ef39c76f84ee9a79976c91aa6e94080fa.1668958803.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668958803.git.baskov@ispras.ru>
References: <cover.1668958803.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Peter Jones <pjones@redhat.com>

efi_warn() doesn't put newlines on messages, and that makes reading
warnings without newlines hard to do.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/libstub/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 35acec241dd3..d10996e4eb01 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -294,7 +294,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attr_clear);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to clear memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
@@ -307,7 +307,7 @@ efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 				rounded_end - rounded_start,
 				attributes);
 	if (status != EFI_SUCCESS) {
-		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx",
+		efi_warn("Failed to set memory attributes at [%08lx,%08lx]: %lx\n",
 			 (unsigned long)rounded_start,
 			 (unsigned long)rounded_end,
 			 status);
-- 
2.37.4

