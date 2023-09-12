Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D3279CAE6
	for <lists+linux-efi@lfdr.de>; Tue, 12 Sep 2023 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjILJCT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Sep 2023 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjILJBp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Sep 2023 05:01:45 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D8AA
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:41 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-2f2981b8364so3555181f8f.1
        for <linux-efi@vger.kernel.org>; Tue, 12 Sep 2023 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509299; x=1695114099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlDjqAuNn+SPHq8xKGkJiI8M+/8xOHIEwhHGCoqKsJ8=;
        b=kMlJmNURDQo7xhbIwQc0RneC9X1i4R3TrAWMz2IXJLGphXOIKDmLIpTVo0AVFlDMbO
         5KqG+ZW8HDUSdzG4I2Yc0hmBEJLDF2fOSLgnKrBpdMEiA6AAZTqqCmcitcC4lO7I+sRX
         ACwedzFZ3fqHq98/RURoYsTKIUhnmWxc0XO/N0WyxH7kbor3Ni3eO5GOthkvEfcgXlvZ
         bZipmYiCFtXUCTyATwUnnTgAQIisAeCyNOFBZZ2GgIZYH8O5MGb7A5to91bwHNA7yU9/
         Z1h9H7E+ZbgZ89cdszj6tiHoZVMnk8ELvMmdDi36hwiYmT1EX/MmCOWNR87qQPxgV5Hy
         BoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509299; x=1695114099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlDjqAuNn+SPHq8xKGkJiI8M+/8xOHIEwhHGCoqKsJ8=;
        b=pxtjGttNkUPHCfpce+7xIP2X5TgqFqrLE5xNc+glsZ4pyRA/ptLQ1ZyzeBlOUdr85G
         oA8126VwdPDvh2XYIiLeI0vjQUOaqccURa6nH7chilQr+gDhH2j1QR7QKBxvnrwG68yj
         lkZroTfJGReyQsvhR/w/kUVVdd3192DVaJI8j3Zw9osQMQLWM28Qz8bVSanutqOypZnZ
         xH20U+GuT/2q1dPtSibZcLvr+ojlcSruIRs2NaoKIeW2ZfWBIGz7UIvxBOdKOLHPwKsS
         J4XrBJWVJxeoRfbV/E/ocP5gSE7OkMt4RvtD6IBPNUT6/ngQhK33wMnTyIMtNI2ie4K1
         HANw==
X-Gm-Message-State: AOJu0YzZPyN+rMWCahlAsQDJbmY4A2Sw+A/jQ1kehQ8hqBtTyJ/Z0iXh
        fb5AkM9j6OvfLxmm+4ZekBCXyLKcLXuNEvCHA+uR+U4Lu5+hw8NxHfFTSYsnBPDygpsJQCp585a
        f3avqPLycEcTcBcK1oij8APgELXxf0ye2/c7VROEYBDl5aTh7P1UHBQOvGttc
X-Google-Smtp-Source: AGHT+IEFlFIMLNCJvhtnVvKAf+9hxBg4ZXdihbvjUd2emNqt13lwsGioEe+khkAhcvYcB47WAdv3/g67
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:6ace:0:b0:313:eb28:602 with SMTP id
 u14-20020a5d6ace000000b00313eb280602mr133683wrw.13.1694509299606; Tue, 12 Sep
 2023 02:01:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:57 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=ardb@kernel.org;
 h=from:subject; bh=AfG+aUI7K/0L+mw64Lzpmg/Sf5R/K8tGxwHtjeLluJ0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4/QE0Se3uP0dg7Nfrdy/Q4lfxrhW8IHbVubuDr/VW
 vFXEl90lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlsvcvwz/LLsTYr7cDyzLIg
 0cN80ifDzpWsE96YJv9m9YRTL7Xy2xj+KSzWt4rY92el6NI5v49OUtwQsn/JjyM279tyjhjpmG+ pZwQA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-23-ardb@google.com>
Subject: [PATCH v2 06/15] x86/boot: Drop redundant code setting the root device
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

The root device defaults to 0,0 and is no longer configurable at build
time [0], so there is no need for the build tool to ever write to this
field.

[0] 079f85e624189292 ("x86, build: Do not set the root_dev field in bzImage")

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a87d9133384b..6059f87b159d 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -236,7 +236,7 @@ root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
-root_dev:	.word 0			/* Filled in by build.c */
+root_dev:	.word 0			/* Default to major/minor 0/0 */
 boot_flag:	.word 0xAA55
 
 	# offset 512, entry point
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 0354c223e354..efa4e9c7d713 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -40,10 +40,6 @@ typedef unsigned char  u8;
 typedef unsigned short u16;
 typedef unsigned int   u32;
 
-#define DEFAULT_MAJOR_ROOT 0
-#define DEFAULT_MINOR_ROOT 0
-#define DEFAULT_ROOT_DEV (DEFAULT_MAJOR_ROOT << 8 | DEFAULT_MINOR_ROOT)
-
 /* Minimal number of setup sectors */
 #define SETUP_SECT_MIN 5
 #define SETUP_SECT_MAX 64
@@ -399,9 +395,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_setup_and_reloc(i);
 
-	/* Set the default root device */
-	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
-- 
2.42.0.283.g2d96d420d3-goog

