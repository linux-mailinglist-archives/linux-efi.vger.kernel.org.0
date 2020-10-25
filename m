Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0600298274
	for <lists+linux-efi@lfdr.de>; Sun, 25 Oct 2020 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417111AbgJYQTf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Oct 2020 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgJYQTe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Oct 2020 12:19:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4150C0613CE;
        Sun, 25 Oct 2020 09:19:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q199so6188886qke.10;
        Sun, 25 Oct 2020 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5TC2MzYj0vw5zKi0k5pd4CHQhZMyt3O4BrEFePzGKh0=;
        b=XEbDGN0tqcGAVApVEzDBIKI2pKYnkpeO7n+MN0tp+YnOSEJTzk8vLKoL58HqRXqbVt
         iOXPBXuOxyvvyftL+kuVxQRAfzR4OgZtRxEgAZVbFgNRbB6gtVp4HRATyuQxt3pd7/oG
         MTvgGwkCwoml7aFhZp4Dkky24rgaNNl02CTmLnbtIrPWpgCMp/ZworgFKCdsf90EvLYl
         vCJCgTZNrGXca1O+1xRCPUT5MepNuyPX4WEhanCbF04rXJAkBWwmePGSVOZN7YZeh/Wr
         F1x/Mxy0/yQLvGj10GT9fChbMZr3DLA4fS0gf9U6ZRC9bEE7ZioWekv2UI+WsQwn707m
         QaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5TC2MzYj0vw5zKi0k5pd4CHQhZMyt3O4BrEFePzGKh0=;
        b=MYh1i54MhehIMFdIdXa0OwvYouvJ6efohIu6HiLZ5+NhVqWoSJYJRW7OthUF1lcp9P
         3Au/PHSWUX3M1EEXl40vfBi60zL4rA0fvDHzv4XHt4j176BpjMFp68W28wRc16mSacMe
         XH7dOwZ+5VV63QtNcRWWgbb1xu1fWn1aEGTN1cONtpUX+4af6PdQw3IiZLOi5urw0udo
         +Bpg394L5Yi1idjb2EFiV2B36dmQpgwjHyHbuhJ/hEe7ZgQU4KxNDfEssF6crjm4MX7d
         xUCKZ9mM76ItF48q/9fNR9FUCmt/Pbv/xuvt8Ic+WgRDFa+jtyEp9l80YDtBRe+hkYOd
         dLmw==
X-Gm-Message-State: AOAM530jixo3T62XHc5pbCqZF1bfJRNvqSW4U2vbXm2uEBLZUPU72e9i
        XLRc9+GGBvsUvJM2d+Y89eMAcgVAizWLgQ==
X-Google-Smtp-Source: ABdhPJy5QqtudNP0xh8eA/OHC75nI+p4uT/Q8roWcv3KxQKqX50H4a+OOAp5vmCFs+7/55rpsbjLQQ==
X-Received: by 2002:a37:b9c3:: with SMTP id j186mr13207723qkf.327.1603642773594;
        Sun, 25 Oct 2020 09:19:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v13sm4781315qkv.113.2020.10.25.09.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 09:19:32 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 25 Oct 2020 12:19:31 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/x86: Only copy the compressed kernel image in
 efi_relocate_kernel()
Message-ID: <20201025161931.GA1119983@rani.riverdale.lan>
References: <20201011142012.96493-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201011142012.96493-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 11, 2020 at 10:20:12AM -0400, Arvind Sankar wrote:
> The image_size argument to efi_relocate_kernel() is currently specified
> as init_size, but this is unnecessarily large. The compressed kernel is
> much smaller, in fact, its image only extends up to the start of _bss,
> since at this point, the .bss section is still uninitialized.
> 
> Depending on compression level, this can reduce the amount of data
> copied by 4-5x.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Ping

> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 3672539cb96e..f14c4ff5839f 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -715,8 +715,11 @@ unsigned long efi_main(efi_handle_t handle,
>  	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
>  	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
>  	    (image_offset == 0)) {
> +		extern char _bss[];
> +
>  		status = efi_relocate_kernel(&bzimage_addr,
> -					     hdr->init_size, hdr->init_size,
> +					     (unsigned long)_bss - bzimage_addr,
> +					     hdr->init_size,
>  					     hdr->pref_address,
>  					     hdr->kernel_alignment,
>  					     LOAD_PHYSICAL_ADDR);
> -- 
> 2.26.2
> 
