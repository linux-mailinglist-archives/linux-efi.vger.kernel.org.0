Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C144220FA
	for <lists+linux-efi@lfdr.de>; Tue,  5 Oct 2021 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhJEIlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Oct 2021 04:41:31 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46046
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232965AbhJEIl1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Oct 2021 04:41:27 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BC6AD3FFE4;
        Tue,  5 Oct 2021 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633423174;
        bh=ly/I0QI95Yc9GO/H5XIXI5TePQzK07ffrFXTYhJcZXA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=piQT/rtlx+NJfj/j1qgSjzA5Nn5tfG40z2Q/AcY50gCh8JSn/lHeog5V8sYK5vfpw
         AUTmHIlyY02MWohHOj82+gHGLOhpv59ojiqRzTf3LKiIxR5/W1q2B0sV/K4Y4ef1HT
         kQxfVbDFrzQv3xj4Jmgl4mh2Gp6P6r2Bd3rOqvaBSpDUYDPmIosHbIwLKukBaZDq06
         BykRctrTcd6iOXUDzffjYJkq/SdDZGEeAcZQUC79tNk5AeDQjiasTwR/YMBxYE6YJb
         fcLbMOpUT8FVQwNUmbQAmVxBI5I8yKKfeFYDSrPGhFlM9XTNZXZ3iFiHOAPaz943ke
         UuAp0iA4dJE6Q==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sbsigntool: add support for RISC-V images
Date:   Tue,  5 Oct 2021 10:37:57 +0200
Message-Id: <20211005083757.9201-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI 2.9 specification defines:

    EFI_IMAGE_MACHINE_RISCV32 = 0x5032
    EFI_IMAGE_MACHINE_RISCV64 = 0x5064

The same values can be found in the PE-COFF specification. Cf.
https://docs.microsoft.com/en-us/windows/win32/debug/pe-format#machine-types

    IMAGE_FILE_MACHINE_RISCV32 = 0x5032
    IMAGE_FILE_MACHINE_RISCV64 = 0x5064

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 src/coff/pe.h | 2 ++
 src/image.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/src/coff/pe.h b/src/coff/pe.h
index 0d1036e..a73a2c0 100644
--- a/src/coff/pe.h
+++ b/src/coff/pe.h
@@ -143,6 +143,8 @@
 #define IMAGE_FILE_MACHINE_R10000            0x0168
 #define IMAGE_FILE_MACHINE_R3000             0x0162
 #define IMAGE_FILE_MACHINE_R4000             0x0166
+#define IMAGE_FILE_MACHINE_RISCV32           0x5032
+#define IMAGE_FILE_MACHINE_RISCV64           0x5064
 #define IMAGE_FILE_MACHINE_SH3               0x01a2
 #define IMAGE_FILE_MACHINE_SH3DSP            0x01a3
 #define IMAGE_FILE_MACHINE_SH3E              0x01a4
diff --git a/src/image.c b/src/image.c
index 3ada37b..b14a30d 100644
--- a/src/image.c
+++ b/src/image.c
@@ -239,10 +239,12 @@ static int image_pecoff_parse(struct image *image)
 	switch (magic) {
 	case IMAGE_FILE_MACHINE_AMD64:
 	case IMAGE_FILE_MACHINE_AARCH64:
+	case IMAGE_FILE_MACHINE_RISCV64:
 		rc = image_pecoff_parse_64(image);
 		break;
 	case IMAGE_FILE_MACHINE_I386:
 	case IMAGE_FILE_MACHINE_THUMB:
+	case IMAGE_FILE_MACHINE_RISCV32:
 		rc = image_pecoff_parse_32(image);
 		break;
 	default:
-- 
2.31.1

