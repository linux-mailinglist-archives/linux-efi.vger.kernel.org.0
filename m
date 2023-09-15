Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B27A2472
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjIORRY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIORRE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 13:17:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A65186
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:16:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c4ec85ea9so850187b3.0
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798218; x=1695403018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+XiNiWEf251Iz3xOw4YUG2UqwBimdJvIy1HEfuEnSg=;
        b=J4MOPGm0NWXviE1DNk1bGezDYWUR0+MZZVfeO/SzRUalCn982h6AfVENFGOFlBGHbf
         RqYXVAw7d0B6d4jHL1xU7lhWDbqQM4xkIdsc7P7fzdyJ6ydnTsOzaf5b66segkZEykDO
         mYICrViLZykdF5/Elj+2evyvXjdNnzRGxdr1x5FAW7ZKbVTo+GVa8rDh4vkSTF1Ni9ZZ
         8YPoqMqri1nxjdr3HudaCbfxj2YWCjbVto26iRhDvO9HI3N4SOY/OrTdaq61LedcgSos
         hKljtXPshgVqIbnJ4hHmonhUztESA11Ye+DQzeFOyqd9ID954W6ISu9slWYzyJG9ekRL
         wuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798218; x=1695403018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+XiNiWEf251Iz3xOw4YUG2UqwBimdJvIy1HEfuEnSg=;
        b=uC9FICyCKnVrTr7F1oZxrYe+LzKwr6M+dwwlONnGDLZ20/XynbKs0yVN4SDe6IsQEy
         3hhLENYy39H4ftX5H0SZqnHQHYKzF4prjzRwg4hcJ62RwOlybOHW4FegjtvVsSB5PAc2
         JAkTYaQEvDLVhWb+oVzabBvjrU9SEllYxDwZTs66TJdPCOiux+SjVQ0pCTnwKP+YPQSi
         ONUqkwS8D1VCeOySMt8HmJnKwxKd7zRlN1/gKjXxFHw87r8YGbty/Jb182/Zdpb6lsJL
         hxPoPJm86P8Md5X15Cot+Wm1UrhgNip9pDOTYOkgYBv2Wt1GVHJL2UzflIhDq7Gg6wUs
         gAgw==
X-Gm-Message-State: AOJu0YxeqtmPUs4Wt52ASDTw6HPt+L3il6bCdcRtMT/M0HDDlJjOa+x5
        h6L6PT+lI1CCbjuphvDgBIsVqi6wVRFfUbc5Vy8jFBSBqAKeBiRcAZiuR3gg7aY1xELUWXvuv7p
        l+/ITu5fJJXl/+B/wJesh5fe6Ojiw/fZQxpwiO3admsNJRHbj3YMzCpx83iH5
X-Google-Smtp-Source: AGHT+IFOJ0KrqVILcHhkVKb6Ee13KgW6BNhCZT1TnEu+UQLY4mXifux8qVoAdpolqk1Asz1/Ln8fZ0IW
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:709:b0:586:a8ab:f8fe with SMTP id
 bs9-20020a05690c070900b00586a8abf8femr68945ywb.10.1694798217995; Fri, 15 Sep
 2023 10:16:57 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:25 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=ardb@kernel.org;
 h=from:subject; bh=ITMg7m1+VhxJhnxMcZQMFuDNZhrgfOlkladfzJ9STDE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYkbk2R871n31c7dvnOAdqVrx/UHtrNc3fvft75nLM
 yFAV2ZJRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiImTUjw4qplxN6n6czFWeq
 3N3+fuml0yfSPme4br5R7fW4K83gcwEjw47vMTZuL8KWKzlPu5SyMO/3/aXMUzWY6qrO7v+1IG7 naR4A
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-11-ardb@google.com>
Subject: [PATCH v3 1/8] x86/boot: Grab kernel_info offset from zoffset header directly
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Instead of parsing zoffset.h and poking the kernel_info offset value
into the header from the build tool, just grab the value directly in the
asm file that describes this header.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6059f87b159d..5575d0f06bab 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -526,7 +526,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 10b0207a6b18..14ef13fe7ab0 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -337,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -419,8 +417,6 @@ int main(int argc, char ** argv)
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.42.0.459.ge4e396fd5e-goog

