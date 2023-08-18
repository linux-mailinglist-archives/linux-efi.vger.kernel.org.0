Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C132780CC8
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377279AbjHRNpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377318AbjHRNpJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912A35A1;
        Fri, 18 Aug 2023 06:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2806687F;
        Fri, 18 Aug 2023 13:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F9CC433C8;
        Fri, 18 Aug 2023 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366301;
        bh=KXwq9TIexKeoFJMf73ZZ2z1OlZnYPznYgRrnV6bXa4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLC5PM2/bd0Na10cgxrtTKAf60DSaGbvPSENzA4JufqgeFKnbPlBPep2ohHyXsnjt
         NMoruYnpibsCo1qZivVfHLWQBgoFifPqmmOlUD3Bs/GKgQsHr93S5aOmV+ebDMREqC
         Y+qT+Rwe1GDsPdxorep9HcVw3f4g57ToogKZBzZdUMETk2Nwox2H9cGcRy8hlbXjCP
         BsNZcOl1fZqWae4nf27aBDLtSAii9YMOduA/2BC1zPbfZj8duOF+Kp53I/KPluGB1E
         XIbkvf2PqZpl5KnTltr3IxBbx8LXkgNaAfO8M/CNeCjRswXNdQ2DIK8EJkSFTzM7rN
         n8k4uDkIsheJg==
From:   Ard Biesheuvel <ardb@kernel.org>
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
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marvin=20H=C3=A4user?= <mhaeuser@posteo.de>
Subject: [PATCH 06/17] x86/boot: Drop redundant code setting the root device
Date:   Fri, 18 Aug 2023 15:44:11 +0200
Message-Id: <20230818134422.380032-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=ardb@kernel.org; h=from:subject; bh=KXwq9TIexKeoFJMf73ZZ2z1OlZnYPznYgRrnV6bXa4k=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6UKb7y/004Qcrdsz5D5VJLf6Pe7U/rXmwwINuUh76 W3z5n/oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM528TwP6184/+gw+me9U4+ N/YdP9Vcb/XBY9H/muPWDAlrn1hKPGP4Z/+z8fvy84w1YdeK9/mbWTZ2J3THLfGScl4oEb0u0+Q /LwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The root device defaults to 0,0 and is no longer configurable at build
time [0], so there is no need for the build tool to ever write to this
field.

[0] 079f85e624189292 ("x86, build: Do not set the root_dev field in bzImage")

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a87d9133384b0986..6059f87b159d0e14 100644
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
index 0354c223e35492b6..efa4e9c7d7135ba7 100644
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
2.39.2

