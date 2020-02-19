Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977E41640A2
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBSJnw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 04:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJnw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 04:43:52 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D563F24673;
        Wed, 19 Feb 2020 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582105432;
        bh=lFzKo6clSyD9Mf7ZXBNhtebcK98cxJK95ASmc7qCv0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9Q+7DQ1awwTlQX09DLd8nNQb5ZjSnu+WpmzHjy4nZvjaCi2xkMZtt9CQZ/iInqdf
         LMjgojxE/VsHoeND4tW+uiVOZAL7IRCXt+nv42rA4apeUiqN4v09RaoOLOHU8AS90H
         0gl4230tZ79ryLkkvlJNmq9Fv7pIhI3GYZGyJFPE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 2/4] efi/arm: pass start and end addresses to cache_clean_flush()
Date:   Wed, 19 Feb 2020 10:43:38 +0100
Message-Id: <20200219094340.16597-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219094340.16597-1-ardb@kernel.org>
References: <20200219094340.16597-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for turning the decompressor's cache clean/flush
operations into proper by-VA maintenance for v7 cores, pass the
start and end addresses of the regions that need cache maintenance
into cache_clean_flush in registers r0 and r1.

Currently, all implementations of cache_clean_flush ignore these
values, so no functional change is expected as a result of this
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/boot/compressed/head.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6c98d3d2de2f..c11b1b0a3ac6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1460,6 +1460,13 @@ ENTRY(efi_stub_entry)
 
 		@ Preserve return value of efi_entry() in r4
 		mov	r4, r0
+		add	r1, r4, #SZ_2M			@ DT end
+		bl	cache_clean_flush
+
+		ldr	r0, [sp]			@ relocated zImage
+		adr	r2, __edata
+		ldr	r1, [r2]
+		add	r1, r1, r2			@ end of image
 		bl	cache_clean_flush
 
 		@ The PE/COFF loader might not have cleaned the code we are
@@ -1489,6 +1496,8 @@ efi_load_fail:
 		ldr	r0, =0x80000001
 		ldmfd	sp!, {ip, pc}
 ENDPROC(efi_stub_entry)
+		.align	2
+__edata:	.long	_edata - .
 #endif
 
 		.align
-- 
2.17.1

