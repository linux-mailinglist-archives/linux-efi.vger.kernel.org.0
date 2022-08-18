Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658AD59806B
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 10:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiHRI4H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRI4H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 04:56:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F0985AD
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 01:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99434B82140
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2575C433D6;
        Thu, 18 Aug 2022 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660812963;
        bh=5nfyW/WvXmrskb2t/kxpxzuMQeCiRSixX3YDgubLvQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLWV6iD9L01rPiTq0TLBiwT9khqG9ZkTchUTKUvbVOXU4CGAmem7rZRNgr9oHRSoI
         0e1SB7IlEPufWWF8uB8BIO+eKIYM8pFCTSsfwviTrtwGzpQ1X27aKwcMOC+X47sjw4
         3cFNAM6Lk7cEL1UMFj1h0eFqCYhT4u8aF3pvqiyYbAlJxzNjmYM1mqlRLArYrVYdxt
         mkBcNNdSXZfvUweNWyBLQhRQv9Xf6IDE1w06rrmHLlQEVXgbV4xqhEGyH013b7tSYk
         VcFIIiZEdsoXP1q9N8gpwktUtwbOs45FMa/8BNhmwEwk2M7x5CKy4/quu4XQLAzr+V
         GOqmOB99ZNuFA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     grub-devel@nongnu.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        grub-devel@gnu.org, Daniel Kiper <daniel.kiper@oracle.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        dann frazier <dann.frazier@canonical.com>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH resend 6/9] efi: add definition of LoadFile2 protocol
Date:   Thu, 18 Aug 2022 10:55:36 +0200
Message-Id: <20220818085540.2075028-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818085540.2075028-1-ardb@kernel.org>
References: <20220818085540.2075028-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=ardb@kernel.org; h=from:subject; bh=5nfyW/WvXmrskb2t/kxpxzuMQeCiRSixX3YDgubLvQE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi/f6DAPw2MoB/uTn5i+6CZT2mvdSU/hfwn1hRWdMn VCq6arSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYv3+gwAKCRDDTyI5ktmPJOaxC/ 99hIBX0vA48YqcGvCa6tmcmv7ikPSukgHEbnxN5ANQgiAwWoqmjzXLR29f1jiEnZAfAcpkJMUZlGvR Ctg5oZRt0mKJ7YErJXe8ojUU44T3kBoRjBFaW/WuvUv068Ls+Q3muNmH5Hy2QgJHt7trMFM39os68j xxUbHotHQzwAxk+lDIDIvQR9hhwEQtmVayPLPgFEVaBzA3sNZ2B5qj4ODAvm5Jy9H92ZGKWCwkRAiZ qvfyI6Nu6wpI3aqvNeV5eaukwP/Zug8LtaO2ninqoTh0ROFqw78+8y1E/WEF4diVfBXeyEax8nVZlf 4YI/yQumHDxt7Nzvg74gAll2LQdTQHtFdIz2qhXjEB0eqAaFqh1RFuMkj93N1xiTKDk0qxVbLJYlgs uw3B2mCsRUMji9YovXeAcLnqGKEgu658ONFC4zD2Rwun22sJGROE5TPBtdBlW5BrxlZyHaAke8XjVn 3GwixN3Vx6XnfvBkSwZWwwaW2Xtk7ZxXIZ1jQ8z2Q7dZI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Incorporate the EFI_LOAD_FILE2_PROTOCOL GUID and C types from the
UEFI spec.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 grub-core/commands/efi/lsefi.c |  1 +
 include/grub/efi/api.h         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/grub-core/commands/efi/lsefi.c b/grub-core/commands/efi/lsefi.c
index f46ba3b49384..c304d25ccdd6 100644
--- a/grub-core/commands/efi/lsefi.c
+++ b/grub-core/commands/efi/lsefi.c
@@ -55,6 +55,7 @@ struct known_protocol
     { GRUB_EFI_ABSOLUTE_POINTER_PROTOCOL_GUID, "absolute pointer" },
     { GRUB_EFI_DRIVER_BINDING_PROTOCOL_GUID, "EFI driver binding" },
     { GRUB_EFI_LOAD_FILE_PROTOCOL_GUID, "load file" },
+    { GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID, "load file2" },
     { GRUB_EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID, "simple FS" },
     { GRUB_EFI_TAPE_IO_PROTOCOL_GUID, "tape I/O" },
     { GRUB_EFI_UNICODE_COLLATION_PROTOCOL_GUID, "unicode collation" },
diff --git a/include/grub/efi/api.h b/include/grub/efi/api.h
index 1ef4046225cb..1077826a3ca1 100644
--- a/include/grub/efi/api.h
+++ b/include/grub/efi/api.h
@@ -149,6 +149,11 @@
     { 0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B } \
   }
 
+#define GRUB_EFI_LOAD_FILE2_PROTOCOL_GUID \
+  { 0x4006c0c1, 0xfcb3, 0x403e, \
+    { 0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d } \
+  }
+
 #define GRUB_EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID \
   { 0x0964e5b22, 0x6459, 0x11d2, \
     { 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b } \
@@ -1749,6 +1754,16 @@ struct grub_efi_rng_protocol
 };
 typedef struct grub_efi_rng_protocol grub_efi_rng_protocol_t;
 
+struct grub_efi_load_file2
+{
+  grub_efi_status_t (*load_file)(struct grub_efi_load_file2 *this,
+                                grub_efi_device_path_t *file_path,
+                                grub_efi_boolean_t boot_policy,
+                                grub_efi_uintn_t *buffer_size,
+                                void *buffer);
+};
+typedef struct grub_efi_load_file2 grub_efi_load_file2_t;
+
 #if (GRUB_TARGET_SIZEOF_VOID_P == 4) || defined (__ia64__) \
   || defined (__aarch64__) || defined (__MINGW64__) || defined (__CYGWIN__) \
   || defined(__riscv)
-- 
2.35.1

