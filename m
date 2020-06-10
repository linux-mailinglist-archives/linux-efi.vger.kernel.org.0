Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB21F50AE
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jun 2020 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFJI7f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Jun 2020 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgFJI7f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Jun 2020 04:59:35 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920AC03E96B;
        Wed, 10 Jun 2020 01:59:35 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z145so329854ooa.13;
        Wed, 10 Jun 2020 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LHb9HPZL9XpTtc79yClOxL66RppszWEIptQMEpe4Jo4=;
        b=Qz5SJTsYGPnNegFFvLPl5enPu1KXc0mJKyVeSiX64zDTlEJGAFj9IfRDTfR78e8qyQ
         jz4NJ6u2SaKpQLixBSxkjxHnAVt9HTtsojZUll1B3ioG0N2T9urVFb954PYcDGknzINs
         9nBpsqGN2iGvFfiUfiARYJ0D5RBsh9A7Xue7MTK0VdJ0apzN3yrgpJMR0dEVKIZ+01O+
         4sAxpRm4PYpPrcdInmhnCPTLCUDz1akYubPfvzwOuimqmALKLFUGhSuLULHHAj+a+Vq+
         M0Vl+cRrNRTujRZIMCg4ozY47ndu6XXlkzxLVK2fC+MN4N9OOAVgjsbx+WrYFKK2CZIc
         qfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LHb9HPZL9XpTtc79yClOxL66RppszWEIptQMEpe4Jo4=;
        b=Hk+HOhnvta1ozVO3JFfsF59j9SHyyqOfKwCn7++4TBO1Lkh793KG2EjsHRxrYj1FOD
         Ne6NIAu4H64g8mjaX/+0FINdw8U2YS4gFh0VGQXCGztA6Pxb4njGk9YcAKIwGfLkdt8t
         HC3Au1IZeREMRQN4QO42fm+EJyb2anOdNJpU9lkz6qo+Y6IDAQLEw8PVDK5XVy3y/kIP
         h0kCMPlQx07qZxjOXCE7OBJ3bogv5Cm6i4wWAuPnjjMRO8XOPIIOEOegZ3e1wzeBJxS9
         F7xjFjBUq5cNLSNeJ8EJMB7Lanb/aeKMj55iszjaLrS8uydb2y1Zl8i1+4OQ0KTHCDgm
         00RA==
X-Gm-Message-State: AOAM532+gbylOqC1/bWd6k3VXhLn2J70l2ZPWXlCWKtjcgoL0CC/03RE
        aIciQ4U39iN1Lnpt1Uim2Ds=
X-Google-Smtp-Source: ABdhPJzU9SM/zqdoDgJz7V1IMKOR9PCRdfnwMQMGnamkCNUkkTljLE97xhJc0/R83prH0oaa+rF5aQ==
X-Received: by 2002:a4a:c501:: with SMTP id i1mr1556787ooq.65.1591779574587;
        Wed, 10 Jun 2020 01:59:34 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id t11sm2764868otr.65.2020.06.10.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:59:34 -0700 (PDT)
Date:   Wed, 10 Jun 2020 01:59:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        ardb@kernel.org, nivedita@alum.mit.edu, keescook@chromium.org,
        mingo@kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] efi/libstub: Fix build error with libstub
Message-ID: <20200610085932.GA461993@ubuntu-n2-xlarge-x86>
References: <20200610071446.3737-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610071446.3737-1-zhenzhong.duan@gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jun 10, 2020 at 03:14:46PM +0800, Zhenzhong Duan wrote:
> Got below error during build:
> 
>   In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:16:0:
>   drivers/firmware/efi/libstub/efi-stub-helper.c: In function ‘efi_char16_puts’:
>   arch/x86/include/asm/efi.h:355:3: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
>      : __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
>      ^
>   drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in expansion of macro ‘efi_call_proto’
>     efi_call_proto(efi_table_attr(efi_system_table, con_out),
>     ^
>   drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlier errors, bailing out
> 
> Fix it by adding -maccumulate-outgoing-args for efi libstub build
> as suggested by gcc.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index cce4a74..25e5d02 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -6,7 +6,7 @@
>  # enabled, even if doing so doesn't break the build.
>  #
>  cflags-$(CONFIG_X86_32)		:= -march=i386
> -cflags-$(CONFIG_X86_64)		:= -mcmodel=small
> +cflags-$(CONFIG_X86_64)		:= -mcmodel=small -maccumulate-outgoing-args

This will need a cc-option call if this patch is necessary because clang
does not support this flag.

clang-11: error: unknown argument: '-maccumulate-outgoing-args'

>  cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
>  				   -fPIC -fno-strict-aliasing -mno-red-zone \
>  				   -mno-mmx -mno-sse -fshort-wchar \
> -- 
> 1.8.3.1
> 

Cheers,
Nathan
