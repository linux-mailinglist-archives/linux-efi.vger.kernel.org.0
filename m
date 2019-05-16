Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5D21008
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2019 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfEPVc1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 May 2019 17:32:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52368 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfEPVcZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 May 2019 17:32:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so5017574wmm.2
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2019 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8GkOq3mFgmT114W9q0A9mveOj1yfbx4rAlQUC/tkPc=;
        b=r+7o95atwX8dZuEaXrHT3RNs2JbAxvK0UioLsku9KT5XxUcL/dUY4XAvA33SYj1rQt
         lv3ZhZejg+q39JWKLjynNLqayrtND0Dse1BayIx+h5gxRhk/UvoAteBiyWaSw92w8x4j
         NKUEd+pWdmhjZqslPcN6t4ZJe6vpy4TyHzUQEJpOqqa1HebJfu6qwCpImeJ3ftlhb+en
         bYMfZ7mlvE6Zui2nqnn7qH/x89TfcUOD3gavYtX3xQA/cyapCDpyTFidNvgGPWudNl9Q
         6AnoPOKE7h6QnPaq9IuIWhGd6OAtXYloglkuWCz9LiPvyh0Ylec4U3OIQ5pu/LmxvGmK
         6GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8GkOq3mFgmT114W9q0A9mveOj1yfbx4rAlQUC/tkPc=;
        b=q/BNh6HGRJ1BHzG+/zl6npfclRhn2heF4eUWuS4p1ct9Fbtyk+/2IVPJGSKFVu6NjZ
         UCcOyDaIIsVpVJAnsY5vpz49fF1JY2hbqaim7Op849CtOyKanxBNh25QXheTU6skNvoS
         1lnYr6P5+J8duPnZT5fFnsBvs4osYtMCXnQmrGrAXCyO24JiPk2c72tN19FkwY6Un16E
         188FHOw1rlttsKn5QSxf/Wbmuc0/gy3BZk14GwFO80Cn2F1BIwsbc6V6kuz4VeWk0eR+
         fefrDc9ESlTLr/G5QzwwM+cSRtUCG0svM93M7LmiIkaT8b41dvguCrOgrMBHLIyffCAK
         UjuQ==
X-Gm-Message-State: APjAAAXDM/EhC/Kt6DW2AHG+LH6kZCna0bfLpVwF1IoBz8atX65zriAw
        USm88WLZDsZl2OE/KJkJWjJL1mGXXtYQIA==
X-Google-Smtp-Source: APXvYqyodnUXX+qnMYtwnRikj3XwNk4wh2PhFd949xag5qsz/UDhXHRfrGb9RwVRtwN9lKCOpTJQqg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr11058445wmg.4.1558042343288;
        Thu, 16 May 2019 14:32:23 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:55a9:76bd:5bf2:be83])
        by smtp.gmail.com with ESMTPSA id e12sm6756988wrs.8.2019.05.16.14.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:32:22 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fbdev/efifb: ignore framebuffer memmap entries that lack any memory types
Date:   Thu, 16 May 2019 23:31:59 +0200
Message-Id: <20190516213159.3530-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516213159.3530-1-ard.biesheuvel@linaro.org>
References: <20190516213159.3530-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 38ac0287b7f4

  ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")

updated the EFI framebuffer code to use memory mappings for the linear
framebuffer that are permitted by the memory attributes described by the
EFI memory map for the particular region, if the framebuffer happens to
be covered by the EFI memory map (which is typically only the case for
framebuffers in shared memory). This is required since non-X86 systems
may require cacheable attributes for memory mappings that are shared
with other masters (such as GPUs), and this information cannot be
described by the Graphics Output Protocol (GOP) EFI protocol itself,
and so we rely on the EFI memory map for this.

As reported by James, this breaks some x86 systems:

  [ 1.173368] efifb: probing for efifb
  [ 1.173386] efifb: abort, cannot remap video memory 0x1d5000 @ 0xcf800000
  [ 1.173395] Trying to free nonexistent resource <00000000cf800000-00000000cf9d4bff>
  [ 1.173413] efi-framebuffer: probe of efi-framebuffer.0 failed with error -5

The problem turns out to be that the memory map entry that describes the
framebuffer has no memory attributes listed at all, and so we end up with
a mem_flags value of 0x0.

So work around this by ensuring that the memory map entry's attribute field
has a sane value before using it to mask the set of usable attributes.

Fixes: 38ac0287b7f4 ("fbdev/efifb: Honour UEFI memory map attributes when ...")
Cc: <stable@vger.kernel.org> # v4.19+
Cc: Peter Jones <pjones@redhat.com>
Reported-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 9e529cc2b4ff..9f39f0c360e0 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -477,8 +477,12 @@ static int efifb_probe(struct platform_device *dev)
 		 * If the UEFI memory map covers the efifb region, we may only
 		 * remap it using the attributes the memory map prescribes.
 		 */
-		mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
-		mem_flags &= md.attribute;
+		md.attribute &= EFI_MEMORY_UC | EFI_MEMORY_WC |
+				EFI_MEMORY_WT | EFI_MEMORY_WB;
+		if (md.attribute) {
+			mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
+			mem_flags &= md.attribute;
+		}
 	}
 	if (mem_flags & EFI_MEMORY_WC)
 		info->screen_base = ioremap_wc(efifb_fix.smem_start,
-- 
2.20.1

