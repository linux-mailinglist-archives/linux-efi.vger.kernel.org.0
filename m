Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1B12DC40
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLaXEj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 18:04:39 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45407 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLaXEj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 18:04:39 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so13768216qvu.12
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 15:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhUc/1Doyl6yHwnTb+0TidLzdtNEKJ8aLybfLFEBTeo=;
        b=OKy7hCeeHenq/MQ66kKJsHcRESH5cxwvCCr24KjaOxcSm2fQfOZ6ZAQ3Q737dOXBoz
         VZwbnsAZ3tNKEDpn/vYKC7y1zeZtg+8OFNimQwY90fN2uCQIyLslwDQgYWTztZTFhtgu
         KZrt8bSaeWny2bWLT02SDxA50S79E165QSDPiYZRCSkSWIssooU5VUwtuigL7NPjvvaj
         /L4YzA2gGEMlch8/TaLq8qrWtWt31Rp2FkGTJEvk/hiJTcW8B61rPSmTO2JLRnYgEOZr
         BfIX3C0U+uZnEPrN7zpXIhv9F+xBMRnxsS2rgVr5qWAc7HNxdduGRyczno+f8WPtADQE
         JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhUc/1Doyl6yHwnTb+0TidLzdtNEKJ8aLybfLFEBTeo=;
        b=LKA1WRRsYsZwTljDQdkr9wAtDoJnaPMI9c5PtlGpmwDTBFGDytpShsHc7vMMGfRTBn
         DSYILLuswBI0+P90xLptN+rzuIHxcrd5YkqC8XSfO3JbXQugXlPAzLEbci5p8Dwzo9ss
         s94ZFx4gixJqCDdEyUR+QPy9pkt4I6MzTkNYGLoWA5EXsob2cCx5tXtRdAdGANuKYPTJ
         DWpwQcjWITRaViC6OYsIeV2N6cZl7PsEACMl30ALX2qDEO77jXy0LwemfkGjiKfLaQ3l
         14wwRc6x/7tgREZJBHb2KLa6MQLF8UNb2BefW2R+C6b8LesshyRuHIZbVlim8prXhzrF
         SfCg==
X-Gm-Message-State: APjAAAXQNKLeU6xAlcdZPLjfQ1FExSz6JQ6/XHnb2Fpw1H0IUAh0sFzU
        ww2X9oMWKFCTPEGHcvCRE9Q=
X-Google-Smtp-Source: APXvYqzbEHjOH270SD4BgdTitK+1yPGBPupeSgZuybx3wZvoefEQkEcUPhMw8GtaG/bGf5Vbuhch7g==
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr42024915qvb.202.1577833478536;
        Tue, 31 Dec 2019 15:04:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m95sm12752198qte.41.2019.12.31.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 15:04:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 31 Dec 2019 18:04:36 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20191231230436.GA78532@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218170139.9468-14-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 18, 2019 at 07:01:31PM +0200, Ard Biesheuvel wrote:
> The various pointers we stash in the efi_config struct which we
> retrieve using __efi_early() are simply copies of the ones in
> the EFI system table, which we have started accessing directly
> in the previous patch. So drop all the __efi_early() related
> plumbing, except for the access to a boolean which tells us
> whether the firmware is 64-bit or not.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/eboot.c   | 36 ++++++++------------
>  arch/x86/boot/compressed/head_32.S |  2 +-
>  arch/x86/boot/compressed/head_64.S |  4 +--
>  arch/x86/include/asm/efi.h         | 23 +++++--------
>  4 files changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index 2bcab1ef5a56..53e67334c4c3 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -20,11 +20,17 @@
>  
>  static efi_system_table_t *sys_table;
>  
> -static struct efi_config *efi_early;
> +struct efi_config {
> +	u64 image_handle;
> +	u64 table;
> +	bool is64;
> +} __packed;
>  
> -__pure const struct efi_config *__efi_early(void)
> +static bool is64;
> +
> +__pure bool __efi_early_is64(void)
>  {
> -	return efi_early;
> +	return is64;
>  }
>  
>  __pure efi_system_table_t *efi_system_table(void)

This predates your series, but looking at the generated code I noticed
that pure isn't enough to let gcc optimize out repeated calls to is64
and system_table. Declaring them as __attribute_const__ would allow
optimization. They don't quite meet gcc's requirements for that as they
access global non-const variables, but it seems like it ought to be
safe, especially if we stop using the functions within eboot.c itself?
