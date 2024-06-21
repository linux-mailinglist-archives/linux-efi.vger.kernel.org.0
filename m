Return-Path: <linux-efi+bounces-1277-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCF913016
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2024 00:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB732888F5
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 22:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D038FB9;
	Fri, 21 Jun 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HXM3+qjX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5DB17BB32
	for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007848; cv=none; b=pxY3F89aa5r6jETwYapfaNMJVy9NVHGxAe7F68a9mBXixG1qpaN+F8VvK/S9i6wmmhRxt14jI/DKoDIxZNJRZ/t1GN4LquYh9Rq1LmJiv4ajhqHnv9mb8K65Y09gheZvfbvvv1Kp2NjZct4k7qFJQ5d0J63867wIbctUHmAq90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007848; c=relaxed/simple;
	bh=ZEyjg1DGdHfvMHVyn3oiXgYoAsPB9kPjfgjytYscvC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe01hW8UKTcexk5Gyw5dNomfjyMihOkgwI3YnUdvCjB68g2OYTJLa7gWX+v7srZTeW1w6/qDGJ9XHp7jEVfjjGhOhs9vFjh58THI1cj3Y1u60qC0xMO9m3TiYHs1RQVSeSbo8kqUlYQWesFzar/sxKXrro5gBFdRFHCWQNhRjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HXM3+qjX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a5344ec7so17317655ad.1
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2024 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719007846; x=1719612646; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W6zNTGp1aTwOtvLdnUXPrvSqBQrllJdVcW2FVVgDB5g=;
        b=HXM3+qjXxtXZ59+HmVscZ/hJS6if3zHHfXT84Pi+RsoH+Vteq9ece+6LBs+pm4XXDN
         ZqN5p91ivkN4iEO2UWDal+H9R/nkwhF0mnrNCZegFNcKlXvD6q+7wyRPnyXVge7W0HIx
         vG8rGq8j+Mq3qFbRKFaYO0RHGB5NYVAA4r+g5dafKAZbK8smEUBlUV63fPJHD61+BNZQ
         RxLqQvVIcISTeoWD1MsVcsPqDM+IpX1wtkws2YOeDnlInOjMIOlDMHE1x/PQRogVHsFL
         IhDVGv0Sd0oGzHWkaA6tpLOWLK+V105PqUmeputuqWPzU4aUBjR5qVSIZaP1Ab3tQta3
         JSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007846; x=1719612646;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6zNTGp1aTwOtvLdnUXPrvSqBQrllJdVcW2FVVgDB5g=;
        b=wNfYIXZzujjvgiP3jw6AuFA+6Zn79ZqY3AFV9zjce5tIHG/ET7e2TDoHlljtBCrwsJ
         xvtdO6YZuiPNWkJFqMvrF/tVsmI8E2mgBKk0zkgxV5g4LZkovofjDoZ9mrqNebCuIZIA
         Bi0pNg3H+9AwpAFFLANmaPAERkvL9K8R3r11ucWpSUX6RMvj2bxesRTpsnGtilDY7/id
         oNPbkw1J7a7W5iBp1N/AB7QffWp/xchbltOgC+1e/nKelcvY8tQyzoMogWeNFWMoMvni
         TyDHMlONn2+YTu9FPgIwbgKzYFPAGGuQOyz0fnEONSE0bLLMCxIA/Qe6BcqGobl5iRlm
         cOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVaG6QGwSDVONje11BcvNI7htj2S5C+dAgKFemvPjjeNtXtT4i1e2ddWksAes3tOx4rRUjYrO34pEmW70i9NAEHW+sO2tjIqHfV
X-Gm-Message-State: AOJu0YzOWKivrVuD3ZQ4wwoPGOQ08Pl9BpT/vVSXkidvWnUyPO0fbkhM
	/JjCIKONbFndgtUW3gxtPgbdA+EznYk8j0tMupGq/tuCenQ+g0viOTXljA1TsLQ=
X-Google-Smtp-Source: AGHT+IFodC/KHmQCg2O0jJBVOPuXhUN5lF51VkVlsO14ggFbC93W0YN4q838joM1PZnjh/NG3CSEVg==
X-Received: by 2002:a17:902:e84d:b0:1f9:f906:9082 with SMTP id d9443c01a7336-1fa04a42126mr12275615ad.7.1719007845678;
        Fri, 21 Jun 2024 15:10:45 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:e8dd:a296:71d5:2490])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e030dsm18868865ad.218.2024.06.21.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:10:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:10:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <ZnX6YtFGfXd0ixwR@ghost>
References: <20240617123029.723-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617123029.723-1-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 08:30:29PM +0800, Jisheng Zhang wrote:
> Add support for the stackleak feature. Whenever the kernel returns to user
> space the kernel stack is filled with a poison value.
> 
> At the same time, disables the plugin in EFI stub code because EFI stub
> is out of scope for the protection.
> 
> Tested on qemu and milkv duo:
> / # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
> [   38.675575] lkdtm: Performing direct entry STACKLEAK_ERASING
> [   38.678448] lkdtm: stackleak stack usage:
> [   38.678448]   high offset: 288 bytes
> [   38.678448]   current:     496 bytes
> [   38.678448]   lowest:      1328 bytes
> [   38.678448]   tracked:     1328 bytes
> [   38.678448]   untracked:   448 bytes
> [   38.678448]   poisoned:    14312 bytes
> [   38.678448]   low offset:  8 bytes
> [   38.689887] lkdtm: OK: the rest of the thread stack is properly erased
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig                    | 1 +
>  arch/riscv/kernel/entry.S             | 4 ++++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..9cbfdffec96c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -118,6 +118,7 @@ config RISCV
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
>  	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_STACKLEAK

When this is selected, stackleak.h include
arch/riscv/include/asm/thread_info.h without sizes.h and I hit:

./arch/riscv/include/asm/thread_info.h:30:33: error: ‘SZ_4K’ undeclared here (not in a function)
   30 | #define OVERFLOW_STACK_SIZE     SZ_4K
      |                                 ^~~~~

Adding "#include <linux/sizes.h>" to thread_info.h resolves the issue.
I am testing this based on 6.10-rc4. Did you encounter this?

- Charlie

>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..80ff55a26d13 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,6 +130,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  #endif
>  	bnez s0, 1f
>  
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	call	stackleak_erase_on_task_stack
> +#endif
> +
>  	/* Save unwound kernel stack pointer in thread_info */
>  	addi s0, sp, PT_SIZE_ON_STACK
>  	REG_S s0, TASK_TI_KERNEL_SP(tp)
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 06f0428a723c..3a9521c57641 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,8 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
> +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
>  
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

