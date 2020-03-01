Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F111750D2
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCAXFv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:05:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44234 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCAXFm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:05:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id j23so6222563qtr.11;
        Sun, 01 Mar 2020 15:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dB9kg8CzQGhH36dP05NVV6Pj3Y0sXP31eOWh9dPff/Y=;
        b=GBf4jeZksNie4ik+NNAc6zq+F3z/8da5nRNB6ZECz6Udsf+uzW8+C4/PZJIYc33hG+
         IyxgFCiiQ+OSwkvuDZXNV86vKwg/O8imdv5p4SZAi+CIFZVljy9iPTyXP5wG7bjlolOf
         9zgKa24ZbE/B6cvP7mXub6sqpaBSxVLtFA32Ta8J19I/ZGeBqB8cn6fig5k97NLtgnWc
         PNNpMOZYayHEh4d0rG3on6emKqKsLSWHv6k0haJkuk9Dy0S5ziuRu2+BHn+xOED8bAre
         eRrneHUR6Ymyu0u9uNlntPLQpZF7J2ciTxRUREx2Ne1JpRi7H0VaQYW93i9xcwIJGHMN
         CMig==
X-Gm-Message-State: APjAAAWCFLz3QYHkwJm4eyenzEFGx28Kd2DsC/yN4GazmPDDw5pwTdhZ
        NiHBq13+t3hNGVc5G3e3G5T246e9PcI=
X-Google-Smtp-Source: APXvYqxxyUidg6l8mcD+HAxYfdTYHXE/WfqrdfV9kcUXJGhJ0cOx1cxgBnFRxQxUXVexyM2Xjd9tgQ==
X-Received: by 2002:ac8:377a:: with SMTP id p55mr13203218qtb.87.1583103940680;
        Sun, 01 Mar 2020 15:05:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x131sm8923906qka.1.2020.03.01.15.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:05:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] efi/x86: Add kernel preferred address to PE header
Date:   Sun,  1 Mar 2020 18:05:35 -0500
Message-Id: <20200301230537.2247550-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230537.2247550-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Store the kernel's link address as ImageBase in the PE header. Note that
the PE specification requires the ImageBase to be 64k aligned. The
preferred address should almost always satisfy that, except for 32-bit
kernel if the configuration has been customized.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/header.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 4ee25e28996f..0d8d2cb28fd9 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -138,10 +138,12 @@ optional_header:
 #endif
 
 extra_header_fields:
+	# PE specification requires ImageBase to be 64k-aligned
+	.set	ImageBase, (LOAD_PHYSICAL_ADDR+0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	0				# ImageBase
+	.long	ImageBase			# ImageBase
 #else
-	.quad	0				# ImageBase
+	.quad	ImageBase			# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
-- 
2.24.1

