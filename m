Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58A1DFFB9
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgEXPMT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEXPMS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 May 2020 11:12:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7DC061A0E;
        Sun, 24 May 2020 08:12:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so14872709wrt.9;
        Sun, 24 May 2020 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wX9254Tawo97HEIC7Lik11yES5ykzHmRr/c4BRavRG4=;
        b=VbTvtDBZ8GtfGdhGNl9ZbgfjN+8ZMPeZhRIOmU2rNB2QGpNcrRkm4ZCx/4AwvTPEdE
         p2aDPjU6EGMMykr5sdWnikPgpz8BKiOBbC70Z+fSpEjVuBGs75Y5qdui6StVFbMo2AcU
         eDMNX/FdBcqQhgUJImiQdr9h0fyYSbOebt66IqvlINHbULWH+/MW7yE0mEEa41oYKTUW
         pPMekQ3zN4uTZDaQZG5/6JC/oU2HePzktyRkyHR3U5vY+wbt7ffdJLz5mk7VRAjlFLxO
         dpDkgheWcRfg6l94rQBvTvF+lNDf4PU+o1zjWkCwUa+zJJxF3iCUbyOTOoEIFvOkb1Kj
         9ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wX9254Tawo97HEIC7Lik11yES5ykzHmRr/c4BRavRG4=;
        b=GAri0p9i5uYXnU7EVDSh58/2QT3ik7ktBYGXba5J94MxiNhGAn95hf8r8EKK5WjLV/
         DlLhuPHLQtV15ajQtciSV5axpoZF6pZapaSecZYRHP/yFA/wH1DWM7pIMiAEh393S1ph
         4kizFsBBFMbE2WPAw9Ws28yNZsaAnjmIQFQjpOjiOeHsT1G3c+KPYTEejZcSgkdLJBSd
         FgQeHoSSqHJLr2Zka1R6ii+JpWW2CzuyK4J2BWKXPks645e3QofjS6ND1y3+Lpf1ShFy
         aKE2Jv+B1ruH2JvP7tIhdZtSfZFq3KznegKMMrKc5Yg2pneIewfagxo6/Hsi7X9o7GPE
         UyDQ==
X-Gm-Message-State: AOAM530n3hRKg9QVgx4L7ivo6N8t9c53gkVJQ1gCBQwQkwmGWr6swQNh
        HFbgoKKKqyW28vnn+MAqd6KzQQSe
X-Google-Smtp-Source: ABdhPJzigocobniwzopD6Em27BeKoEDRqAMtP3NfAY0sSLL7r9fCVMSiDzkoWSioU6CoZiSJo5PnSg==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr3818773wru.211.1590333137310;
        Sun, 24 May 2020 08:12:17 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l18sm14911160wmj.22.2020.05.24.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 08:12:16 -0700 (PDT)
Date:   Sun, 24 May 2020 17:12:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
Message-ID: <20200524151214.GB11617@gmail.com>
References: <20200523120021.34996-1-ardb@kernel.org>
 <20200523120021.34996-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523120021.34996-3-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Eliminate all GOT entries in the decompressor binary, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
> 
> To ensure that no GOT entries will creep back in, add an assertion to
> the decompressor linker script that will fire if the .got section has
> a non-zero size.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 5f7c262bcc99..aa9ed814e5fa 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -40,6 +40,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS += -include hidden.h

> + * When building position independent code with GCC using the -fPIC option,
> + * (or even the -fPIE one on older versions), it will assume that we are
> + * building a dynamic object (either a shared library or an executable) that
> + * may have symbol references that can only be resolved at load time. For a
> + * variety of reasons (ELF symbol preemption, the CoW footprint of the section
> + * that is modified by the loader), this results in all references to symbols
> + * with external linkage to go via entries in the Global Offset Table (GOT),
> + * which carries absolute addresses which need to be fixed up when the
> + * executable image is loaded at an offset which is different from its link
> + * time offset.
> + *
> + * Fortunately, there is a way to inform the compiler that such symbol
> + * references will be satisfied at link time rather than at load time, by
> + * giving them 'hidden' visibility.
> + */
> +
> +#pragma GCC visibility push(hidden)

BTW., how many such GOT entries did we have before this change, on a typical kernel?

> +ASSERT (SIZEOF(.got) == 0, "Unexpected GOT entries detected!")

s/ASSERT (
 /ASSERT(

Thanks,

	Ingo
