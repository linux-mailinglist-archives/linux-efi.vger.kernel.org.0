Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFF78CFAD
	for <lists+linux-efi@lfdr.de>; Wed, 30 Aug 2023 00:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjH2Wyz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Aug 2023 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjH2WyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Aug 2023 18:54:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DBCC0
        for <linux-efi@vger.kernel.org>; Tue, 29 Aug 2023 15:54:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-591138c0978so69952597b3.1
        for <linux-efi@vger.kernel.org>; Tue, 29 Aug 2023 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693349658; x=1693954458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e68xEwQWGIFsiEZ8Cc18gaSHIqDjDEmFKH1LZa2ZSZk=;
        b=zTQ9j8aR9Q7AvermeptkUp1PJYnJhwukY73AHshzuS11PSBLcVNTE92ak5v5hnCIkH
         gaMkvBS+MLcG6f4VaP3FPrctySHmtOS7NJcND4URAFqAddGiHn+jUfcbNSHgF9TiZLHW
         WfOoERQ2tCDd0vF6CmenhgZE1BrO+9U3ZoVA0Dy9gqGVAOksX3gvWkqt1WboFoHrUIdb
         KXLaDJnx+oO8D0SKgkCTKnGcc4VVFwX1igMMu5I3HiGQX9kjcioIvymHswFA9Gv0afYy
         zs0rKuN+FrLkTDth6KP8inCyjFYzfhum2MKnTlfIsvxWBZNvw4B7IZZbtgfRc96czek5
         fzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349658; x=1693954458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e68xEwQWGIFsiEZ8Cc18gaSHIqDjDEmFKH1LZa2ZSZk=;
        b=CSv+qj3+zXzL3Hdhlagxy1zSbYrW3sbuZRS3P7sXhGan3UWdTgHFJT46mYVAyvdufG
         HzyygD+UniWF/iP005JlBkNzMucXRkAmLL48WmSwQ1N5MaLno+PNkok2DEPW2ShEck6g
         wiXjPBWpcy59rsAtRCUUlF5wwzLV1o8vekytaYMAfMP4JaeVgfMbNy8omHBuv2+LKb+9
         ZKYk01W80NT/0i3SOioS9Q688H7/grKLSgfMNyB9gvP1Smg+genXzA+ssiQCSZ5J5DQ6
         Qxk8VBsfzY5nStvrdXcXSIaIZue4fcJGU2SeqFQj1Sncz0yJAP1B1qbI3rHPxtwf8qG2
         6TXQ==
X-Gm-Message-State: AOJu0YxIylnN6XVqtjqBnw9akPnyocaasX40IqmqQpEdt/CgVMt85UWg
        PzSmnbwsVFafY8DWh9iVR8PawY6aQKjnBin9bA==
X-Google-Smtp-Source: AGHT+IG/JIrnHjdG28jE/M62PyLf+scrBP+H4c2KrzTOPNHnnRHb6xVVEKCTM9KuJkGySrjntjf5/M6KKpZKR4Sjmg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:721:b0:595:39a:5473 with SMTP
 id bt1-20020a05690c072100b00595039a5473mr13848ywb.10.1693349658701; Tue, 29
 Aug 2023 15:54:18 -0700 (PDT)
Date:   Tue, 29 Aug 2023 22:54:17 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABh37mQC/x2MWwqAIBAArxL73YLZg+wq0YfoZgtl4YIE0d2TP
 mdg5gGhxCQwVQ8kyix8xgJNXYHbbAyE7AuDVrpVozZ4sAjHkG3y5HaklbE3rRqsdSv5Dkp4pWL vfzov7/sBicZr7GQAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693349657; l=2922;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OwC+B+GNgc9dhPSD7pJZ0/IoryKIdNOlxgB9hvNA1Tg=; b=y+s/2YgZbeoG08PUHIP1YN0Ma9GbAgDoVRah9YuVOgWjsco0/r1VPASpue1GBJylwhBYK1v3k
 DJnXIKRALdPBSCuRD/76EzkmwuuF9V0bo5UhsDkBD+oDpflhrzjIaqJ
X-Mailer: b4 0.12.3
Message-ID: <20230829-missingvardecl-efi-v1-1-13d055a55176@google.com>
Subject: [PATCH] efi: fix -Wmissing-variable-declarations warning
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

These variables are not externally declared anywhere (AFAIK) so let's
add the static keyword and ensure we follow the ODR.

Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
When building x86/defconfig with Clang-18 I encounter the following warnings:
| arch/x86/platform/efi/efi.c:934:23: warning: no previous extern declaration for non-static variable 'efi_attr_fw_vendor' [-Wmissing-variable-declarations]
|   934 | struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
| arch/x86/platform/efi/efi.c:935:23: warning: no previous extern declaration for non-static variable 'efi_attr_runtime' [-Wmissing-variable-declarations]
|   935 | struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
| arch/x86/platform/efi/efi.c:936:23: warning: no previous extern declaration for non-static variable 'efi_attr_config_table' [-Wmissing-variable-declarations]
|   936 | struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
---
Note: build-tested.
---
 arch/x86/platform/efi/efi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e9f99c56f3ce..30c354c52ad4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -931,9 +931,9 @@ EFI_ATTR_SHOW(fw_vendor);
 EFI_ATTR_SHOW(runtime);
 EFI_ATTR_SHOW(config_table);
 
-struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
-struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
-struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
+static struct kobj_attribute efi_attr_fw_vendor = __ATTR_RO(fw_vendor);
+static struct kobj_attribute efi_attr_runtime = __ATTR_RO(runtime);
+static struct kobj_attribute efi_attr_config_table = __ATTR_RO(config_table);
 
 umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 {

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230829-missingvardecl-efi-59306aacfed4

Best regards,
--
Justin Stitt <justinstitt@google.com>

