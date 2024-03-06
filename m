Return-Path: <linux-efi+bounces-738-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A348732A6
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 10:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA0A28BC13
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735705D8FA;
	Wed,  6 Mar 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkKyx24L"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0D5C5E9;
	Wed,  6 Mar 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717779; cv=none; b=BJyIbee/bQGcB25b0cpXYS18KBr2u+TrJgYZFJbjCzd7MgTu8e/Sh/kdfcN7+VlGYIoINdjz7YHfRw7D30enJ4UJuTZxkyVp2MLVFomxevHinKzqcAVrQEvXl1s7ZVhKpP2Z4DZ1oyt+RDROANKdxU1pN/Lf2l9YSa5PdwJYgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717779; c=relaxed/simple;
	bh=Se9wdvPcfwsLMnlMhoVHGwUCXB5idZL8wbJKmJcBmmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHZAWgqyVHh/HPgdt8J/tFlAL9AaqJeBEuwnN57LDCXgp/LNtdT+XgwBCBy+Hek1/YJwEKjeXa3RpLrVGbTN5mGWpG6/ysL2QfAqdLolbUyruU1VNXU+fkfo3LLkMExXYvLrzmS3J114nZnesPmOOG2VibIrpq4guO1ggFgY/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkKyx24L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA30C433C7;
	Wed,  6 Mar 2024 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709717778;
	bh=Se9wdvPcfwsLMnlMhoVHGwUCXB5idZL8wbJKmJcBmmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OkKyx24LBAtPLpc+TBxhgzpXcEfA6howp/kefDleQHw1Ve1Yoq3DexZu/yWkqCHgy
	 QDAuqr6mNXVpuCReXUD9B+/jcurZcl8jH4IFfS3/ba08mTQB2FhNfK067Lqg99LwPK
	 Dkq+SkOEQ412pRRgAXoWMl8hhq8pFlLpRZqnXWwWX8mlzw5prIMwJybTutxjDby+zy
	 AF/9UmncS2StBFHApltsRz+X9+jo7Auh/y7yeaE9Eg+ZCRRU0nTuJTFvTppQ13LUma
	 wiFfFwyrzxMve+vGQpyCBUTJq+J7LuVTqQtAGZkUPpMemaRtk7pOAJyowoP/uBHmdv
	 y827Gf95BgS8g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513382f40e9so5273787e87.2;
        Wed, 06 Mar 2024 01:36:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtWvIdys63wkcf90W2MXtReeMx8CFxpavtDftdiEDXcHhCdCPidbE4qkLZ27ZWvGm76AN5AMBrheTKw7iskffH4IcDMy6aa+I4xlpUl9pjWYSZyL9mS1XMdXTL4PN8zvQWZIdm2XSb
X-Gm-Message-State: AOJu0Yy47/lDHSzrB992qxAwIEGSrNw7Ewv8yJzUk/Obooo5goiim/8Q
	3nkUvORm45p6v6YQPco/WsbZqdT7jGW9XpYbRpjiwic0GUI3ANibrsN9Qca3SyX23L9Qi312JDx
	5dW5PzuznXnJesIT23tWy/eHg22k=
X-Google-Smtp-Source: AGHT+IEMgCslxhLZ/P5O8FRuHnnFrVW+nfIzYlt8WG8WJRe/qMTqTOr5zH3MK7+X6hnJM9t4viwIHIiySb9OGMZ6odM=
X-Received: by 2002:a05:6512:2c8b:b0:513:4777:f8c9 with SMTP id
 dw11-20020a0565122c8b00b005134777f8c9mr3591641lfb.6.1709717776891; Wed, 06
 Mar 2024 01:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com> <20240306085622.87248-3-cuiyunhui@bytedance.com>
In-Reply-To: <20240306085622.87248-3-cuiyunhui@bytedance.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 10:36:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
Message-ID: <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efistub: fix missed the initialization of gp
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>
> Compared with gcc version 12, gcc version 13 uses the gp
> register for compilation optimization, but the efistub module
> does not initialize gp.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>

This needs a sign-off, and your signoff needs to come after.

> ---
>  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> index 515b2dfbca75..fa17c08c092a 100644
> --- a/arch/riscv/kernel/efi-header.S
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -40,7 +40,7 @@ optional_header:
>         .long   __pecoff_data_virt_end - __pecoff_text_end      // SizeOfInitializedData
>  #endif
>         .long   0                                       // SizeOfUninitializedData
> -       .long   __efistub_efi_pe_entry - _start         // AddressOfEntryPoint
> +       .long   _efistub_entry - _start         // AddressOfEntryPoint
>         .long   efi_header_end - _start                 // BaseOfCode
>  #ifdef CONFIG_32BIT
>         .long  __pecoff_text_end - _start               // BaseOfData
> @@ -121,4 +121,13 @@ section_table:
>
>         .balign 0x1000
>  efi_header_end:
> +
> +       .global _efistub_entry
> +_efistub_entry:

This should go into .text or .init.text, not the header.

> +       /* Reload the global pointer */
> +       load_global_pointer
> +

What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=y? The EFI
stub Makefile removes the SCS CFLAGS, so the stub will be built
without shadow call stack support, which I guess means that it might
use GP as a global pointer as usual?

> +       call __efistub_efi_pe_entry
> +       ret
> +

You are returning to the firmware here, but after modifying the GP
register. Shouldn't you restore it to its old value?

