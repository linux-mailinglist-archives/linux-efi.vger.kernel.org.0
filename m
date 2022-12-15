Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D808964DB4A
	for <lists+linux-efi@lfdr.de>; Thu, 15 Dec 2022 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLOMi5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Dec 2022 07:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLOMii (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Dec 2022 07:38:38 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D752EF60;
        Thu, 15 Dec 2022 04:38:25 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id DD69240737A3;
        Thu, 15 Dec 2022 12:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DD69240737A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1671107902;
        bh=SwDfOB+ZJqWv7uKClTclDaOfdPpVCbhrtUZIQmw7gCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAwf1a2qQRf9lp+O9D9yQUGIduGuX8cXxqrGHshJkLhrbTfq1ASqktpkIG7BH7Qob
         hum7FI1oWVWoOQXA0voiwp7xtezG3gSJj2av52VDkVak+EZN1n3Jcn/zZaUAA1VFO7
         efxCBUsd9HDzgkf/ofCGl7ugw3KV2ZrnauSRIrXo=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 03/26] x86/boot: Set cr0 to known state in trampoline
Date:   Thu, 15 Dec 2022 15:37:54 +0300
Message-Id: <c60d49a99889cb81e177ab9e756edcfa23182b3a.1671098103.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
References: <cover.1671098103.git.baskov@ispras.ru>
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

Ensure WP bit to be set to prevent boot code from writing to
non-writable memory pages.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Peter Jones <pjones@redhat.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_64.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a75712991df3..9f2e8f50fc71 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -660,9 +660,8 @@ SYM_CODE_START(trampoline_32bit_src)
 	pushl	$__KERNEL_CS
 	pushl	%eax
 
-	/* Enable paging again. */
-	movl	%cr0, %eax
-	btsl	$X86_CR0_PG_BIT, %eax
+	/* Enable paging and set CR0 to known state (this also sets WP flag) */
+	movl	$CR0_STATE, %eax
 	movl	%eax, %cr0
 
 	lret
-- 
2.37.4

