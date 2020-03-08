Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F1217D26F
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCHIJo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCHIJm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:42 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B101621741;
        Sun,  8 Mar 2020 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654981;
        bh=SaEhDcvYVntNwVbKRTvlXMyzobCO4PJVj69U+i8AD4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIErOA+PMYAnbMVUbGrCZbKXWmnzrexMVUHhGVlPXk5I92Yq9vyYSk8aJfufQS+QA
         rZmwK3sxqNpXcBg+uwchvcJv8PNAnYbg9zWXKJZovg5NyEnPAw2KfHAdH+boZklBF2
         0bOpG+bxt0gwe3bfguDIzqFqermANsUHqxb74Lo4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 10/28] efi/x86: Respect 32-bit ABI in efi32_pe_entry
Date:   Sun,  8 Mar 2020 09:08:41 +0100
Message-Id: <20200308080859.21568-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

verify_cpu clobbers BX and DI. In case we have to return error, we need
to preserve them to respect 32-bit calling convention.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200301230436.2246909-3-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 86c97797bf78..25fa763f4e83 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -660,7 +660,11 @@ SYM_DATA(efi_is64, .byte 1)
 SYM_FUNC_START(efi32_pe_entry)
 	pushl	%ebp
 
+	pushl	%ebx
+	pushl	%edi
 	call	verify_cpu			// check for long mode support
+	popl	%edi
+	popl	%ebx
 	testl	%eax, %eax
 	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	jnz	3f
-- 
2.17.1

