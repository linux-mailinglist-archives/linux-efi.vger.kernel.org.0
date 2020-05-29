Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC981E7860
	for <lists+linux-efi@lfdr.de>; Fri, 29 May 2020 10:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2Ib6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 May 2020 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2Ib5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 May 2020 04:31:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD5C08C5C6
        for <linux-efi@vger.kernel.org>; Fri, 29 May 2020 01:31:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cx22so933444pjb.1
        for <linux-efi@vger.kernel.org>; Fri, 29 May 2020 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=84A0M1H4jy1ecL+D5qAu1liGD/cksWTm83SNF7xy+/U=;
        b=WghyQcNaT0+nqHX9TbJBOpZhhUuqKCs0t6Db6P3hFwLDMvvxT3kUESBC7ajW56kRKY
         CRSiMXhf6uHVw/68Q67YX1fHr5mUltzqfc3Q57fYIy+tCodGIXtAln+PKgEIARGmBP/P
         ofH4efXdeHMhL8oNbqIOYTQTX9FVJ62mu7paM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84A0M1H4jy1ecL+D5qAu1liGD/cksWTm83SNF7xy+/U=;
        b=RyNJv/De0Fni2RulnOLzDe2b0wChZaWFzhJ+u0vMlm+eKjyu/s5FGqgapxH5wt1ChZ
         AnnjCMASDEOWMyPUFFQjLOJlA2fuoqNCS85wq9a1UKVnqhjIoPnoKQac+0xZ6ClvR6ei
         LDRLnJLcI5QjNpV95Eoaf2wiBtu9fFy+Q+KV96F5kJla6EhlaB9FWT17YGoVZLPK8NiH
         lukC75nnLFkVUeAISL8goWDwXnrCOpYbYrF+ckTbiIsnU53t5Ggfp7G2xjhSOaYwVqNc
         MxBzO5zMoWlkON/PPi1jC190oIYKwBAbnmNUVTjMPoXEr6rfpu/IYcZ4Xvz5xriqKhGT
         3fHw==
X-Gm-Message-State: AOAM533AVSx6J76dhQLcB5RWj9zf8ypCBhQZZz9hpLWDPCwi+/czv+a4
        TDNB0QPi5ziuP6FlZ6+KdoZlSLT7uS3hKA==
X-Google-Smtp-Source: ABdhPJwEYthMkSM49YNCxr0c5BBaSDzab+YjZMTHlFo3GA6Kodaph5uWiLr/twt3lQYpnSiIFKG4Zg==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr6066462plj.215.1590741117028;
        Fri, 29 May 2020 01:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm6353691pgn.47.2020.05.29.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:31:56 -0700 (PDT)
Date:   Fri, 29 May 2020 01:31:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] efi: Replace zero-length array and use struct_size()
 helper
Message-ID: <202005290131.4B104937C@keescook>
References: <20200527171425.GA4053@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527171425.GA4053@embeddedor>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 27, 2020 at 12:14:25PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> Lastly, make use of the sizeof_field() helper instead of an open-coded
> version.
> 
> This issue was found with the help of Coccinelle and audited _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/firmware/efi/efi.c | 3 ++-
>  include/linux/efi.h        | 7 ++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7f1657b6c30df..edc5d36caf54e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  			rsv = (void *)(p + prsv % PAGE_SIZE);
>  
>  			/* reserve the entry itself */
> -			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
> +			memblock_reserve(prsv,
> +					 struct_size(rsv, entry, rsv->size));
>  
>  			for (i = 0; i < atomic_read(&rsv->count); i++) {
>  				memblock_reserve(rsv->entry[i].base,
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index c45ac969ea4eb..328cc52a5fd45 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1234,14 +1234,11 @@ struct linux_efi_memreserve {
>  	struct {
>  		phys_addr_t	base;
>  		phys_addr_t	size;
> -	} entry[0];
> +	} entry[];
>  };
>  
> -#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
> -	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> -
>  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> -	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> +	/ sizeof_field(struct linux_efi_memreserve, entry[0]))

Whoa. This is kind of a "reverse struct_size()". I wonder if any other
places in the kernel do a similar calculation?

-- 
Kees Cook
