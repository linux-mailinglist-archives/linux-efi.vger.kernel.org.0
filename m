Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E479CADF
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjILJCM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjILJBe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:34 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8110DD
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:25 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31f87a56b46so1915268f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509284; x=1695114084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Om2Cn3Wg3jEi2eBnUxXdkE+0SAAFjVcdTV6CXbynWjo=;
        b=Oa376M75+hHQU3oSNPE6L/2+bNsIpDizK7qC/Q/co3h1w13CBUoTkFxyndACWnCT+m
         vriPifSPlg5iR77YLWiDNrzojTopfuU99o3/whbj4WTimNhJ5gClLGpp8bPAeWxG20lB
         RNbYPWr9g+9tWzrb0fg5iQfsqusrCdN1Cb6thC0qDuPXA5lF5uQQ86Q3KOjdLQK9jpxf
         O3MpFEDM4+g3eYEYbnsW+wli/16nbFIQ845Yd+IAGm70Tnqy8IM7EByV8PvSLeJqg4pO
         zDojjudD3iOrpzYsy0aG/HqKyp8L6yS4VM/KHyiVCSLmrYcSyThjP748niZOPOtoN57a
         vgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509284; x=1695114084;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Om2Cn3Wg3jEi2eBnUxXdkE+0SAAFjVcdTV6CXbynWjo=;
        b=lJ0WP94NDuRMgz14e1R4qySQm4VWVItoojH+UHgV2RWiAr7sf5r60tNXTIhxjupAK3
         9xtEC57FX2g5BuL3uM/r5ZgQ8mzAn142jNLFpdv3GIQ/8EtOo4YbGeho5dDz99r6G3cM
         +9CbAVC+sObgYlEIr0o0N6g8tVPkiShkNCyGA6BF33kqEijgbXYB1WDqXDTKHQCSO9vJ
         tpITzGg1D+T6Mo46LWHbZeYFmhGnBU7mmwJ8GvJbnkLNum+iboge502lRaY9JvPF3FtH
         ZnrNI35M8kKBwK3pLhU47KIzGJIbtlxLL3o0QgxbW9vpxCwPSZSrSJAFujKDLcHS0l+y
         0D4Q==
X-Gm-Message-State: AOJu0Yzhwgxch+5cXlZBh1nLNtftUrufAPQCqIIzx+qi4YYk6oqG6hcl
        MIgLb0uuu/Hyustxot4R0GuUA3f+NL5RZfSqgC+/lIHfWyrnjNJrL4jNhOklSKMli9UIXeyu3as
        03sRRySxFqzCtvJIutP4INEwJlCw5YXQZmrG0JMMhPSxfBmiKNRHA6bgm9jEw
X-Google-Smtp-Source: AGHT+IFlV1cfpOxh5HADBtaEpaYnpaKTI/Kysvfvx1KwDrWrD8DTXp/I88mfzwjsMIhnID61wzXJuHX2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:156b:b0:31f:a664:f871 with SMTP id
 11-20020a056000156b00b0031fa664f871mr73257wrz.9.1694509283538; Tue, 12 Sep
 2023 02:01:23 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:51 +0000
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3609; i=ardb@kernel.org;
 h=from:subject; bh=oz3m2uvlkSUrxw/YtPHMIWaPsH7+dyN5FRl9/bT5Ino=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB47DyoeO7uD6knGdYcS3d+UWwzvaLy/RNb3AG3IyqO
 qkS5vK9o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzETZeRYc2+Lf3cYSyxtX0M
 042DLk8xeDB9v+Dmm35nTjyrfaHFGMjwV4x7ytIvetmlh9ovBKb+NRE3zln0LH5vzY8pa1/+Wzp dmwEA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-17-ardb@google.com>
Subject: [PATCH v2 00/15] x86/boot: Rework PE header generation
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

Now that the EFI stub boot flow no longer relies on memory that is
executable and writable at the same time, we can reorganize the PE/COFF
view of the kernel image and expose the decompressor binary's code and
r/o data as a .text section and data/bss as a .data section, using 4k
alignment and limited permissions.

Doing so is necessary for compatibility with hardening measures that are
being rolled out on x86 PCs built to run Windows (i.e., the majority of
them). The EFI boot environment that the Linux EFI stub executes in is
especially sensitive to safety issues, given that a vulnerability in the
loader of one OS can be abused to attack another.

In true x86 fashion, this is a lot more complicated than on other
architectures, which have implemented this code/data split with 4k
alignment from the beginning. The complicating factor here is that the
boot image consists of two different parts, which are stitched together
and fixed up using a special build tool.

After this series is applied, the only remaining task performed by the
build tool is generating the CRC-32. Even though this checksum is
usually wrong (given that distro kernels are signed for secure boot in a
way that corrupts the CRC), this feature is retained as we cannot be
sure that nobody is relying on this.

This supersedes the work proposed by Evgeniy last year, which did a
major rewrite of the build tool in order to clean it up, before updating
it to generate the new 4k aligned image layout. As this series proves,
the build tool is mostly unnecessary, and we have too many of those
already.

Changes since v1:
- drop patch that removed the CRC and the build tool
- do not use fixed setup_size but derive it in the setup.ld linker
  script
- reorganize the PE header so the .compat section only covers its
  payload and the padding that follows it
- add hpa's ack to patch #4

Cc: Evgeniy Baskov <baskov@ispras.ru>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Jones <pjones@redhat.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>

Ard Biesheuvel (15):
  x86/efi: Drop EFI stub .bss from .data section
  x86/efi: Disregard setup header of loaded image
  x86/efi: Drop alignment flags from PE section headers
  x86/boot: Remove the 'bugger off' message
  x86/boot: Omit compression buffer from PE/COFF image memory footprint
  x86/boot: Drop redundant code setting the root device
  x86/boot: Grab kernel_info offset from zoffset header directly
  x86/boot: Drop references to startup_64
  x86/boot: Set EFI handover offset directly in header asm
  x86/boot: Define setup size in linker script
  x86/boot: Derive file size from _edata symbol
  x86/boot: Construct PE/COFF .text section from assembler
  x86/boot: Drop PE/COFF .reloc section
  x86/boot: Split off PE/COFF .data section
  x86/boot: Increase section and file alignment to 4k/512

 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
 arch/x86/boot/header.S                  | 213 ++++++---------
 arch/x86/boot/setup.ld                  |  14 +-
 arch/x86/boot/tools/build.c             | 273 +-------------------
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  46 +---
 7 files changed, 114 insertions(+), 447 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

