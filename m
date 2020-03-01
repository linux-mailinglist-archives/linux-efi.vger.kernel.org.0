Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245001750BD
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCAXEm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:42 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42060 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCAXEm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id r6so1641899qtt.9;
        Sun, 01 Mar 2020 15:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HzQt//Adq5EryedFfwKQ2AkRXxzw5ZnWMqIrRLIAO8=;
        b=NMrKX9aRe8u0AnkhkUzIWQoFCZWmGLo97GpM4uByezeE3AIfaaU4vfntW1IVMrmQxh
         OKaIy1eh6883jFUxvNNEu3+RUg8vXAFZuX6FYoSC0nSDeTa2zv3PH1ylUiK9arfQMrxS
         CLaaPR+rJDT95abFnwEGmU81wDgbpSLLyavQOnyBZTb04DK8FKYLL22R4fPDJbmK5Apu
         m5YqmE/91uiPTNcxNDJywHX/npCJEK0Trd1rVCWLmyKGffRmkcCSiG5EoWYQaHpeCh7O
         k/deTTje2XJU27+QZVbqazT91r8JLMFRVoll7F8Gtiq9XqPGkjkyQ/0zccHQIJtmv3lP
         vjPQ==
X-Gm-Message-State: APjAAAX+Jo1yKv1PQnYQy0lRtt1ZB3nvxsyqNvPlrVcRO+xQ3a//h06q
        tFSRVx7jflu51uY8a2UgwleyW39SFRQ=
X-Google-Smtp-Source: APXvYqzRr3yYfj1J/SDm5RVf/5Sdfzt21d9afxWIms01+tqBqrIJK99TrYejtz0f9d5mg5XqA1ptKQ==
X-Received: by 2002:ac8:b43:: with SMTP id m3mr13261685qti.191.1583103881183;
        Sun, 01 Mar 2020 15:04:41 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86/boot: Use unsigned comparison for addresses
Date:   Sun,  1 Mar 2020 18:04:36 -0500
Message-Id: <20200301230436.2246909-6-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The load address is compared with LOAD_PHYSICAL_ADDR using a signed
comparison currently (using jge instruction).

When loading a 64-bit kernel using the new efi32_pe_entry point added by
commit 97aa276579b2 ("efi/x86: Add true mixed mode entry point into
.compat section") using qemu with -m 3072, the firmware actually loads
us above 2Gb, resulting in a very early crash.

Use jae instruction to perform unsigned comparison instead, as physical
addresses should be considered as unsigned.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index e013bdc1237b..46bbe7ab4adf 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl    %eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 6a4ff919008c..5d8338a693ce 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -105,7 +105,7 @@ SYM_FUNC_START(startup_32)
 	notl	%eax
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
@@ -305,7 +305,7 @@ SYM_CODE_START(startup_64)
 	notq	%rax
 	andq	%rax, %rbp
 	cmpq	$LOAD_PHYSICAL_ADDR, %rbp
-	jge	1f
+	jae	1f
 #endif
 	movq	$LOAD_PHYSICAL_ADDR, %rbp
 1:
-- 
2.24.1

