Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5067CB05A
	for <lists+linux-efi@lfdr.de>; Mon, 16 Oct 2023 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjJPQxl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Oct 2023 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjJPQxa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Oct 2023 12:53:30 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AD018F
        for <linux-efi@vger.kernel.org>; Mon, 16 Oct 2023 09:46:41 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-4074f9d17a5so31231685e9.1
        for <linux-efi@vger.kernel.org>; Mon, 16 Oct 2023 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697474800; x=1698079600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5NAsKfvdpR7o/fc/F0bxwGfSu1nE/YWioD2w22rQv5Y=;
        b=hkqMNbI9W8lcCdKIZ49lTTsbHxNIZokNTGIFFHWZXjK+UFrOEgu3TP1unWEkZM1TXF
         6H+jEzAy8VmUEdK2LNDDU3NiqSRuo+1GrSYaHMTidf+oef4P3PpM5HBy9KRHTyBD3Gtq
         /hmP8ueQaQyyQLYliHWfb1Bb4axGn2MRXpOyVGI0ZlCyfiKkrjTfnkLabdrYnRY6UX9i
         rUNzKwbR+dsG2a244FBb50hbTiTl/cdqH1xdetWrIH7OfSpa3+s50ybW+WpRKUT0u4ei
         rf8XBoKfnkoP0Hb3gLSNtzFAflDLpBTNNJeDwG57AzriVqD4FUeUHS9LhFYMS7E/5OSp
         +xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474800; x=1698079600;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NAsKfvdpR7o/fc/F0bxwGfSu1nE/YWioD2w22rQv5Y=;
        b=dAbqeMX2ppVe+FrzBWaEi2bzJp56cG6xwkjrze1ODwWhlT8cupFQo2MicFvkOp3dmV
         JrwS5PZYUzYo8GQMEYJ7iNaHlHIXzoPYzqusq4UWvTj/kQSUMFURKmg2z/vlm6Edb/F5
         boiM71m/ei55ovm7Hh59NwXTWB4xdh8gv9XrHof8/ES2xqBe4oDCNnDNkUZWIfLZ5Q4d
         zAA4BnE51UlqY1ZNSligTAXWhc1DdsnLorhfBddl+maD6hvChQhlBevymsneuMoCgzi3
         oA3dCYSWzGToed7OgyB/TOfQCdwY+TwjzHIMMR/dsFO++y7ZX9Pz0BJJj/0/44BgUkWw
         9emA==
X-Gm-Message-State: AOJu0YyOITA+i8csEZ69e4mhKHA2W2QzdEw4U3e259jJJ5bit9fg5oJY
        DxDbHSPHrZkDHf0C1pfR3yi6YH34vsfAxBAtWe1IS5B3QTwuVaMh4dTyvr3GaNTpnvQQ4HQ8RuD
        hVdzwWR2y0PwcLeW68XoK5rhgnAeqyPRVbrg/hWjcsHvueTnD8C3XBgxvBd1F
X-Google-Smtp-Source: AGHT+IFzRWO27zgZjYtPzP7A1ZYuM4R9oQasDOmxJRVsWRpZpRpuwcrJ1zVbQsCpq7kSXapn+hC9T1+O
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:16cd:b0:32d:84c7:2f55 with SMTP id
 h13-20020a05600016cd00b0032d84c72f55mr171546wrf.9.1697474800185; Mon, 16 Oct
 2023 09:46:40 -0700 (PDT)
Date:   Mon, 16 Oct 2023 18:46:35 +0200
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=ardb@kernel.org;
 h=from:subject; bh=/7lDwn2xbTP/d3EtH5xf5T3ami+TBUlfh/hGKrukQrY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIVU349WOz07TTr0/r3SEbVtxi+GksMVR8W95vsxpFp/Q7
 Xr91rFDHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi2xoZGQ4ZXtv14+yW1A+7
 epd0hT+XMZF9EXlf6YxHx8llCxYcWSDEyLDP54GU6PWADO7juX9WmSsuu5EXss3c/8gtA46Kw0H 5D1kA
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231016164634.3514517-2-ardb@google.com>
Subject: [PATCH] x86/boot: efistub: Assign global boot_params variable
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
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

Now that the x86 EFI stub calls into some APIs exposed by the
decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
that the global boot_params variable is set correctly before doing so.

Note that the decompressor and the kernel proper carry conflicting
declarations for the global variable 'boot_params' so refer to it via an
alias to work around this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3bfc59637dd1..51407207ded5 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -812,12 +812,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       efi_system_table_t *sys_table_arg,
 			       struct boot_params *boot_params)
 {
+	extern struct boot_params *bpp asm("boot_params");
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
 	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
 	unsigned long kernel_entry;
 	efi_status_t status;
 
+	bpp = boot_params;
+
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-- 
2.42.0.655.g421f12c284-goog

