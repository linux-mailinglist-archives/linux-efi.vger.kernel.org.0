Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDE14E394
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgA3UEt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34011 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3UEt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id d10so4263032qke.1;
        Thu, 30 Jan 2020 12:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5UX2NdM3cfVWh/gVO4PCQr35u5EguDY40Iisa5P8eI=;
        b=ZfvnyZbHLv48gCXAfbWjjO8R8r2FSqRAsLnb1Gfd2+P2/Qg/4rV7uEVmVvz7IQpcDM
         rph1nuINtVP0fWzUEP7ejSSSyMO0zg4bd1NV2c27KrwHVDE1fHMe6scJrLprvoUl0ozY
         4FuoZDmryBRURLEGuMq3RFDtyDpw5L1nKbUky0G0aZyqQqTl18VOGAZq7eaq1RXcHOJ8
         Rwxly47BMwX6y9PfUI3Q08ZVPCk74b4ZGq+TZwfkPW+oFVSleAYselVV79GyYfxjk4LR
         okA26dtl1PMGDuxCd+a9u0aMAFAme8z/qD/6yNlXn1UB5YzOT5o4kWaDuSD2+FNGDHkU
         GYbQ==
X-Gm-Message-State: APjAAAVY+HDfl4PXtCRQNth/GocxsKMh9GwoGRcLXqT6cvx03tkBayMJ
        8j32qR4XVdS+oUjHcY9PWHA=
X-Google-Smtp-Source: APXvYqzaPn9nWlNV0dKpLcZCIuA+cUjkceuKmWkJdS51ETLoGuZ+X4u4MtRlYICxJLClDx7ctXk6Qg==
X-Received: by 2002:ae9:ec0a:: with SMTP id h10mr6596149qkg.303.1580414688403;
        Thu, 30 Jan 2020 12:04:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 7/8] Documentation/x86/boot: Clarify segment requirements for EFI handover
Date:   Thu, 30 Jan 2020 15:04:39 -0500
Message-Id: <20200130200440.1796058-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The 32-bit EFI handover entry point requires segments to be setup in the
same way as for the regular 32-bit boot.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/x86/boot.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index c9c201596c3e..3e13b7d57271 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1412,6 +1412,12 @@ from the boot media and jump to the EFI handover protocol entry point
 which is hdr->handover_offset bytes from the beginning of
 startup_{32,64}.
 
+For the 32-bit handover entry point, the GDT and segments must be setup as for
+the 32-bit boot protocol, i.e. a GDT must be loaded with the descriptors for
+selectors __BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
+segment; __BOOT_CS must have execute/read permission, and __BOOT_DS must have
+read/write permission; CS must be __BOOT_CS and DS, ES, SS must be __BOOT_DS.
+
 The function prototype for the handover entry point looks like this::
 
     efi_main(void *handle, efi_system_table_t *table, struct boot_params *bp)
-- 
2.24.1

