Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6242214C
	for <lists+linux-efi@lfdr.de>; Tue,  5 Oct 2021 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhJEIxa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Oct 2021 04:53:30 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46508
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233583AbhJEIxY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Oct 2021 04:53:24 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DE76B3FFE3;
        Tue,  5 Oct 2021 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633423893;
        bh=LcOIx5nhCnLkNDGhB88lSqiIHuHJTa5m5nJnpaZ9Xr0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IVQipN017uieeWu7rnJzY71I+41/aSk2syz6YJQVx0rs64Smnt1xOE0A24rCrCRHY
         rFmk2vOhGWvnIkRRqeL57FLAmwwmN05XtvaP8M3XDKFlwbDrn5xvoekDKYvp6TkTYf
         7LC/yrQtJ0FIeTNCAH5xgnZr6cPFIKtyYr0HwatqcQeakJIpGZ5Ij9CvnxThNRNI3b
         YaiyWiOgzFMAL2TMtggmv5rwLgtr1Rnc8sJC4NlT5vOXWNKmLwROD4Xa+D7SK84Nn7
         MoQ7p0C5/9cFEAWH0IGo2broJrCM98hgCNijObxh719GrxVSwZ8sYF79CIYCM0WOHa
         9W40kGC6JyvKQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efitools: enable RISC-V build
Date:   Tue,  5 Oct 2021 10:50:18 +0200
Message-Id: <20211005085018.9974-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Set necessary Makefile variables for architecture riscv64.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Make.rules | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Make.rules b/Make.rules
index 903a5a4..69bd3bd 100644
--- a/Make.rules
+++ b/Make.rules
@@ -10,6 +10,8 @@ else ifeq ($(ARCH),aarch64)
 ARCH3264 =
 else ifeq ($(ARCH),arm)
 ARCH3264 =
+else ifeq ($(ARCH),riscv64)
+ARCH3264 =
 else
 $(error unknown architecture $(ARCH))
 endif
@@ -56,6 +58,11 @@ ifeq ($(ARCH),aarch64)
   FORMAT = -O binary
 endif
 
+ifeq ($(ARCH),riscv64)
+  LDFLAGS += --defsym=EFI_SUBSYSTEM=0x0a
+  FORMAT = -O binary
+endif
+
 %.efi: %.so
 	$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic -j .dynsym \
 		   -j .rel -j .rela -j .rel.* -j .rela.* -j .rel* -j .rela* \
-- 
2.32.0

