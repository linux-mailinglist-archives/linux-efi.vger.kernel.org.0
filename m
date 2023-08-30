Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325F78D983
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjH3SdR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Aug 2023 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343987AbjH3Rvj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Aug 2023 13:51:39 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B19198
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 10:51:34 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1c8c1f34aadso6931386fac.3
        for <linux-efi@vger.kernel.org>; Wed, 30 Aug 2023 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693417893; x=1694022693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EYjQFc4xOJMLhqSY/15Eo/bkP9OF+XNV2qczMiBYtL4=;
        b=aw9dPjDYPDyipNtu8Wxx18Dx9m/0Xd2cYgG3isygHJfTvcaiF7aSiPVrgFXiAdlEHI
         MOl7xQcITcqAi8kEmkQZeVP9JhUFBg0Y2hDCV9jZsq8cACSTmPMEraSRDXAbcmMqdY2i
         WIxR+ba/wJ6bZ4wyPiOW4TzGS8jBpZLI0frOzSqPgjKqtpiZ5C6LI5lBoE9vfLzV13aj
         E4lG7ZDx8vddONjM/G4VsainecpOjvLzRVKLEvsU3WJDk6FNp5aQKPJ92qu7r95VTCNW
         9e/ENAlk22sgytAuyCk8508oyLXZ9kbfQeWujtLs4VjfCSWOuyAW6qgMT+vSnUCqFzcu
         fGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693417893; x=1694022693;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYjQFc4xOJMLhqSY/15Eo/bkP9OF+XNV2qczMiBYtL4=;
        b=B0oYHedvzNm9W1u8QlBmC+dAGa75va0Aq0lrUQgPl/yein+wHWY6/GIQCjdid93X8Q
         LfKwY7ctX4ExkXEDpS4r2KrbFTVJxmw6VaTzQ/E0NHAnsRbX4YKg9dZHFKH8MNLqDdv6
         1E3VW8sJQEJkdxd5B1jEBDIg41XZFJSCucl/Af/yegQGiOQUEc/rMkRzZNu65JJ7TRoC
         JpnrSmnnAZcT7ah5+tSG2R1Ok4Y4jzH6OcdNBoyghTO7EC9nqat1jOh3TBeahyvNSv7Y
         pra41afMeZv056zlggW+WSfFYCz4Hs4Nd2Dip1rHVyX+D5X/D7iV0BLaMT0wGXjps2is
         T3qg==
X-Gm-Message-State: AOJu0Yz2jMcVtx0MDCqu8v/HzphQOpbmrzbITREwCYEB+kKQZwIVZ05M
        rg3IFJ78g6KwR6XuHEmoVV3EEzT8JqGBtZ+Qsg==
X-Google-Smtp-Source: AGHT+IGL/3lcQ6hwMvsl4p1gk/LCm0paBP0RD6v6Kz3Tt1iisx7fE8BgSUyT/0wksBkGcJvZoAMVnrwDfWF9o8Lg1w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5b1b:b0:1c0:e9e9:ae91 with
 SMTP id ds27-20020a0568705b1b00b001c0e9e9ae91mr137879oab.3.1693417893238;
 Wed, 30 Aug 2023 10:51:33 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:51:29 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKCB72QC/32NTQrCMBSEr1Le2kh+TLWuvId0EZLX9EGblESCU
 nJ3Yw8gs/oG5psdMibCDPduh4SFMsXQQJ46sLMJHhm5xiC5VPwmB7ZSzhR8McmhXRhOxPSgeG+
 MndBdoA231Nr3IX2OjWfKr5g+x0cRv/avrgjWohzX2mgtrv3Dx+gXPNu4wlhr/QIVCrnRtQAAA A==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693417892; l=3644;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+vRGVRwlIjkmcXJXBfhvIJnVrDxDHX9+bhatyE7XQZE=; b=tEmNmV0Gd9vM2MDL3PKKkeIiRgAoxL8apKcKfw1CvhU6tPKZlGnans1x4nL4cCT6uVZeVgfd6
 lVCgmhdzg/wB7MReF69x2zwkmSByyHgiMvfwCsafFz90SSsJqUm4woN
X-Mailer: b4 0.12.3
Message-ID: <20230830-missingvardecl-efi-v2-1-818081a204d2@google.com>
Subject: [PATCH v2] efi: fix -Wmissing-variable-declarations warning
From:   Justin Stitt <justinstitt@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When building x86/defconfig with Clang-18 I encounter the following warnings:
| arch/x86/platform/efi/efi.c:934:23: warning: no previous extern declaration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-declarations]
|   934 | struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
| arch/x86/platform/efi/efi.c:935:23: warning: no previous extern declaration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-declarations]
|   935 | struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
| arch/x86/platform/efi/efi.c:936:23: warning: no previous extern declaration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-declarations]
|   936 | struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);

These symbols are declared extern in drivers/firmware/efi/efi.c. Move
the declarations to linux/efi.h to resolve these warnings.

Also, trim a trailing space from efi_set_variable_t typedef.

Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Don't use static. Instead move symbols to header file (thanks Ard)
- Remove duplicated warnings output from b4 (thanks Ard)
- Link to v1: https://lore.kernel.org/r/20230829-missingvardecl-efi-v1-1-13d055a55176@google.com
---
Note: build-tested.

Also, a question: Why does the compiler warn at all? The extern
declarations _do_ exist as Ard points out [1].

[1]: https://lore.kernel.org/all/CAMj1kXE_xs+wWno4G4U+6CFCOwO7JWcmNv4et5=W=ZRrQatWnQ@mail.gmail.com/
---
 drivers/firmware/efi/efi.c | 3 ---
 include/linux/efi.h        | 6 +++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1599f1176842..7b4e59ccf09e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -161,9 +161,6 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
 	return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
 }
 
-extern __weak struct kobj_attribute efi_attr_fw_vendor;
-extern __weak struct kobj_attribute efi_attr_runtime;
-extern __weak struct kobj_attribute efi_attr_config_table;
 static struct kobj_attribute efi_attr_fw_platform_size =
 	__ATTR_RO(fw_platform_size);
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ab088c662e88..32f7ca60b0e9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -287,7 +287,7 @@ typedef efi_status_t efi_get_variable_t (efi_char16_t *name, efi_guid_t *vendor,
 					 unsigned long *data_size, void *data);
 typedef efi_status_t efi_get_next_variable_t (unsigned long *name_size, efi_char16_t *name,
 					      efi_guid_t *vendor);
-typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor, 
+typedef efi_status_t efi_set_variable_t (efi_char16_t *name, efi_guid_t *vendor,
 					 u32 attr, unsigned long data_size,
 					 void *data);
 typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
@@ -632,6 +632,10 @@ typedef struct {
 
 extern unsigned long __ro_after_init efi_rng_seed;		/* RNG Seed table */
 
+extern __weak struct kobj_attribute efi_attr_fw_vendor;
+extern __weak struct kobj_attribute efi_attr_runtime;
+extern __weak struct kobj_attribute efi_attr_config_table;
+
 /*
  * All runtime access to EFI goes through this structure:
  */

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230829-missingvardecl-efi-59306aacfed4

Best regards,
--
Justin Stitt <justinstitt@google.com>

