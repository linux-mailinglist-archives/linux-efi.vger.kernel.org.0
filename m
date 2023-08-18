Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1818E780D55
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377742AbjHROB2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377364AbjHRNpQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFEB4204;
        Fri, 18 Aug 2023 06:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A28666A97;
        Fri, 18 Aug 2023 13:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C2DC433C8;
        Fri, 18 Aug 2023 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366308;
        bh=RctLeH91sUvM0RywhiGBIOdDJRjXojQ3lHnfxJM0QOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItSRvMFooE//MKYJe2iZoiC6PNRAGDcz+ItiweHZApzUHXhcvKFvZkvSkUn0VauYI
         PTwyG/lHGEX/I6rmBPeoC3gEkRqRvqj6/DZpsa2UYio3R+LFZSL+c/DEGMdruGnhlK
         zhXQ0fFhlRPUm+FTCEy/qTHRW0FY4WkkB6ZdKw88wP+V1yjSYW2fGVj6pcijCoZPCP
         9zbrdPvuWJIofQH+WwWLd7Pp6qFZVyQikdJ3uzAX7ZZrrjORPABa/yz/w47hjEKjug
         QG2KHwCzNdT6VE/4E+QwMhI6HtNlE/1KciOFZG87NFZHQsh0DYfjniE7i9Fal65EZR
         KSUj3h8VIjADQ==
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
Subject: [PATCH 08/17] x86/boot: Drop references to startup_64
Date:   Fri, 18 Aug 2023 15:44:13 +0200
Message-Id: <20230818134422.380032-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=ardb@kernel.org; h=from:subject; bh=RctLeH91sUvM0RywhiGBIOdDJRjXojQ3lHnfxJM0QOk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6VLNjxZB+748FP8dIed4Xatw//3Yn5NTXgnJ5a7sv FZvcVujo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk6TJGhpXuX4K0/wqXzPx2 8aTzY5MjkzfsfdX4JCG3+YLszH0yElsYGd5lbnly7O0Po51l1w0EIlouHTaf9TCP9cxWhbVGb/f IezICAA==
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

The x86 boot image generation tool assign a default value to startup_64
and subsequently parses the actual value from zoffset.h but it never
actually uses the value anywhere. So remove this code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      | 2 +-
 arch/x86/boot/tools/build.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index f33e45ed143765f9..0e98bc5036994715 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 660627ea6cbb46f5..14ef13fe7ab021e7 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long startup_64;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -263,7 +262,6 @@ static void efi_stub_defaults(void)
 	efi_pe_entry = 0x10;
 #else
 	efi_pe_entry = 0x210;
-	startup_64 = 0x200;
 #endif
 }
 
@@ -338,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
-- 
2.39.2

