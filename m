Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215BF19FC7D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDFSGS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 14:06:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35549 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgDFSGS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 14:06:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id k134so6606259qke.2;
        Mon, 06 Apr 2020 11:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZkbXCYZ38PnGLqA38jwgpd000NknHS2AO8++6TZ9nY=;
        b=owWnnOiRxSQ/6+JX2fBx4dFWsdBR4vxxQ+AOtZ03MFHst62RMIlBwqkwLFi5qp5bNh
         q7aVrEbZEvvBWvPqegsdYKqY/Mk0YSUK7VNZRoLydU+uxp4s8WAcuQrgXIeWkH5DvYoF
         88dFjGWcM6HABUwHcWhn9wOF+CYPGROsfGmHCOXoYeGnFBAk8ry94FicSBptPxpbxzSL
         RxbhwQaEDlN+RnVuqaYhNFK4f/mgIHQIx3H48NJtsuFUZcqAxM7zsYo2BiHq166j6+FE
         iNXyHODbu+A8J7yv+MiLstr6FrYo2S6KLxWfIY09CxXZYdO8SN7zHzMp+2CmL23E3i/Y
         R3NA==
X-Gm-Message-State: AGi0Pub1HCLswVUnFbNPBHDDjZtTE5DIktMGBeSZSyVEZmQ+qI+bi2Bv
        0ZjgOCYe6icZJxxhIlg7bWk=
X-Google-Smtp-Source: APiQypKifO/Mxe1FPDilzsVKjqJt5wQAgGegOGVre5EBI0Q0NcU77HvXJnXFI1OxUhI4edHVU3oaYw==
X-Received: by 2002:a37:4852:: with SMTP id v79mr21868104qka.459.1586196376781;
        Mon, 06 Apr 2020 11:06:16 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a136sm10548473qkc.75.2020.04.06.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:06:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
Date:   Mon,  6 Apr 2020 14:06:13 -0400
Message-Id: <20200406180614.429454-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
  bzImage")

removed the .bss section from the bzImage.

However, while a PE loader is required to zero-initialize the .bss
section before calling the PE entry point, the EFI handover protocol
does not currently document any requirement that .bss be initialized by
the bootloader prior to calling the handover entry.

When systemd-boot is used to boot a unified kernel image [1], the image
is constructed by embedding the bzImage as a .linux section in a PE
executable that contains a small stub loader from systemd together with
additional sections and potentially an initrd. As the .bss section
within the bzImage is no longer explicitly present as part of the file,
it is not initialized before calling the EFI handover entry.
Furthermore, as the size of the embedded .linux section is only the size
of the bzImage file itself, the .bss section's memory may not even have
been allocated.

In particular, this can result in efi_disable_pci_dma being true even
when it was not specified via the command line or configuration option,
which in turn causes crashes while booting on some systems.

To avoid issues, place all EFI stub global variables into the .data
section instead of .bss. As of this writing, only boolean flags for a
few command line arguments and the sys_table pointer were in .bss and
will now move into the .data section.

[1] https://systemd.io/BOOT_LOADER_SPECIFICATION/#type-2-efi-unified-kernel-images

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Sergey Shatunov <me@prok.pw>
Fixes: 3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from bzImage")
---
 drivers/firmware/efi/libstub/efistub.h  | 2 +-
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index cc90a748bcf0..67d26949fd26 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -25,7 +25,7 @@
 #define EFI_ALLOC_ALIGN		EFI_PAGE_SIZE
 #endif
 
-#ifdef CONFIG_ARM
+#if defined(CONFIG_ARM) || defined(CONFIG_X86)
 #define __efistub_global	__section(.data)
 #else
 #define __efistub_global
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d3a707789de..e7af6d2eddbf 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -20,7 +20,7 @@
 /* Maximum physical address for 64-bit kernel with 4-level paging */
 #define MAXMEM_X86_64_4LEVEL (1ull << 46)
 
-static efi_system_table_t *sys_table;
+static efi_system_table_t *sys_table __efistub_global;
 extern const bool efi_is64;
 extern u32 image_offset;
 
-- 
2.24.1

