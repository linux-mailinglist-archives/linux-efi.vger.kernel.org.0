Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3B27391
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2019 02:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfEWAvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 May 2019 20:51:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39453 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWAvv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 May 2019 20:51:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so1882556plm.6;
        Wed, 22 May 2019 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtI2yTs0dm+wBL3L4OREVCU991i3TViCrOTKp+Dkrtw=;
        b=GSxBqioxM2Dcbf7KXoxqMREdN3jogWsbl96O/urW3iGiaxyXGj+56tzGyA6n1sCZUO
         GPZXIsZy6BaGApw/t24/m/khqz00LA5ZrCSnUfWIP0SPpXiWZ1UJH0Y7xc9B75sMBOV5
         2afOfifxqq303JGOWnC47h0AX9YU5YrPtiZSl7F+E+BsxHt8WopRKtjry/+OQjUnnJBv
         LfFJNy7b4U26pGMMGrk97y1SAtdgkWqs1G3r3lxwQcMgxlTBZB7TwAEs6iWmdJaMT5VQ
         sQPL0QnPIVH7k6IwNm4m/42MDK4/UWcrMatLv7oiH4I62LRuY25X/B/KVp86BpjZXllJ
         /GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtI2yTs0dm+wBL3L4OREVCU991i3TViCrOTKp+Dkrtw=;
        b=GFF691bTlX+vR1/6BSsHug3yBE4lyDImbioZ6BbY30gBlyV39bFPrXkVGNfirbUrDk
         rhLWqIlaYVNJGXcuTeW4+NyVm2ZCJh7Oi47pZepQkqXpzYgTup/2CC6/vzivR5uIxJmE
         ULz9/IOzab8lxRLk8cqiSivuFy28D2X7pYmLXVjiaKq06GULPTkpFtwb+xjdiCh9fO3q
         EGGGPYZN+U56jc7yjW9Gdci6bBkCNwccXdTeTyQdC1k+P07XKDq7q8PE4viSeqnYfTzx
         olQOPCZuUKwUDl3lbZBsyfsccsRQeu6V9oYQmulxLldkBTWuy2+7IypNTeUM6JtNJD0k
         Mr8g==
X-Gm-Message-State: APjAAAXP2mYZeZfc6Ffk+VvAD7NAOiMRd1WW/BnX+YRUO+UFkdIuozrs
        Os8UVOZAQ+s7tOiRKAQQlykgviG6rpd97Q==
X-Google-Smtp-Source: APXvYqzwNfWNKzgHzXq1BGR2F1WhVCqqyoNM6BTWmHvMZnb5iOaor6b3x1w5X9rfxMxBttPDc3JlEg==
X-Received: by 2002:a17:902:24c7:: with SMTP id l7mr44234382plg.192.1558572710498;
        Wed, 22 May 2019 17:51:50 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id o66sm30182106pfb.184.2019.05.22.17.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 17:51:49 -0700 (PDT)
Date:   Thu, 23 May 2019 08:51:33 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, dvhart@infradead.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c
Message-ID: <20190523005133.GA14881@zhanggen-UX430UQ>
References: <20190517082633.GA3890@zhanggen-UX430UQ>
 <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ>
 <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In efi_call_phys_prolog(), save_pgd is allocated by kmalloc_array(). 
And it is dereferenced in the following codes. However, memory 
allocation functions such as kmalloc_array() may fail. Dereferencing
this save_pgd null pointer may cause the kernel go wrong. Thus we  
should check this allocation.
Further, if efi_call_phys_prolog() returns NULL, we should abort the
process in phys_efi_set_virtual_address_map(), and return EFI_ABORTED.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a..a7189a3 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,8 @@ static efi_status_t __init phys_efi_set_virtual_address_map(
 	pgd_t *save_pgd;
 
 	save_pgd = efi_call_phys_prolog();
+	if (!save_pgd)
+		return EFI_ABORTED;
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f..828460a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -91,6 +91,8 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
 	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
+	if (!save_pgd)
+		return NULL;
 
 	/*
 	 * Build 1:1 identity mapping for efi=old_map usage. Note that
---
