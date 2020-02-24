Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EB16A5E7
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXMRo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 07:17:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgBXMRo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 24 Feb 2020 07:17:44 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444EF20866;
        Mon, 24 Feb 2020 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582546664;
        bh=4sZ0PYKHHFjGjhnZonEyKKQjDJ4zZiNH+ld8nAMN3p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABtroxQbAhO6jWfeqWHPUB9Aa5LO4JbUnmNLihBq1KiGRVT70/pQJeyj3keVwr/U0
         pY8WrcJiW0piT3f+k3YnZrD83NwOf6jPTJhQe1j7B2dbLBzxvaU/1auHo1GPXEJRep
         CWh0FWUxoJGyF+pne+BEEQKGRPh81FfigtFBk2UA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 2/5] efi/arm: Pass start and end addresses to cache_clean_flush()
Date:   Mon, 24 Feb 2020 13:17:30 +0100
Message-Id: <20200224121733.2202-3-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224121733.2202-1-ardb@kernel.org>
References: <20200224121733.2202-1-ardb@kernel.org>
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
 arch/arm/boot/compressed/head.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 39f7071d47c7..8487221bedb0 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1460,6 +1460,12 @@ ENTRY(efi_stub_entry)
 
 		@ Preserve return value of efi_entry() in r4
 		mov	r4, r0
+		add	r1, r4, #SZ_2M			@ DT end
+		bl	cache_clean_flush
+
+		ldr	r0, [sp]			@ relocated zImage
+		ldr	r1, =_edata			@ size of zImage
+		add	r1, r1, r0			@ end of zImage
 		bl	cache_clean_flush
 
 		@ The PE/COFF loader might not have cleaned the code we are
-- 
2.17.1

