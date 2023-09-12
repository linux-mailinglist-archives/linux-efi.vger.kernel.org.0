Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811579CAF6
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjILJCz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjILJBy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA11720
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:51 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31f87a56b46so1915563f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509309; x=1695114109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pxvkm3fjui0uQ19XLsFsefYLwFlVrpXPWAZDN+LWTE=;
        b=gla9rwKALMpYxmJTaN2+NNQ4K8D8uIGj53cxr2zla9lxDbTvwX3m5Z3rNHYxst6p7U
         BQM13I8S18qdv62+fQ0v1Fv1+ldA/+5+hTEQQAWXjV3O4DdgdEMrAG9v8s57+u2R8g3G
         xbK7fp/C0Kj/N26VI+9mDI+ampbvpplnAPRwOFZ0loWfkzGqk4bKf7NuNF35Z/KzKVEb
         +0+1w1VHTRqQdyHceJgpuMuZNd13pxX4wr0W/B+HzxbNgmz0ArUmhbyXQNw+roNj4ItV
         PcUf4e5o1x1oG1WZzVlF8nBTfbDLIZT4tuUluVstU/xbInMLkvKp4NJ2spi0B4oqYstf
         8VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509309; x=1695114109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pxvkm3fjui0uQ19XLsFsefYLwFlVrpXPWAZDN+LWTE=;
        b=U6EMipGrJHLUnFUskUogmA89CYSHF22R+ro4fpLvG7xYq+yhUIYdr7UsZkYvO72URQ
         Hq82+K4NoQGvUzYOrQt5YmUUuKR8D3E2Qibd46EbIBLhw5IT+2gnCETiYsVFfRSbmtue
         vGP+C4L5zMV9ctdQHJvC8ZwvTJE/5++mPSaVwV1NWSjNSi6pukMbSoCX7TbDdeSvyQgk
         tfh5S+6R527E7BPPAWN8DOgOsY34keO9Az6GYxo3LPjyzBdKIPFOFEthZeP9txaf3Cr2
         ZQT7yScqndJBnSqAntJmuI+JTA2WBmOLPrenejtUeO0wocg4c9BPGZ5VKq4YkhntLUGA
         f3PA==
X-Gm-Message-State: AOJu0YzX+NSMS7liVnsIgkgAmI3UuX1TieLWe14CjJgIOSOx5EejGWwZ
        a9yOTiOjKeaOUxbsBZ5ZV36ar6F7JcQWI27d94ZgBpB2t7MFAiE0sOK8uCOCYONjmRvfotHlJ0a
        2FhDjRWYm9P9DmXdD8gC2ceufiCQwxU1t4h0LWVVsHar34ksJvrBFgw65hLg0
X-Google-Smtp-Source: AGHT+IFvTb/nIHB8mORKnV/nPgGPemOM7elWrN85fmi0GxRsmfTiHi50WYb/Dvn6Q3JUtwAUtdDGKvyh
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:620f:0:b0:31a:d5f3:b48d with SMTP id
 y15-20020a5d620f000000b0031ad5f3b48dmr149308wru.0.1694509309175; Tue, 12 Sep
 2023 02:01:49 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:01 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=ardb@kernel.org;
 h=from:subject; bh=s5KMXji/FHZoR+ppc6zDscgQADySQW7pqkG/qO49MnA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4/zk/+uX787+9yi5vkbbxPzqG4Y9XSnf43n+3Lhgw
 P+umulQRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIXj9Ghn9tAZZx3FZOy+w3
 vPi6sUZDypBX/cmd++LxU9kzbmZr6DEyfH5u4sGuX1fDIObcb93lM8Ugzfyed6F2woLO0h4/nTB eAA==
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-27-ardb@google.com>
Subject: [PATCH v2 10/15] x86/boot: Define setup size in linker script
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
index b11c45b9e51e..ae2b5046a0db 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -39,6 +39,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
+
+		/* reserve some extra space for the reloc and compat sections */
+		setup_size = ABSOLUTE(ALIGN(. + 64, 512));
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
2.42.0.283.g2d96d420d3-goog

