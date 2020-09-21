Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABF272A6A
	for <lists+linux-efi@lfdr.de>; Mon, 21 Sep 2020 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgIUPle (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Sep 2020 11:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbgIUPld (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 Sep 2020 11:41:33 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1C520EDD;
        Mon, 21 Sep 2020 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600702893;
        bh=JiKsXBQnvKUuGUwchzbQj/4Vqb53KlGKDcJSTyI8K/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goTVIkGHU5WJaEcAB5ztCnARh52l7i0HR0xazEoumCszNaoTCYpdG8H6K8gIGKY1W
         TuJYRzsYZk0H5jcJ4BIzSceYzl8wPp6q0SELrimsmZBs3ck1em+mjDYe1e/MKVHgU+
         A9URO0MoIF4Q7gpN+VXpaibWGEKWxksdsOacB+b0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 06/10] ARM: p2v: drop redundant 'type' argument from __pv_stub
Date:   Mon, 21 Sep 2020 17:41:13 +0200
Message-Id: <20200921154117.757-7-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921154117.757-1-ardb@kernel.org>
References: <20200921154117.757-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We always pass the same value for 'type' so pull it into the __pv_stub
macro itself.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/memory.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 99035b5891ef..eb3c8e6e960a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -183,14 +183,14 @@ extern const void *__pv_table_begin, *__pv_table_end;
 #define PHYS_OFFSET	((phys_addr_t)__pv_phys_pfn_offset << PAGE_SHIFT)
 #define PHYS_PFN_OFFSET	(__pv_phys_pfn_offset)
 
-#define __pv_stub(from,to,instr,type)			\
+#define __pv_stub(from,to,instr)			\
 	__asm__("@ __pv_stub\n"				\
 	"1:	" instr "	%0, %1, %2\n"		\
 	"	.pushsection .pv_table,\"a\"\n"		\
 	"	.long	1b\n"				\
 	"	.popsection\n"				\
 	: "=r" (to)					\
-	: "r" (from), "I" (type))
+	: "r" (from), "I" (__PV_BITS_31_24))
 
 #define __pv_stub_mov_hi(t)				\
 	__asm__ volatile("@ __pv_stub_mov\n"		\
@@ -217,7 +217,7 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
 	phys_addr_t t;
 
 	if (sizeof(phys_addr_t) == 4) {
-		__pv_stub(x, t, "add", __PV_BITS_31_24);
+		__pv_stub(x, t, "add");
 	} else {
 		__pv_stub_mov_hi(t);
 		__pv_add_carry_stub(x, t);
@@ -235,7 +235,7 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 	 * assembler expression receives 32 bit argument
 	 * in place where 'r' 32 bit operand is expected.
 	 */
-	__pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
+	__pv_stub((unsigned long) x, t, "sub");
 	return t;
 }
 
-- 
2.17.1

