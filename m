Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6817D27D
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCHIKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIKH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:07 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4BC42072A;
        Sun,  8 Mar 2020 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583655007;
        bh=mjY+mhy5ip/EF4tM7wbe7FUn0QAZIdNhkYDMdzkX9vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gq597acox6U7vOw5T+6iC8AfeSGRpxkH1x83Hw0fotFT7AsBwqBGBiwv1nQUfA65N
         cvrNb+LejfR48KyCusNMpQggvNKsrfQpW+GybCPcl+Y4HjPn2NOmH4rMP2BJ1g9a8u
         IbHARRkEhrWgdtc56AMgavi5J9zjxMYNgC4F3UwY=
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
Subject: [PATCH 17/28] efi/x86: Add kernel preferred address to PE header
Date:   Sun,  8 Mar 2020 09:08:48 +0100
Message-Id: <20200308080859.21568-18-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Store the kernel's link address as ImageBase in the PE header. Note that
the PE specification requires the ImageBase to be 64k aligned. The
preferred address should almost always satisfy that, except for 32-bit
kernel if the configuration has been customized.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200303221205.4048668-4-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 4ee25e28996f..736b3a0c9454 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -138,10 +138,12 @@ optional_header:
 #endif
 
 extra_header_fields:
+	# PE specification requires ImageBase to be 64k-aligned
+	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	0				# ImageBase
+	.long	image_base			# ImageBase
 #else
-	.quad	0				# ImageBase
+	.quad	image_base			# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
-- 
2.17.1

