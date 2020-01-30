Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F61A14E399
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA3UEu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgA3UEu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so4177880qkb.11;
        Thu, 30 Jan 2020 12:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnfSmd5BvkLFsh0nPNy/3uEL0TluYTwz+zLsYY8/uCw=;
        b=pwrfNcIe49di8w/alX63HlrtfvV1GzAa6nmYt1rx8vT6A6F0r+2DzIg93+27CmMbwu
         2Dg92EYNKXO+X5qJrpRtQm0Sg8pU04axDfOl9t9nIIWUDg+MKXiAOO7qaBxK9uMOCcnc
         PmcKUlbN5hbpf5HSYnvYakMJESKckVoU+o4PWCByKpM2rFI+Y173gzytkF2daYo7JSmY
         aSe6jgkezBTU40TvpYIPOTVk7j8n10E04HIp96fklEyZtfEhODCMKEg2ailoOf6+8Wy/
         LIjmcI0/rv85Kim07kqrxFcvay9RRpeSAZuX6yW4FDJ00zlUorEH2rOiBd5LIYDfMZ5j
         +OCg==
X-Gm-Message-State: APjAAAVAepp2g92efaAvmoRwkUEVVLV4i2bvtIXBCtqJyxeBI/FSMEoc
        xtSCOQzPvU9YlrV7tbSFP8w=
X-Google-Smtp-Source: APXvYqxZv8KxrwfLJ4RsleKR7BkXYUmiK80t5OGV/op/UYcaY1r/kLf5QnLszxdj9dCnT6tj2MTAXQ==
X-Received: by 2002:a05:620a:1663:: with SMTP id d3mr7240564qko.204.1580414689272;
        Thu, 30 Jan 2020 12:04:49 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 8/8] Documentation/x86/boot: Correct segment requirements for 64-bit boot
Date:   Thu, 30 Jan 2020 15:04:40 -0500
Message-Id: <20200130200440.1796058-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

64-bit mode has no segment/GDT requirements as it does not really use
segment registers. The entry code loads null descriptors into the data
and stack segment registers.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 Documentation/x86/boot.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 3e13b7d57271..df2bf8abbbc1 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1396,12 +1396,9 @@ In 64-bit boot protocol, the kernel is started by jumping to the
 At entry, the CPU must be in 64-bit mode with paging enabled.
 The range with setup_header.init_size from start address of loaded
 kernel and zero page and command line buffer get ident mapping;
-a GDT must be loaded with the descriptors for selectors
-__BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
-segment; __BOOT_CS must have execute/read permission, and __BOOT_DS
-must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
-must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
-address of the struct boot_params.
+interrupt must be disabled; %rsi must hold the base address of the
+struct boot_params. As 64-bit mode does not really use segments, there
+are no special requirements on the segment registers or descriptors.
 
 EFI Handover Protocol
 =====================
-- 
2.24.1

