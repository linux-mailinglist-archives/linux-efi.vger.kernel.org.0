Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3217854B
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCCWMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 17:12:13 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44534 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCCWMJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 17:12:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id b13so72881qvt.11;
        Tue, 03 Mar 2020 14:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmcbQwyEtfdi8QD7clg+NqRsV8BYwj3SzR0V6CDlNfE=;
        b=mc25+UCPkTYj/sumjvlVCB6LXhBWB8rl4O9veurGisXTKZylY7K4uaQaTvrvuYzDmX
         1SZ2x50jg2Q6gXm9r+AXjdxpLnWWFB1sKz2xY/KNCIK1RW2K4x8espcc3imHomP+ydAv
         rDpbG2ROCZ6WRTcqdJDgUWHjSKwpxRgX99mcQ/6mAjul3GU1GnmO0GbufoEgWfzIfEIe
         hLK6fi19MIw/qf6GgV4LL3avV/3erdJmEOqL/CO+gvV3IFhcPKTHcmH7blqBm5ZaVPBf
         4tJUezpzBehJka9fsqGbsVv22IHzWSehA2lmHw7z1b/YSUorUQw9JwtNigD2l/uBuJ+r
         XPmw==
X-Gm-Message-State: ANhLgQ1fClR60AYl7X2Rhba9Dos9PCb7425w45elfR0AELgTWUXnIkwF
        TjHgmw8d74pHmq1VyKqjE9fr1t6nde4=
X-Google-Smtp-Source: ADFU+vtoZHnomN4xLnAHm0FM8CEN9KuCsHyY+h3mBdwmRADohwsMCEdCKormjc8Vr6+o3qQxSWoOWg==
X-Received: by 2002:ad4:4b2f:: with SMTP id s15mr5634560qvw.95.1583273528710;
        Tue, 03 Mar 2020 14:12:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i91sm13267378qtd.70.2020.03.03.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:12:08 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] efi/x86: Add kernel preferred address to PE header
Date:   Tue,  3 Mar 2020 17:12:03 -0500
Message-Id: <20200303221205.4048668-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303221205.4048668-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu>
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
index 4ee25e28996f..736b3a0c9454 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -138,10 +138,12 @@ optional_header:
 #endif
 
 extra_header_fields:
+	# PE specification requires ImageBase to be 64k-aligned
+	.set	image_base, (LOAD_PHYSICAL_ADDR + 0xffff) & ~0xffff
 #ifdef CONFIG_X86_32
-	.long	0				# ImageBase
+	.long	image_base			# ImageBase
 #else
-	.quad	0				# ImageBase
+	.quad	image_base			# ImageBase
 #endif
 	.long	0x20				# SectionAlignment
 	.long	0x20				# FileAlignment
-- 
2.24.1

