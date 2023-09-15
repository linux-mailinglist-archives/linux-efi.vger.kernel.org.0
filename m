Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293967A2474
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjIORR0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjIORRL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:11 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77210C7
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:05 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1518008f8f.1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798224; x=1695403024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=89g8O0FeFLI+vAm3VnFZD9BW/eMlaApKHGhLfa7SlGI=;
        b=mJFbom7EcXkoT7mtG4W1swRfcJVQ7IYGh92QWPk0kkAjGrnc+dUPBWerTuhQeP/f+B
         29eXnMuzVpypHoXEIStTpRde8TjiO/qpAUIAGNIwIO3xja9g4+pTs7BOdmxXbsSZoi9z
         A3FtRcW/irT+WLNHseaV0JRlzKw1NjB3mv4rFKhGFeBkWOyvT5rTntF/HYCC8+4ICOws
         L/veIH6cr4ySmk5GdaDVDEbXp1WJB2RoqzhlWQIzPzTS1G101c/dhnDshYwwGwQsNqcG
         BOuHY5XRt6CcOgRYm2l8aoZC454N0YwYRcqik8E1F2YTK8XBvxkfetr7e7Ym3UVTp0XN
         qy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798224; x=1695403024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89g8O0FeFLI+vAm3VnFZD9BW/eMlaApKHGhLfa7SlGI=;
        b=fqHLGo8ll8R3eoX3sGGBHoYXvPKFT1MDnDa6lblvdKXIAuLEBbWFBAb7vsreI28AVB
         KdO8oDIJxp1C09xFIF6iIG5zh5WhKUFn3hHywR/UsHPan9tTEA714olh1F/9t4y5bR1b
         7vmoEPJ5zcEvfTgM4Iy6YRbCFsLbozl+bUYLNqPSKZ5CVumN+cxx8ffmpd4XfNbmqWx8
         XQxNdUhPfCuameTCcY83Stt8lyfQLqBFXgGl7nh5SiaJHol4NHz4VcOK9S1r38JUnSCz
         C6pLgzY3PcF0f4lcVTNkfh5D0l0IJXP1Y5oFxeHU3Z+A+unx+TwBN5MgZTTU21kGaCyL
         JYPw==
X-Gm-Message-State: AOJu0YwthYGSfN5Ra5d3kOmmgIn/8MlbrSoGQofu6aCqVRTRkdJF+zI+
        ob1Wn+1LFGSma8e0pElemFkBRdT1BB9OJjhEBInfuEk9EeBBCe9JQOdIr5ii6BddhseVZp2u9Sh
        m4vQ0Lq8JJPWXc4aMauL/LFsiStY4cq7HkzChjh7k+u27h/ET8aCsgT6WP8T2
X-Google-Smtp-Source: AGHT+IFMSui6f+3/+Y4hY8Qz91p3kTgd5GjtcwDQx1xLiE0TLyDco4yn73I+CQFu3f+LXtULspQ/3LFq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4152:0:b0:319:6fc6:151 with SMTP id
 c18-20020a5d4152000000b003196fc60151mr26188wrq.10.1694798223502; Fri, 15 Sep
 2023 10:17:03 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:27 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=ardb@kernel.org;
 h=from:subject; bh=be7iDzl8pMuNbGRQpSLTpnBfKOp7BhO0eZKOBUcXTVM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYvarrBa1T7tCypYv8zz8v+iMLdPCvVM+nX3w+OanZ
 cFPl3uIdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJuDxn+KdeJ977bN5qft94
 28rfTS+DYouehc9+F5q8M2euULvph3mMDJPyd9+YwTAj3815m+mSQ4YOWgvWloc+1rurapWRerX Ngw0A
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-13-ardb@google.com>
Subject: [PATCH v3 3/8] x86/boot: Define setup size in linker script
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The setup block contains the real mode startup code that is used when
booting from a legacy BIOS, along with the boot_params/setup_data that
is used by legacy x86 bootloaders to pass the command line and initial
ramdisk parameters, among other things.

The setup block also contains the PE/COFF header of the entire combined
image, which includes the compressed kernel image, the decompressor and
the EFI stub.

This PE header describes the layout of the executable image in memory,
and currently, the fact that the setup block precedes it makes it rather
fiddly to get the right values into the right place in the final image.

Let's make things a bit easier by defining the setup_size in the linker
script so it can be referenced from the asm code directly, rather than
having to rely on the build tool to calculate it. For the time being,
add 64 bytes of fixed padding for the .reloc and .compat sections - this
will be removed in a subsequent patch after the PE/COFF header has been
reorganized.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_MIXED=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/setup.ld      | 4 ++++
 arch/x86/boot/tools/build.c | 6 ------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 72744ba440f6..06bd72a324c1 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -231,7 +231,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index b11c45b9e51e..9bd5c1ada599 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -39,6 +39,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
+
+		/* Reserve some extra space for the reloc and compat sections */
+		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 069497543164..745d64b6d930 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -48,12 +48,7 @@ typedef unsigned int   u32;
 u8 buf[SETUP_SECT_MAX*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
-
-#ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
@@ -388,7 +383,6 @@ int main(int argc, char ** argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
-- 
2.42.0.459.ge4e396fd5e-goog

