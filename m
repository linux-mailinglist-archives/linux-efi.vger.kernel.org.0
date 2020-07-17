Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4C224475
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 21:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGQTp2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jul 2020 15:45:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46734 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jul 2020 15:45:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id r22so9804632qke.13
        for <linux-efi@vger.kernel.org>; Fri, 17 Jul 2020 12:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcECdrFszYL/rOTRUqTPv/QzKPYLUcZjtQN02ZRuFvE=;
        b=LzoCP4V40r3fWvHKVV+kJkMFGRLHuAW8kGcsCBXHSsFXMJ6+VNJgE++WODx+yZ0AMC
         NghR3cqeOkH0mTQ0fWgL+nYiVc4JoIMJUzjZXonzELf0184bWtyXli6zLfLIXq/xWuMJ
         oVJHMic10SbKuGgMRHiKsn87HUEpCfY45gq0cBYv3B/LjucH/uWv4gkfj9XxGj27js0S
         K7fTX08B21eEJffxzKjtREMFI2BXz+psIP1ZzJWgMrn1omJXZWJhQ1MFfAfXhMFXC3It
         r4iQ7mSRWEiyKSas7jQPCrHdYjS5/xezyYQCotI/v1t4+e8jaByCRRftUihikWa3/OHI
         Pu2A==
X-Gm-Message-State: AOAM5324fUsh0V4XQ/Hq/53bffuU67P4OnFp7abTal09AUYLyJPtfk1k
        zWuBk5sg/NcMH6IXJO8PqRURUTPcBuA=
X-Google-Smtp-Source: ABdhPJzwpS5s9i+ppbl2vOFylREwgS4uGYkaKZyEb8Sq8FrT0ESbHXYZzz3+E1glJ6t5KajCOHuFOg==
X-Received: by 2002:a37:a78c:: with SMTP id q134mr11022095qke.368.1595015127204;
        Fri, 17 Jul 2020 12:45:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g145sm10575617qke.17.2020.07.17.12.45.26
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:45:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-efi@vger.kernel.org
Subject: [PATCH] efi/x86: Mark kernel rodata non-executable
Date:   Fri, 17 Jul 2020 15:45:26 -0400
Message-Id: <20200717194526.3452089-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When remapping the kernel rodata section RO in the EFI pagetables, the
protection flags that were used for the text section are being reused,
but the rodata section should not be marked executable.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/platform/efi/efi_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 8e364c4c6768..7caa65837356 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -268,6 +268,8 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
 	rodata = __pa(__start_rodata);
 	pfn = rodata >> PAGE_SHIFT;
+
+	pf = _PAGE_NX | _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
 		pr_err("Failed to map kernel rodata 1:1\n");
 		return 1;
-- 
2.26.2

