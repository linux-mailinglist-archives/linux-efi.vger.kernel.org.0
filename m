Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5E17D26E
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgCHIJj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCHIJj (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:39 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1451D2087F;
        Sun,  8 Mar 2020 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654978;
        bh=N3ykKbjmMsOgUT9bUNFOnZD9DZ8jRnIwNCMFWKhA1+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZ/OF78HpwSHJhCutWsZY9f4M1ABm3OaBGeDFRvFKRS4Tbb24LXxLYEGJufbZJwSv
         98fTWUys7Ev4R7MgWwYtkn8QKW6ZpYp9miqFNjCq9DPoSLvxU9LYz5J7rCZq4N+Ypt
         dyosg9KrQF4SD3h0iZUx1GT9hJD3MA1p/JE2/JhY=
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
Subject: [PATCH 09/28] efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
Date:   Sun,  8 Mar 2020 09:08:40 +0100
Message-Id: <20200308080859.21568-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

Use SYM_DATA* macro to annotate this constant, and explicitly align it
to 4-byte boundary. Use lower-case for hexadecimal data.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200301230436.2246909-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f7bacc4c1494..86c97797bf78 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -672,7 +672,7 @@ SYM_FUNC_START(efi32_pe_entry)
 	/* Get the loaded image protocol pointer from the image handle */
 	subl	$12, %esp			// space for the loaded image pointer
 	pushl	%esp				// pass its address
-	leal	4f(%ebp), %eax
+	leal	loaded_image_proto(%ebp), %eax
 	pushl	%eax				// pass the GUID address
 	pushl	28(%esp)			// pass the image handle
 
@@ -695,9 +695,12 @@ SYM_FUNC_END(efi32_pe_entry)
 
 	.section ".rodata"
 	/* EFI loaded image protocol GUID */
-4:	.long	0x5B1B31A1
+	.balign 4
+SYM_DATA_START_LOCAL(loaded_image_proto)
+	.long	0x5b1b31a1
 	.word	0x9562, 0x11d2
-	.byte	0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B
+	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
+SYM_DATA_END(loaded_image_proto)
 #endif
 
 /*
-- 
2.17.1

