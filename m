Return-Path: <linux-efi+bounces-1284-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45839140CF
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976BD283B4F
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAD16FB0;
	Mon, 24 Jun 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SeAud3hX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25234A31
	for <linux-efi@vger.kernel.org>; Mon, 24 Jun 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719199433; cv=none; b=aFeC0iiYgmxVQAusmSuH9XIafXCBn481nevwrwcjYH67sBM4sX9gZQxqGFKR/Qw9vuG0jbR8HoYYwwcoCdcv2qWLmNiqddf3KIXPs1jLAmB2OGyGF9Szag6LwudyIoyU+I/T3sM3O+BY4y+f73uRNmg+FzjTOAu6pERRSdXb0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719199433; c=relaxed/simple;
	bh=lZcEMmty7YYc4yV+0jbs+lDLlGoNtN5lfaDIS8gEpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7nnIprDPAisXXf7ZyIE5yeIGZnqeveRrUESiN8qlT14Agfkhv8Rn9yAuWX1jk38e4QE2U6RQMatl8+5NRSI3PykqBeH5LAvF+pQMACzcSapbgJorVtaz+Am2+X6WUPyXXGT19IfDjIpH7hKe6ckXTzUqgDReh3pUfHUjH+kTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SeAud3hX; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f97a4c4588so2287557a34.2
        for <linux-efi@vger.kernel.org>; Sun, 23 Jun 2024 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719199431; x=1719804231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FWaEUeTMDHJoELxY+ZgcV9lMMpnHL5SsFDjxF9/VXs=;
        b=SeAud3hXL/2RdDm/2wUpJBK6M3s7uu9cwnvnKvHvYYCR6Yy4RqtG3kcHy4Zmd3copI
         uoKhf71ysYu/EZZvrnFgAKfUH8GA/HF2W5xFyOypEXoBVYS4VEeJTFBuHje/jBe3wn/G
         m8Wo3vR2VI5lfqZztjgtfxQUJrBuolu1kEcyH8HIXlPJjuEi993UewgOP+gPsoyTt3sq
         lxEacv3CuJy5tNIP4hiTZobEUZT4JTLzguJmMJEGcvNY71+v8pJ7hnvbezyyjPXeT1Ys
         lkiXoKo4oYXLt33qi8I8x/DEimROdL/elSiFoyO/JT/ARciMj98Yvzc4TupK4EDNtYyK
         g5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719199431; x=1719804231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FWaEUeTMDHJoELxY+ZgcV9lMMpnHL5SsFDjxF9/VXs=;
        b=tea5b8qhLuLzzxkLTuyDFNAeW+tRdJMkN4teEwlsw/ZpZIN9OhJYQL7VhtRB4q6tyv
         ggVX9QOE5ckqaT8W+iDRCQiebSwbDq29MB4r8JFJc8EqH4gOegpowPerFCVrgM0sm6Dc
         QtrvRn7z47Gykvl9BrfdjJpH/i9YvIDvH4UB/bg9etJIcIrCJfv6PeajNqlFJl/Xlvdm
         VQVUQPSSEKiznrX8s0EPU5o7H/VJZBqzR8YXQ6mtR9EN5V/0T+PA1Vy4YjIFiK3cMYz2
         8BDPVXp5IBvc/WSAjyenRLhHSSQkBneZ/tlVCNEOYl3FBquCdwTHs7XQUbaH5MqtUsjr
         QHDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqTLdql/Sep6D8pw3ls46aslfRixhufo+sIA58YJDM8gRZaDcpkwGn7Ep7z0hRKC+xdCYbrA7hmB3X9CBLbXS3AtZ0+sGgXUK0
X-Gm-Message-State: AOJu0YxzVUlQIJdBYw5TtEiJsIkyyqS5EuTvBddbmyjrEZfR5qJP78Vb
	AafwNP5klAYyWt21BGsSrEEw2eo5NdVeEVrIrFumomi8VpC7CKmpQAVjrcmsSLWugWX19bRgUPQ
	X
X-Google-Smtp-Source: AGHT+IE+osSaSeirW6Qbfg0AmVximTUoIwMN39FxDLs9j+BLB3XcDNJN4I4yZNiCnV4rh4f1rTSaSg==
X-Received: by 2002:a05:6830:4428:b0:6fb:9752:4d3a with SMTP id 46e09a7af769-700afa03484mr4199879a34.24.1719199430755;
        Sun, 23 Jun 2024 20:23:50 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:e283:b00b:36c9:cbf5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb040d0esm3811211a12.79.2024.06.23.20.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:23:49 -0700 (PDT)
Date: Sun, 23 Jun 2024 20:23:47 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Ard Biesheuvel <ardb@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] riscv: enable HAVE_ARCH_STACKLEAK
Message-ID: <Znjmw469+P1iFRHg@ghost>
References: <20240623235316.2010-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623235316.2010-1-jszhang@kernel.org>

On Mon, Jun 24, 2024 at 07:53:16AM +0800, Jisheng Zhang wrote:
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
> 
> since v2:
>  - add #include <linux/sizes.h> to fixing compiler error found by
>    Charlie

Thanks!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
>  arch/riscv/Kconfig                    | 1 +
>  arch/riscv/include/asm/thread_info.h  | 1 +
>  arch/riscv/kernel/entry.S             | 4 ++++
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 8 insertions(+), 1 deletion(-)
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
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 5d473343634b..fca5c6be2b81 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -10,6 +10,7 @@
>  
>  #include <asm/page.h>
>  #include <linux/const.h>
> +#include <linux/sizes.h>
>  
>  /* thread information allocation */
>  #define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
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

