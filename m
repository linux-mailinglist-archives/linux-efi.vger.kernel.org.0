Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4100812F78D
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgACLkV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgACLkU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:20 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BF2227BF;
        Fri,  3 Jan 2020 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051620;
        bh=Q8weF/ruccANz+AO9p5Pr5ibKl+2BRCize4l+859iBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKzWMJ3sXj5aMPCAFO9ldnSsZWwqlS6jfhWhT9E5IFN+Etoevmz9b/SaZj4HnXr6n
         04JwbjqnQf+QVUjYoHnoEFU8UJB1AXAmsi/YNlNr6MFhF5oxw647weHxtxhce2AM5x
         YHmrwhM5NR1qylSYfAQE1TSQoKhS8pdiCyj34e10=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 02/20] efi/libstub/x86: force 'hidden' visibility for extern declarations
Date:   Fri,  3 Jan 2020 12:39:35 +0100
Message-Id: <20200103113953.9571-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit c3710de5065d ("efi/libstub/x86: Drop __efi_early() export and
efi_config struct") introduced a reference from C code in eboot.c to
the startup_32 symbol defined in the .S startup code. This results in
a GOT based reference to startup_32, and since GOT entries carry
absolute addresses, they need to be fixed up before they can be used.

On modern toolchains (binutils 2.26 or later), this reference is
relaxed into a R_386_GOTOFF relocation (or the analogous X86_64 one)
which never uses the absolute address in the entry, and so we get
away with not fixing up the GOT table before calling the EFI entry
point. However, GCC 4.6 combined with a binutils of the era (2.24)
will produce a true GOT indirected reference, resulting in a wrong
value to be returned for the address of startup_32() if the boot
code is not running at the address it was linked at.

Fortunately, we can easily override this behavior, and force GCC to
emit the GOTOFF relocations explicitly, by setting the visibility
pragma 'hidden'.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index da04948d75ed..565ee4733579 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -6,6 +6,8 @@
  *
  * ----------------------------------------------------------------------- */
 
+#pragma GCC visibility push(hidden)
+
 #include <linux/efi.h>
 #include <linux/pci.h>
 
-- 
2.20.1

