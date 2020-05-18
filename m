Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80DE1D87D8
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgERTHY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41406 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgERTHW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id n14so11437919qke.8
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8O+Zu4CL6oayPok1as4pcKubIbMHa01zS1BoB+sV7g=;
        b=VkAsdo5svBpPcyN20674HUqFg69GWQdNbYNBP2aLBRq/+3RilCYFW6PGsOg/KRCUUC
         WRmvDxZdBZX5oRV8u+FVFMg4HIICCohdUygI41JzUWf7pirSq0Y5L4ddi9vjmo3PyyD9
         vRRpYna/YWMOGGFSBrJjrFeT6rhYSBEhT/U7Xl/76+bBgXGDNgjdNKwa3FIpoYOUHvzY
         sk7g8ydbJlIs5dRyaJ0+nSnGerJkAHCtun3F5TR9Oklw7tBXONAmXO7wSyZyeon81NUL
         W5aE7xsMa/IQWURBpQeCXyN32uA633ljSs36QEmXSEOqTAJBSGBTsRSZ+ZRw0XkyBygA
         HFSQ==
X-Gm-Message-State: AOAM530uXmPBB3uJbpzzbAzXM6mmDtd0ZSklHdq1U1ITSyQ1u6B8WrXo
        gyczt6uZrHKwoZquUn474/SUQJ9MAbs=
X-Google-Smtp-Source: ABdhPJy3RwaBlxlJ4J4WBQvu5V+Hg5jY92Bn0yP20dZimfZkSmrXLyPDRBJiJC9cPJMhCF/1f6w0Ow==
X-Received: by 2002:a37:67c6:: with SMTP id b189mr17927750qkc.285.1589828841410;
        Mon, 18 May 2020 12:07:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:21 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
Date:   Mon, 18 May 2020 15:06:57 -0400
Message-Id: <20200518190716.751506-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reclaim the bloat from the addition of printf by optimizing the stub for
size. With gcc 9, the text size of the stub is:

ARCH    before  +printf    -Os
arm      35197    37889  34638
arm64    34883    38159  34479
i386     18571    21657  17025
x86_64   25677    29328  22144

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index fb34c9d14a3c..034d71663b1e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -7,7 +7,7 @@
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \
@@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
-KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
+KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-- 
2.26.2

