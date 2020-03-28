Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAB196685
	for <lists+linux-efi@lfdr.de>; Sat, 28 Mar 2020 15:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgC1OGx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 10:06:53 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36659 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1OGx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Mar 2020 10:06:53 -0400
Received: by mail-qv1-f68.google.com with SMTP id z13so6468580qvw.3
        for <linux-efi@vger.kernel.org>; Sat, 28 Mar 2020 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGsxLmh5pI9jvRewegPjPIfMEi2hmilikFGOfTAF5n0=;
        b=IOO3tBQGnquvTK7I5PcGhVPWgR1i1JQM8vZDTxeBnMynSeT3Tj5qUkdsBGWoypkwH6
         VNYAJ3Lav0AcTEpIVlVn6OKSoqtewxs/6oGA7p4w077LydglVR+IBqKUqvJOqHNHfM1Q
         woHY3D8XZxUm9Zy9kmmNnpVgxTrsVQp7Z3H90vH+RLg3HxI2XZka30IbHogQ3M0GvikK
         o90X+Q4DQuCS7Rh+ZdytIlZ/NL9iSH6nUFIWS0FjVF8pjrjLLKSb9pFkF3r5PYpQFfM5
         1crvEzaNmXIvNMqNI6Vt8QjxB8n95bpXqznPg7IJmhwkd/YVdgvvOLrLTj4iPBz8ETPU
         k3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGsxLmh5pI9jvRewegPjPIfMEi2hmilikFGOfTAF5n0=;
        b=mtQVJHl/zJgaknCKIf+Z0/RJZu49jFNiTjO/BlC81WgseKokDIT41cxNHhYxAFjxHs
         ZBRPNwoD5mthrHzbCJXxO2sv7zJo/oQeA/GD+1g4ee1gszR559H4s6BkRLYoW3bsFNIp
         YckeuD9Ia3Dd/AGh4QL+0oD/QhZTpk3oLCxsR278ZcQh1FEzlH0eXFTVkHHzzGC6cxq8
         yv8Fhe6bdIPnl/2Gt+0xhXg5NCx2slQK2gO3VIh2xT37uW94M3MbaJll9sJ25vzQYJGd
         zyiA76bddcD7cRuhmmgds5B73TzJ27uauFILD0bQ3XPq1deknqavc2oGF34rhpHzfx/P
         n6SQ==
X-Gm-Message-State: ANhLgQ1FWnl1kctFV7eezkYrWf+51TPDbuZvhZMQeUcBKhXydFWmRR5I
        5h/5d2sNnm2cRrDgfstd+XN425vA
X-Google-Smtp-Source: ADFU+vvDhFVr8QcLMkylqFmHCvdb9E2vpDpaAVlxWGhCU5iJIINJbAUGk2ScwdB+6LDE7TQWnuqsQw==
X-Received: by 2002:ad4:4468:: with SMTP id s8mr3875503qvt.115.1585404412066;
        Sat, 28 Mar 2020 07:06:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p9sm6171497qtu.3.2020.03.28.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 07:06:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 28 Mar 2020 10:06:50 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH 2/2] efi/arm64: increase the PE/COFF alignment so the
 kernel can run in place
Message-ID: <20200328140648.GA234129@rani.riverdale.lan>
References: <20200326165905.2240-1-ardb@kernel.org>
 <20200326165905.2240-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326165905.2240-3-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 26, 2020 at 05:59:05PM +0100, Ard Biesheuvel wrote:
> Update the PE/COFF metadata so that the UEFI image loader will load the
> kernel image at an offset that allows it to execute in place.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kernel/efi-header.S | 2 +-
>  arch/arm64/kernel/image-vars.h | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
> index 914999ccaf8a..f9ee1c2a5fd6 100644
> --- a/arch/arm64/kernel/efi-header.S
> +++ b/arch/arm64/kernel/efi-header.S
> @@ -32,7 +32,7 @@ optional_header:
>  
>  extra_header_fields:
>  	.quad	0					// ImageBase
> -	.long	SZ_4K					// SectionAlignment
> +	.long	PECOFF_SECTION_ALIGNMENT		// SectionAlignment
>  	.long	PECOFF_FILE_ALIGNMENT			// FileAlignment
>  	.short	0					// MajorOperatingSystemVersion
>  	.short	0					// MinorOperatingSystemVersion
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index be0a63ffed23..7a7fa3ba7b2f 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -15,6 +15,13 @@
>  __efistub_kernel_size		= _edata - _text;
>  __efistub_primary_entry_offset	= primary_entry - _text;
>  
> +#ifndef CONFIG_RELOCATABLE
> +PECOFF_SECTION_ALIGNMENT = SZ_4K;
> +#elif THREAD_ALIGN > SEGMENT_ALIGN
> +PECOFF_SECTION_ALIGNMENT = THREAD_ALIGN;
> +#else
> +PECOFF_SECTION_ALIGNMENT = SEGMENT_ALIGN;
> +#endif
>  
>  /*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> -- 
> 2.17.1
> 

The section virtual addresses and (possibly) size of image need to be
updated to be a multiple of PECOFF_SECTION_ALIGNMENT, no?
