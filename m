Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8731750C5
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCAXEw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:52 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:44795 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgCAXEk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:40 -0500
Received: by mail-qk1-f175.google.com with SMTP id f198so707490qke.11;
        Sun, 01 Mar 2020 15:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZ0AjbtgZYbQmgeycgx4fTf3TsbCTcfSdl6G4jmsqCg=;
        b=B5WwEWH9pXCrhOj4AH2H8P6LUKUBP8cC69hez9R9FvKpowmP2REUd8S8RnWoQLK9lf
         MNQuKxUhi5VBvFGNHFu/jWo8EAyVetr8fs/hbzaGacabLsoCdoXhzaugJLhKB4kNEyE2
         vXAhxm49Qjj0/ky1d2TaZEK6b3YeoqzFYRCdiWUGOLFcxi9TS8Jx/5bpSmtMNXcofIhr
         fbN0j0HFTzQIKJJjrOw1mwyAO5bWxGbIEedgqa6QIhmWRJhv6fo1wgYwshfT1irpfrIw
         BVaBQjxvf+Xgr8iq5zgTRdxBDiYNOZ4AuMNcd+xmmXqxg5ziPjnrUoCLEpYi9xKlJRnC
         r9YA==
X-Gm-Message-State: APjAAAXeaWIH5x0vngmNBfc3sKdeMwXxZA0L6kvYly0Y3nxpByvJ1GHE
        +j98nDdwmNTxwP3MJ5En/fnzsP3PljE=
X-Google-Smtp-Source: APXvYqzXeQubmG7BwOy8awbJEJ0VNG5+1+QlqryjrKh3BNhzIZGYDaqv6YlqnbRWjSFpKGBVzlvzVQ==
X-Received: by 2002:a37:5285:: with SMTP id g127mr13356577qkb.315.1583103879165;
        Sun, 01 Mar 2020 15:04:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] efi/x86: Respect 32-bit ABI in efi32_pe_entry
Date:   Sun,  1 Mar 2020 18:04:33 -0500
Message-Id: <20200301230436.2246909-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230436.2246909-1-nivedita@alum.mit.edu>
References: <20200301230436.2246909-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

verify_cpu clobbers BX and DI. In case we have to return error, we need
to preserve them to respect 32-bit calling convention.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8105e8348607..920daf62dac2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -660,7 +660,11 @@ SYM_DATA(efi_is64, .byte 1)
 SYM_FUNC_START(efi32_pe_entry)
 	pushl	%ebp
 
+	pushl	%ebx
+	pushl	%edi
 	call	verify_cpu			// check for long mode support
+	popl	%edi
+	popl	%ebx
 	testl	%eax, %eax
 	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	jnz	3f
-- 
2.24.1

