Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914412B7E1
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfL0RwE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 12:52:04 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36972 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbfL0Rv7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 12:51:59 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so10286751qvi.4
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AK8DzOWOdzcoZ7pM2nuZC9y/mHOeL2mRGUY2fabmWsM=;
        b=VKlVIW4WBOh4onxGL9DrocCHtNAsYMT4LKb3k+vo6EToUDcYYtdzZt4rusx2p1indd
         zOnW5RCoDxe9Sq7DX30lSt6CZN6xKnPXiJvw6J/wCjwJZaWWvquY0GUNcpgynBGjZrKQ
         i9k6Xi1MPI7t+T8MmA6VkLinJgC8WQ8x9EHSknh4HlM1gjVmNUdzo9RfM53T1OvkNJkk
         wvdAukK+7YoCwcceJiLSLHhZVPd8XXLSVJvV/8d0XryjgVTS4KI22raEOvGOUrYLkU78
         Np00dD4jNivWCGbS13FB3aUwkZmg4F2S9+UWZFyBMaHXFHGH4HtBjA7Sbfom+78bQXlh
         BB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AK8DzOWOdzcoZ7pM2nuZC9y/mHOeL2mRGUY2fabmWsM=;
        b=jaCh2JzopTDyJR8jH3gWnx+XdM6GUB0WSdEOpYPCY2GEEcvDsbR4VG0zTI3KbDxXsv
         4Ox+IY8oRtDiEjix7Tr2YnUlAHsKHy1JmEb6pbzGX8jUQzOChswDKdhXgUy64csx2bne
         3AfZc9BaqqEasZgtmuShqg22v9Vg+UynRmCbuHTh/RKQ0AKmvI+vjgiqHmWYYPq99y7e
         OxmnDcHuofl3JxpKlsCLDMmAPlOh1W1KnlsVnpjeTljv2nJ2prDRVn7s3c83TxqTE4fR
         pFG+1f0eGrW+k9EmVFRaE9EHmOSfDNqub4t2CZ0wmd0zNFZbcs0eLKnFh2AWcdVdarEa
         qLxA==
X-Gm-Message-State: APjAAAUMUmkA8kIj5N1MhadIt/uzjAXpuigxOKMPglpAaE7qkGy/pi1w
        rupZyeMzHqXHT/DpEXAFZwY=
X-Google-Smtp-Source: APXvYqygqtTP9dpCs0+rzVl5dtmxP42kEe6Lfj+K+PAab9KMquWEq1APsY8/vRSSIySBGz6zQFU0oQ==
X-Received: by 2002:a0c:fa43:: with SMTP id k3mr40194895qvo.229.1577469118363;
        Fri, 27 Dec 2019 09:51:58 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o55sm10966786qtf.46.2019.12.27.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 09:51:57 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 27 Dec 2019 12:51:56 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, nivedita@alum.mit.edu,
        hdegoede@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Message-ID: <20191227175155.GA584323@rani.riverdale.lan>
References: <20191226151407.29716-1-ardb@kernel.org>
 <20191226151407.29716-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191226151407.29716-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 26, 2019 at 04:14:05PM +0100, Ard Biesheuvel wrote:
> The efi_call() wrapper used to invoke EFI runtime services serves
> a number of purposes:
> - realign the stack to 16 bytes
> - preserve FP register state
> - translate from SysV to MS calling convention.
> 
> Preserving the FP register state is redundant in most cases, since
> efi_call() is almost always used from within the scope of a pair of
> kernel_fpu_begin()/_end() calls, with the exception of the early
> call to SetVirtualAddressMap() and the SGI UV support code. So let's
> add a pair of kernel_fpu_begin()/_end() calls there as well, and
> remove the unnecessary code from the assembly implementation of
> efi_call(), and only keep the pieces that deal with the stack
> alignment and the ABI translation.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/efi_64.c      |  4 +++
>  arch/x86/platform/efi/efi_stub_64.S | 36 ++------------------
>  arch/x86/platform/uv/bios_uv.c      |  7 ++--
>  3 files changed, 11 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 03c2ed3c645c..3690df1d31c6 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -84,6 +84,7 @@ pgd_t * __init efi_call_phys_prolog(void)
>  
>  	if (!efi_enabled(EFI_OLD_MEMMAP)) {
>  		efi_switch_mm(&efi_mm);
> +		kernel_fpu_begin();
>  		return efi_mm.pgd;
>  	}
>  
> @@ -141,6 +142,7 @@ pgd_t * __init efi_call_phys_prolog(void)
>  	}
>  
>  	__flush_tlb_all();
> +	kernel_fpu_begin();
>  	return save_pgd;
>  out:
>  	efi_call_phys_epilog(save_pgd);
> @@ -158,6 +160,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
>  	p4d_t *p4d;
>  	pud_t *pud;
>  
> +	kernel_fpu_end();
> +
>  	if (!efi_enabled(EFI_OLD_MEMMAP)) {
>  		efi_switch_mm(efi_scratch.prev_mm);
>  		return;

Does kernel_fpu_begin/kernel_fpu_end need to be outside the efi_switch_mm?

If there's an error in efi_call_phys_prolog during the old memmap code,
it will call efi_call_phys_epilog without having called
kernel_fpu_begin, which will cause an unbalanced kernel_fpu_end. Looks
like the next step will be a panic anyway though.
