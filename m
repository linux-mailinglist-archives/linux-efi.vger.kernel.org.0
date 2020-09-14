Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90D92688DF
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgINJ5o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 05:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgINJ5k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Sep 2020 05:57:40 -0400
Received: from e123331-lin.nice.arm.com (unknown [37.6.197.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC47420731;
        Mon, 14 Sep 2020 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600077460;
        bh=TKAzFxIirDIxYLKYqD+6+dUlS9CQKVaHrk/5tQYGlrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkICpSKb6xO0VKoVM+24PwfMqMcyAc5VY534f4aYsk0mlyIwTsDxXXDFqvRY1Pw1q
         lHjz5BHkDOJL4hp4SrsAYA+ytLIuluK2IygS2mhgQg5FwebZ78krigh987/OJmXYia
         itPwELzY9tmQ6lTi0U9Sz2uMJ8JqqhzCpD4R05QQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Smith <Peter.Smith@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 04/12] ARM: head-common.S: use PC-relative insn sequence for __proc_info
Date:   Mon, 14 Sep 2020 12:56:58 +0300
Message-Id: <20200914095706.3985-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914095706.3985-1-ardb@kernel.org>
References: <20200914095706.3985-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Replace the open coded PC relative offset calculations with a pair of
adr_l invocations. This removes some open coded arithmetic involving
virtual addresses, avoids literal pools on v7+, and slightly reduces
the footprint of the code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/kernel/head-common.S | 22 ++++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 4a3982812a40..9a5ab6c19568 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -170,11 +170,12 @@ ENDPROC(lookup_processor_type)
  *	r9 = cpuid (preserved)
  */
 __lookup_processor_type:
-	adr	r3, __lookup_processor_type_data
-	ldmia	r3, {r4 - r6}
-	sub	r3, r3, r4			@ get offset between virt&phys
-	add	r5, r5, r3			@ convert virt addresses to
-	add	r6, r6, r3			@ physical address space
+	/*
+	 * Look in <asm/procinfo.h> for information about the __proc_info
+	 * structure.
+	 */
+	adr_l	r5, __proc_info_begin
+	adr_l	r6, __proc_info_end
 1:	ldmia	r5, {r3, r4}			@ value, mask
 	and	r4, r4, r9			@ mask wanted bits
 	teq	r3, r4
@@ -186,17 +187,6 @@ __lookup_processor_type:
 2:	ret	lr
 ENDPROC(__lookup_processor_type)
 
-/*
- * Look in <asm/procinfo.h> for information about the __proc_info structure.
- */
-	.align	2
-	.type	__lookup_processor_type_data, %object
-__lookup_processor_type_data:
-	.long	.
-	.long	__proc_info_begin
-	.long	__proc_info_end
-	.size	__lookup_processor_type_data, . - __lookup_processor_type_data
-
 __error_lpae:
 #ifdef CONFIG_DEBUG_LL
 	adr	r0, str_lpae
-- 
2.17.1

