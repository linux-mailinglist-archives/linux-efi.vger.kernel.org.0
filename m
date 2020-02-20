Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E16C1664C8
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 18:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBTR2g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 12:28:36 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37773 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTR2g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 12:28:36 -0500
Received: by mail-qv1-f67.google.com with SMTP id s6so2254720qvq.4
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/CEnE3q3tabZ61qw8pP3XV9qYLKgzrZVM3GW4L7dYlM=;
        b=aryJIDchZsON09Ya+7tI/pawnSJghS4/k7c+icW7vA+XITynLzllYSlWRTW7SreZmB
         67aIuDzsqT1lFdTLUywkdeCkfncXCp8PX23lI+bFwzem95qFSU3WJfyY7yWCWYmK/mSA
         aBM0fF+VZYnF2Ls5yA1MoIqiF6VxDj23qKfnyTxYxtZVVcaHfe3UV0wUB56ZVOKvCuo9
         rZz2/mB62cnmbky/jKpt9bkOjrLpCAOxLYn+YmtPVA2hi8gu997Qu+K2IwipTJalfbGR
         EAFl9NdbKNh8LgutsWIup5+chJe3cg52qQbEkq7jMiXlqQAdLsYOHhR8g3CPiVgIdDib
         1/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/CEnE3q3tabZ61qw8pP3XV9qYLKgzrZVM3GW4L7dYlM=;
        b=qnn8F2Bcgzd91YAMaKZlWIaTgRBBlIbB6GNCCerQil5EBRRnOv3uH9DQ8SsyKv4JDy
         KB+hFAuYcP2D/6UPGZ32qEPRuo8EzI/DZGnwKDEF05AdQZcV4flgHUh5yZHnPwMVHzdN
         BmaS3OfxeIGyupicFEqpBwoNE1Erv7N4gt44Ks7QKBdBhvI13ziC6gUXEQq+gLwb3A0S
         JhjWWsXqB+y/iQs/p4MgqiKP3GthUy6e4kitwo+WZMpbyPFTMLqx1pxcloqud0b6RzP9
         vzoMO6Tk0UKQ1PzvABAu3CkjUV3q49TkGfhGa0c+5ZyVLLks4wCkBOR8EoTvm64AbY+b
         +ieQ==
X-Gm-Message-State: APjAAAVmUajw8tWj+TD5gJF9sDcm3fyUPM59k/2mogt+RAJk0kMd2dHr
        xXBtr/mSllCoOXirEDtw3BQ=
X-Google-Smtp-Source: APXvYqzy7Qfyem3q0+q96J3VwXMUS8wwH80cpMJ1Gh4vbaoKWsLuR+IjLNdu7oFaZxBI3Q1dB4Fgjg==
X-Received: by 2002:a05:6214:1634:: with SMTP id e20mr26514654qvw.205.1582219715134;
        Thu, 20 Feb 2020 09:28:35 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u2sm74439qtd.72.2020.02.20.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 09:28:34 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 12:28:32 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, lersek@redhat.com, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220172831.GA2417225@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220110649.1303-2-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 12:06:47PM +0100, Ard Biesheuvel wrote:
> Replace bare numbers in the PE/COFF header structure with symbolic
> constants so they become self documenting.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/header.S | 60 ++++++++++----------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 44aeb63ca6ae..9110b58aa2ec 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -210,7 +200,10 @@ section_table:
>  	.long	0				# PointerToLineNumbers
>  	.word	0				# NumberOfRelocations
>  	.word	0				# NumberOfLineNumbers
> -	.long	0x60500020			# Characteristics (section flags)
> +	.long	IMAGE_SCN_CNT_CODE		| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_EXECUTE		| \
> +		IMAGE_SCN_ALIGN_16BYTES		# Characteristics

The IMAGE_SCN_ALIGN bits are marked as "valid only for object files".
Can they be removed?

>  
>  	#
>  	# The EFI application loader requires a relocation section
> @@ -228,7 +221,10 @@ section_table:
>  	.long	0				# PointerToLineNumbers
>  	.word	0				# NumberOfRelocations
>  	.word	0				# NumberOfLineNumbers
> -	.long	0x42100040			# Characteristics (section flags)
> +	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_DISCARDABLE	| \
> +		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
>  
>  #ifdef CONFIG_EFI_MIXED
>  	#
> @@ -244,7 +240,10 @@ section_table:
>  	.long	0				# PointerToLineNumbers
>  	.word	0				# NumberOfRelocations
>  	.word	0				# NumberOfLineNumbers
> -	.long	0x42100040			# Characteristics (section flags)
> +	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_DISCARDABLE	| \
> +		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
>  #endif
>  
>  	#
> @@ -263,7 +262,10 @@ section_table:
>  	.long	0				# PointerToLineNumbers
>  	.word	0				# NumberOfRelocations
>  	.word	0				# NumberOfLineNumbers
> -	.long	0x60500020			# Characteristics (section flags)
> +	.long	IMAGE_SCN_CNT_CODE		| \
> +		IMAGE_SCN_MEM_READ		| \
> +		IMAGE_SCN_MEM_EXECUTE		| \
> +		IMAGE_SCN_ALIGN_16BYTES		# Characteristics

The .text section contains data as well. Shouldn't it be marked
IMAGE_SCN_MEM_WRITE also?

>  
>  	.set	section_count, (. - section_table) / 40
>  #endif /* CONFIG_EFI_STUB */
> -- 
> 2.17.1
> 
