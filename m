Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1ED2167C
	for <lists+linux-efi@lfdr.de>; Fri, 17 May 2019 11:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfEQJnt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 May 2019 05:43:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfEQJnt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 May 2019 05:43:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so3053399pgm.7;
        Fri, 17 May 2019 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+dra/4iX7xwbArwOwB26lkZ4hD6j6efa0Wr5nYhpA0I=;
        b=d3ofsitpLZcZYJZ/+5+gaaxyS24OPv8VSIWpbTKtgeyh8QcpAYHu7yWy0r2kcH9AAJ
         46AJhjQK0Jo8DW7t/xby1i0hs2B5tGMKaaWDSXpkHS/n369hHjkYJO7gshEGxRlmmXsP
         xdrwbEtZ8xdY9OrWP1D+gomU2h1nXj1CtsNPHBotpP5OpOzfTkAJcImS+KYO3j1DXss2
         Fpc9G+0F71nLe9S2eHK1tszJftkAqCYTAxZczjPYSZZXM5RA5G7AL8da7LeJTH8BvA5y
         DGW+P/U8AXx3U9biiTHGfimHYCeaptc8Gs9ayWN41Wjew4NIn/eGauByoSCJlhmm/K/Z
         +UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+dra/4iX7xwbArwOwB26lkZ4hD6j6efa0Wr5nYhpA0I=;
        b=WVcsZTSDfsrqXi4iZlQAkmd4Vol/vI3cQe51uGbB8sbEuCPvPcPrCqVeobp5iiVKK9
         9luq0PBONKneQUwGJ2bw1pmOhjiEg8czqAEfyRZ0HbQ4qt/QDckvnZcERUuwoLXThQIu
         0VbxHAVKZzVRGKna/QV80SgdN1A+ki0EwRjITlgaJhtj3WelY7rLeWJhxZKiXNWdUjUj
         /tVfIAZ2AHdkIncxz1SNOxsS6iwxDisTggaAFNmkr9v6RyyGNaWxPglOXWC497wJsUJV
         acSISv9mHIIbCbQSTucMUPE2dxAObJ+sWq24WVbD0RK4mnCeprWhO1JfJSV9Gr4zpvvt
         XOpQ==
X-Gm-Message-State: APjAAAW0U5X2XxHeKhN/wooLWbzNmQaYvyWBYkk87Mr/j6vMswjRbnwU
        3E+A6bAqtCXU1fhEYAQHkoc=
X-Google-Smtp-Source: APXvYqwIIbVoXjW6MBWF2yRKlMoZvX28HtwQ16t2WQLeS19JGJtZKtc9PYCCKhMsAUy0pd4iUm4adQ==
X-Received: by 2002:a63:8342:: with SMTP id h63mr57060699pge.251.1558086228915;
        Fri, 17 May 2019 02:43:48 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id s72sm11569041pgc.65.2019.05.17.02.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 02:43:48 -0700 (PDT)
Date:   Fri, 17 May 2019 17:43:36 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi_64: Fix a missing-check bug in
 arch/x86/platform/efi/efi_64.c of Linux 5.1
Message-ID: <20190517094336.GA4728@zhanggen-UX430UQ>
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

On Fri, May 17, 2019 at 11:24:27AM +0200, Ard Biesheuvel wrote:
> If efi_call_phys_prolog() returns NULL, the calling function should
> abort and never call efi_call_phys_epilog().
Hi Ard,
I edit the patch and it is as following. Returning EFI_ABORTED would
be proper, because the return value (status) is checked in 
__efi_enter_virtual_mode(). And returning EFI_ABORTED can abort the 
process.
Thanks
Gen



save_pgd is allocated by kmalloc_array. And it is dereferenced in the
following codes. However, memory allocation functions such as
kmalloc_array may fail. Dereferencing this save_pgd null pointer may 
cause the kernel go wrong. Thus we should check this allocation.

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
