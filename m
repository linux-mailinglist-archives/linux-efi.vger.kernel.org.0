Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC212EE8F4
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jan 2021 23:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbhAGWna (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Jan 2021 17:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbhAGWna (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Jan 2021 17:43:30 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C40C0612F9;
        Thu,  7 Jan 2021 14:42:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p187so7781152iod.4;
        Thu, 07 Jan 2021 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ClvZg5sXEBf05sG52Cw6cJJLIc0iBfkKfgRvrL6xzOA=;
        b=GsYBJoZSZz1zfpdXAOQAjOF4V53vxD3dAg+EqhHLSdwh1kl8RV9+00NIGB8gqXeC4V
         kVqxytWSg6d1G2cH9dCeh1B+Xie/TqS1RziAdeaetE4u6CbQi5ccjFqucI3pqxegyFUf
         zU7mtJN8qFtJLRf0mpVXYz0LI9/e/pTWtjOm0UqwcAwe9D23sR08GwBr+6iViJy8Wit+
         8ZElEiVqsetfdJY1YNxER6kSzgHYaj7boInYyas96iSMn9gY9//NF3Rv56WZ5eGXZz7z
         OGISKsS4JyL7YkWrnwVPSoupRrYUj7+OZ0VgQO4kdwVu6q3gHXhJFemQJcB/6uk5suHq
         HHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ClvZg5sXEBf05sG52Cw6cJJLIc0iBfkKfgRvrL6xzOA=;
        b=hsJ0+eu1YgrwSYKzUZDu4WoElag5AXTIN947j5mQYJkJuDogNBGl4J62yXwEc5FGrw
         Why9Xh5LTeJheudFa2QzRLYn8rbW6AGT7E66SHUFZ59i0drzaCcdqU2XKvIwIeyHELZ+
         IOEPqRvNVer7cNX1Dd2NnoTU8JHCdakshSRLwSWLPIoA6XrbxtKtfppx1R3BUBQMYYCa
         929iFjDzfKZaa47gWRQVWFbYsjY0C1mMHjehSc1fmeul+opbxYvOmQeNGGJK7GQzfBS9
         2Gk3gZhAgXL1U0c+Z118SR3nXA5oRagsisa705fHI2h+XxVMAZ3QdDyXA3rdgyjv7npB
         OuBg==
X-Gm-Message-State: AOAM530vQD9Xz5zcKC+FMb/zILfuOEEvJ4PISKK79VMm2PyHkZclqv1R
        Xc2VVVMt3yF9GI5lKQJjJd4=
X-Google-Smtp-Source: ABdhPJyBTLpYz5asmOilyUxjvSDFEKHMcjL80raiq3BOLQgvhOFy4OXvaVFiQwSrmr9ddXJkApBiwg==
X-Received: by 2002:a02:ccf0:: with SMTP id l16mr681541jaq.5.1610059369101;
        Thu, 07 Jan 2021 14:42:49 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h17sm4120758ioz.12.2021.01.07.14.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:42:48 -0800 (PST)
Date:   Thu, 7 Jan 2021 15:42:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210107224246.GA3523037@ubuntu-m3-large-x86>
References: <20210107223424.4135538-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107223424.4135538-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> 
> x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
> 
> Use the same method as in commit c65e774fb3f6 ("x86/mm: Make PGDIR_SHIFT
> and PTRS_PER_P4D variable") and change it to MAYBE_BUILD_BUG_ON(),
> so it only triggers for constant input.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/256
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/x86/platform/efi/efi_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..62bb1616b4a5 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -137,8 +137,8 @@ void efi_sync_low_kernel_mappings(void)
>  	 * As with PGDs, we share all P4D entries apart from the one entry
>  	 * that covers the EFI runtime mapping space.
>  	 */
> -	BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -	BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> +	MAYBE_BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> +	MAYBE_BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
>  
>  	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>  	pgd_k = pgd_offset_k(EFI_VA_END);
> -- 
> 2.29.2
> 
