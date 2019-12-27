Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31612B0F4
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 05:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfL0Ee1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 23:34:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33799 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfL0Ee1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Dec 2019 23:34:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so21173218qkk.1
        for <linux-efi@vger.kernel.org>; Thu, 26 Dec 2019 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGlKaSIsM5g+WNthc3yLX6/h2FMgGyGswG8U+fI5z0s=;
        b=nKsj91T3xNRxTmCnZIqswxG5ie8YVKrBrxku5tofISjbRl4Dp5Lff5+Fzmi1G/ftHf
         PXWwGRlWpAqfvbqaQvpY1+9i9pn1V6m/G0PrUgyKcFqJY01+nJ4TWPiXD/m8q2a14CkK
         Paqzr0rmSNuv6TJEeoY+yRm42cN9FbLVmLT0Ednq2aG6/OgN5/Ys6zG61AG3J9OdS8Sq
         IS4338WcfL2e93tsId9AEmZQJrGaWstX8ktVcqlRPiYCA3UZs5HBMuFAXFA7z41qR27p
         rqXFegrSg9y1I7b/7C7BdP2a2xIYeMQWKl/n6GSzW0m7yHNCwJbni8BHypD4EW21cmSV
         1oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGlKaSIsM5g+WNthc3yLX6/h2FMgGyGswG8U+fI5z0s=;
        b=TxAohEkj5D5uVgHiunA6BQF9XrWhkkMUnw2/vxpnW8+W6pEoILp1ttG4UYnMVyffuE
         40DbsMRZiMUHxhslYuoibsFDnA8Nm7+s1bzRMhWqkr4uB96kcPLc+3y5CJOWahL0a6T5
         maU3hA3lvzT0VP/fNctjMRJHJZCYy5l+MWubY4C22OOHIng46P52mMi+da+mttwIZsiY
         UJ/jdA5AYUXa+iNFfmOaH3harRuYemHPIFOJTqwa1BSpKkKfe3PPwk+3XbDyiqH7AIkc
         u6BBXUVWf1MCHcaYnWc8D+qRGQjwuViJB7igtUx4eMGQf4KibH5isTfjhRHfLhNXX+D6
         Lw5g==
X-Gm-Message-State: APjAAAVYI+3z+MC98EIW0pZXb23/bqL7MTdEyyGHmT+plNyJdHGp2lUK
        bKJ5ckbal5OoDmDJSrceUMNy3xI3
X-Google-Smtp-Source: APXvYqwF6Gd4HC7lGt0t4OxFIl0eW7jxivlc71iSaf7UlKB37G6dM7sw66CuFdxQYLgkfkBAzyQcEg==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr39739650qkg.89.1577421266534;
        Thu, 26 Dec 2019 20:34:26 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t42sm10406600qtt.84.2019.12.26.20.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 20:34:26 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 26 Dec 2019 23:34:24 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, nivedita@alum.mit.edu,
        hdegoede@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
Message-ID: <20191227043424.GA435594@rani.riverdale.lan>
References: <20191226151407.29716-1-ardb@kernel.org>
 <20191226151407.29716-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191226151407.29716-4-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 26, 2019 at 04:14:07PM +0100, Ard Biesheuvel wrote:
> Calling 32-bit EFI runtime services from a 64-bit OS involves
> switching back to the flat mapping with a stack carved out of
> memory that is 32-bit addressable.
> 
> There is no need to actually execute the 64-bit part of this
> routine from the flat mapping as well, as long as the entry
> and return address fit in 32 bits. There is also no need to
> preserve part of the calling context in global variables: we
> can simply preserve the old stack pointer in %r11 across the
> call into 32-bit firmware, and use either stack to preserve
> other values.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/efi_thunk_64.S | 106 ++++++--------------
>  1 file changed, 29 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
> index 3189f1394701..7357808d3ae8 100644
> --- a/arch/x86/platform/efi/efi_thunk_64.S
> +++ b/arch/x86/platform/efi/efi_thunk_64.S
> +	/*
> +	 * Convert 32-bit status code into 64-bit.
> +	 */
> +1:	btrl	$31, %eax
> +	jb	3f
> +2:	mov	%r11, %rsp
>  	pop	%rbx
>  	movl	%ebx, %ss
>  	pop	%rbx
>  	movl	%ebx, %es
>  	pop	%rbx
>  	movl	%ebx, %ds
> -
> -	/*
> -	 * Convert 32-bit status code into 64-bit.
> -	 */
> -	test	%rax, %rax
> -	jz	1f
> -	movl	%eax, %ecx
> -	andl	$0x0fffffff, %ecx
> -	andl	$0xf0000000, %eax
> -	shl	$32, %rax
> -	or	%rcx, %rax
> -1:

Is it worth optimizing the conversion? The entire high nibble is
significant according to the spec. It probably doesn't matter except in
one potential case: according to the spec, transitioning secure boot
status to setup mode by deleting the platform key is allowed to return
EFI_WARN_RESET_REQUIRED and AFAICT this can take place after
ExitBootServices?

Separately, it might be worth considering moving the status translation
into C instead of asm for the version in
arch/x86/boot/compressed/efi_thunk_64.S -- there are (at least) three
protocols that have methods that don't return efi_status_t:
DEVICE_PATH_UTILITIES, DEVICE_PATH_TO_TEXT and DEVICE_PATH_FROM_TEXT. If
we ever want to use them (eg for debugging), it might be worth having a
thunk that doesn't mangle the return value.
