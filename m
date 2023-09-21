Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317C7AA272
	for <lists+linux-efi@lfdr.de>; Thu, 21 Sep 2023 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjIUVRQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Sep 2023 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjIUVQN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Sep 2023 17:16:13 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00B8AC3F6
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 11:01:56 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4526d872941so671649137.1
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319316; x=1695924116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/sF+QqiplgSBso/5vnIDx564mKj+3dahN17Ytb8x4c=;
        b=a2YteJb9WNkUbm7crxrTBS+cnkJ3m/AE7Zg+BTp2Cfxa/82OZISZ/ptzmbnbudlgNZ
         dZ0x33SLrytDbNsLcWqvV2MQggRsH1bRfA025Iu7bUDC0Yn3+hQZ0/Q27qUR5HXwPLkN
         Bh2hxelKaapQLHX7m+c5EA8RaBfd9cDrbt/rcn9B4oRryEI8xm37JtTURlgyXbnqPgWW
         pcW+FsjP6r/Gd00AtKvc5T+VVnBbtz/tSKzxFYywUcztPZUrXcEe3A3ZxmukLC3XaNJ0
         i+vOkjIJqxcsPcHGyjoOFIhCDdBs4D6QSDQ9OoDz5NLeY1yT4/xwyDJPEfcRtSMDTQlS
         fQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319316; x=1695924116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/sF+QqiplgSBso/5vnIDx564mKj+3dahN17Ytb8x4c=;
        b=HG4ujjy8nBl2ynx5uBLKVQH+cXYhqw7+OdSoyIR0sIj1geu5BBZQeaSwE9yuICD42F
         XJdsfaaGa12YI6AlFIKaQ57tNzyt2S171PVoHfqRAIO7u0fCfCeWjQHyviByPxk90SSO
         KQ8JEjKMNbh0ke90s8BIwUl4jPvYilxjw1fKNT1Hyq/sc0FD5EoPUx5ifZM0iqdLYLbg
         Qsc9laQC8FBPayYGXtPlHuuw19oAD8orK78lzhmdU2IDzvInfYOL1trYyua/jR6NtHt+
         dU7vu2oByGRCxod0sMhIpD2e1lLJ2ks1HF0Q1+oH0J1tQ4ghKt14NBID3uFgjEsFFIgF
         qw+A==
X-Gm-Message-State: AOJu0Yw3KMDVAcCN1vbj56E8xYVKNocA90AcUodJjRHsKHs9Q8eomMCO
        RPFQsM0/2x2LAMSbQVOc7ezgso5Pl1O5
X-Google-Smtp-Source: AGHT+IFYH/I9kqNhfmStNK/TQjvWgoMG9nLTrTw4wEL3FMorBwBtH3/8wSbZzWlFfAXyGMUCUPjboA==
X-Received: by 2002:a05:6a00:2d08:b0:68e:2cc4:c720 with SMTP id fa8-20020a056a002d0800b0068e2cc4c720mr6153219pfb.12.1695303447480;
        Thu, 21 Sep 2023 06:37:27 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:26 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <piliu@redhat.com>,
        "Jan Hendrik Farr" <kernel@jfarr.cc>,
        "Baoquan He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>,
        "Philipp Rudo" <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] zboot: Signing the payload
Date:   Thu, 21 Sep 2023 21:37:02 +0800
Message-Id: <20230921133703.39042-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Pingfan Liu <piliu@redhat.com>

Emulate the scheme of module signing to sign the zboot's payload i.e.
Image before it is compressed.

And overall, the signature on vmlinuz.efi will be used by UEFI boot
loader and the signature on Image will be used by kexec file load.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org

---
 drivers/firmware/efi/libstub/Makefile.zboot | 23 ++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile.zboot b/drivers/firmware/efi/libstub/Makefile.zboot
index 2c489627a807..fd4305a4ebbd 100644
--- a/drivers/firmware/efi/libstub/Makefile.zboot
+++ b/drivers/firmware/efi/libstub/Makefile.zboot
@@ -4,13 +4,30 @@
 # EFI_ZBOOT_PAYLOAD, EFI_ZBOOT_BFD_TARGET, EFI_ZBOOT_MACH_TYPE and
 # EFI_ZBOOT_FORWARD_CFI
 
-quiet_cmd_copy_and_pad = PAD     $@
-      cmd_copy_and_pad = cp $< $@ && \
+
+#
+# Signing
+#
+ifeq ($(CONFIG_KEXEC_ZBOOT_SIG),y)
+ifeq ($(filter pkcs11:%, $(CONFIG_KEXEC_ZBOOT_SIG_KEY)),)
+sig-key := $(if $(wildcard $(CONFIG_KEXEC_ZBOOT_SIG_KEY)),,$(srctree)/)$(CONFIG_KEXEC_ZBOOT_SIG_KEY)
+else
+sig-key := $(CONFIG_KEXEC_ZBOOT_SIG_KEY)
+endif
+cmd_sign = scripts/sign-file $(CONFIG_KEXEC_ZBOOT_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@
+else
+      cmd_sign := :
+endif
+
+cmd_copy_and_pad = cp $< $@ && \
 			 truncate -s $(shell hexdump -s16 -n4 -e '"%u"' $<) $@
 
+quiet_cmd_copy_and_pad_sign = PAD and SIGN     $@
+      cmd_copy_and_pad_sign = $(cmd_copy_and_pad) && $(cmd_sign)
+
 # Pad the file to the size of the uncompressed image in memory, including BSS
 $(obj)/vmlinux.bin: $(obj)/$(EFI_ZBOOT_PAYLOAD) FORCE
-	$(call if_changed,copy_and_pad)
+	$(call if_changed,copy_and_pad_sign)
 
 comp-type-$(CONFIG_KERNEL_GZIP)		:= gzip
 comp-type-$(CONFIG_KERNEL_LZ4)		:= lz4
-- 
2.31.1

