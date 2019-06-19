Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A814C035
	for <lists+linux-efi@lfdr.de>; Wed, 19 Jun 2019 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSRsJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jun 2019 13:48:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33098 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbfFSRsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Jun 2019 13:48:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id x2so60390qtr.0
        for <linux-efi@vger.kernel.org>; Wed, 19 Jun 2019 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dXV7QK2jBvzrpKqZ0H44fgbNkrbzKwjaMLPe99U+Pk0=;
        b=fMqNpV6gaqU3mDpG5fcUKQPTEEQa6ArYNQPiTQZxCa9HznA1vPxmBUT7ZednAsRb07
         ELjqYp7VwmrsS6Tdc5aaPT6LwigvoioQ+AyxlYqz7ssKx+Qe5HVAeBLOoN8roZ7JIVkm
         oX8YYwHPfoWiaoTRzGFIOrfUgV74QegXaFy4FKbxkZfXv/wdx+y4LLatYy8BbELL94Mv
         Gt58clfIrnqHPMubWDqk1GCixWRgFB78LLU1pMqKb9VEr9/RuDncFLPjNZ7RpQFRdSDj
         Hs32oRB8WW4vkNQ9qij8Wgv/iImFxEqDILjQrpegAJbEjae0x10RvoyCfxN6ZpOfra8m
         zR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dXV7QK2jBvzrpKqZ0H44fgbNkrbzKwjaMLPe99U+Pk0=;
        b=PqaFD2RSpt8CpPGLAk47qX/1IVXgcm7OQzrfADhFqk8ectXiN9RXNK9aTDEsZl/qTe
         I1fK5BVrjIEcjsaKJ84A9k2/3Nomui/vUo0l/b/yKUWEXPF+iC73fkqFiOFZYzjXxqLH
         ISc60xijal3um9C3gXzGNXO98tu65Ot2u3/0xEJRr1nKSx6uKzKwfnpn9Nuv5+XKoo6n
         31c14dL8R8ph0TL2VI6TmTbBaM/f1NPqkcO7embGA4IGU+3mTWu80/4bxMMgX5lVu9S5
         9U9nqXPGHpBwdvf8kUbW6adHdXVRNl4T+vZzrSfbUBxsGXgpXQ+85ETbpe42+beBCdPx
         cPlQ==
X-Gm-Message-State: APjAAAVw6Vf7RK3jKd3SnJi+S2bFx0aVjEv54A1PLYKJIfQX/+JviQSG
        lL/J3eR4NoYXv0jnRHR2+IIsDQ==
X-Google-Smtp-Source: APXvYqxywbv89LKe+7245WNQEyekTjsbFuLid+Nh9MmrzRaYzzhINqQ8eJdFHR8/g0lGeWI+UPJNQQ==
X-Received: by 2002:ac8:2a69:: with SMTP id l38mr39177182qtl.212.1560966487512;
        Wed, 19 Jun 2019 10:48:07 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f25sm14278803qta.81.2019.06.19.10.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:48:07 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     bp@alien8.de
Cc:     ard.biesheuvel@linaro.org, akpm@linux-foundation.org,
        dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, sai.praneeth.prakhya@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] x86/efi: fix a -Wtype-limits compilation warning
Date:   Wed, 19 Jun 2019 13:47:44 -0400
Message-Id: <1560966464-27644-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Compiling a kernel with W=1 generates this warning,

arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]

Fixes: 3425d934fc03 ("efi/x86: Handle page faults occurring while running EFI runtime services")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Add a "Fixes" tag.

 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 632b83885867..3b9fd679cea9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -728,7 +728,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
 	 * page faulting on these addresses isn't expected.
 	 */
-	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+	if (phys_addr <= 0x0fff)
 		return;
 
 	/*
-- 
1.8.3.1

