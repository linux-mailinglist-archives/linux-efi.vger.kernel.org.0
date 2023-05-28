Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A0713898
	for <lists+linux-efi@lfdr.de>; Sun, 28 May 2023 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjE1H7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 May 2023 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1H7K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 May 2023 03:59:10 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE6D8;
        Sun, 28 May 2023 00:59:09 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9daef8681fso1766387276.1;
        Sun, 28 May 2023 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685260749; x=1687852749;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQ0EJ4YOOjKzukNaJdp3RRoDpGh0O633yjDT5laO8nE=;
        b=dz4dOwD8yLWJsXuYSJDvP8Ot0Y+Y5dFBExUr8K+KpRfAL0oEsuh6WALEGRrQSdvYHB
         tUtrkFRZi16ZydeDYYqBalKheEKbzHk7/Ev5302t8NWW2F6WVXae8BrH6CPetXgP0Fil
         yH/VuRtzDmgZNtN49kgwkJsbfXeyKe9y4D7fV4BVL+f4nuUQKFl/VhEZfqiCEPQd3pLe
         dgRliz30C6Z+5TwFqrC0e1oLpqT8q9Cf/YQRDLiftNQwUse3xzYA2lTIgX4t5PgjElAN
         ng0g4Pw7bzfrV4xUkx7ijxQcT1wzJsKReUZXotT8PzI9mAIVd9qPtLcAqYXurjIRafvq
         gmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685260749; x=1687852749;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQ0EJ4YOOjKzukNaJdp3RRoDpGh0O633yjDT5laO8nE=;
        b=JAI5wDzWi33SkNraaoaC6Sc33mR53SdkcsykGw/90DUuXCLxlcVv6THlzVCPBMjEEl
         Ptgu/UHYoR8OiGh19kCj67FB85JUKC0K3bFrPGAKikAsnx0+RLJyER+/o60stGdioJqN
         q4BlHJxJGOpINdJCtz3c80U9qBib3F3uBRTYnVM52ldXwT48smIHaw7COrzDoyNYE3qL
         510hUCollcJnKgtagEAwT09sP20oMxloqTCrMdBX1hjiR1/y1DIx1wAJmn7Pr+DG6luD
         074blReq5HRiDvmwJqio15D3s15FsKrypOC+plK1AdDmljt3an4XYjXWwOqU54Axn2Qg
         GRdg==
X-Gm-Message-State: AC+VfDylPFfG11J3SGtTCzy5WQw+MJi3uNjHsMi4ngOeKvDCgyZMVHPY
        EfFy+Xy1MLHy0OVh4J+vhJ151CbiTHk75B6DkxT+lDDrYPlymQ==
X-Google-Smtp-Source: ACHHUZ6d2Hy2eys4UyO7fBXSgrJeaNJsmK63pdNNYPl3zwvRlXL4crt6OBTHN6wxJBY/TrBtEicIV2dxSAzIyKcpjsw=
X-Received: by 2002:a81:4fcd:0:b0:561:8ffb:5b72 with SMTP id
 d196-20020a814fcd000000b005618ffb5b72mr7747342ywb.48.1685260748889; Sun, 28
 May 2023 00:59:08 -0700 (PDT)
MIME-Version: 1.0
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sun, 28 May 2023 16:58:57 +0900
Message-ID: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
Subject: [PATCH] efi: bump efistub version from 1.1 to 3.0 for
 VZLinuxBootLoader compatibility
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Linux x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

- LINUX_EFISTUB_MAJOR_VERSION is bumped from 1 (0b1) to 3 (0b11).
  The value is now a bitfield. The next version will be 7 (0b111).

- LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
  VZLinuxBootLoader [1] cannot boot a kernel with other minor version value [2],
  even though it does not use UEFI. Tested with macOS 13.4 (x86_64).

[1] https://developer.apple.com/documentation/virtualization/vzlinuxbootloader
[2] https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4YgJ=hN1xX7AD940YKf3A@mail.gmail.com/

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217485
Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 include/linux/pe.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 5e1e11540870..ee5ade19b7eb 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -27,9 +27,25 @@
  * On x86, LoadImage() and StartImage() can be omitted if the EFI handover
  * protocol is implemented, which can be inferred from the version,
  * handover_offset and xloadflags fields in the bootparams structure.
+ *
+ * Linux EFI stub v1.1 unconditionally enabled initrd command line loader,
+ * which was previously gated by CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER.
+ *
+ * Linux EFI stub v3.0 changed the major version to be a bitfield (0b11).
+ * The rightmost bit means that it is compatible with v1.0 at least.
+ * The second rightmost bit means that initrd command line loader is enabled.
+ * So, there is no v2.0 (0b10), and the next version will be v7.0 (0b111).
+ */
+#define LINUX_EFISTUB_MAJOR_VERSION            0x3
+
+/*
+ * LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
+ * VZLinuxBootLoader cannot boot a kernel with other minor version value, even
+ * though it does not use UEFI. Tested with macOS 13.4 (x86_64).
+ *
+ * https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4YgJ=hN1xX7AD940YKf3A@mail.gmail.com/
  */
-#define LINUX_EFISTUB_MAJOR_VERSION            0x1
-#define LINUX_EFISTUB_MINOR_VERSION            0x1
+#define LINUX_EFISTUB_MINOR_VERSION            0x0

 /*
  * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of EFI bootable
-- 
2.39.2
