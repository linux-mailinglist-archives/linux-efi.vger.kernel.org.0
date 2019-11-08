Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E7F4434
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfKHKJg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 05:09:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfKHKJf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Nov 2019 05:09:35 -0500
Received: from zn.tnic (p200300EC2F0D3700695E5CE6DC2DF0A9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:695e:5ce6:dc2d:f0a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E2861EC0CFB;
        Fri,  8 Nov 2019 11:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573207774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zi83kBXDzZBZ6+y95rMr+7di9jcc32PZkbcTv3IAkfg=;
        b=jMz7yGz/YYrTc/Zf5NGWTmt4iwndQVEGHvOi/9AAZvnjjxrptrFjdYUOfJjUkTvxyC7aW9
        dEhXF1+JSliS/KYbczj3azUWlG42lzOBfqf2v84IsWcRQDP40jNXpVSPwYB5uSad6IVGqk
        JpCnRMw+YyXNawwgROz/j82W98h/DUg=
Date:   Fri, 8 Nov 2019 11:09:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, hpa@zytor.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Message-ID: <20191108100930.GA4503@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104151354.28145-3-daniel.kiper@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 04, 2019 at 04:13:53PM +0100, Daniel Kiper wrote:
> This field contains maximal allowed type for setup_data.
> 
> This patch does not bump setup_header version in arch/x86/boot/header.S
> because it will be followed by additional changes coming into the
> Linux/x86 boot protocol.
> 
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
> v5 - suggestions/fixes:
>    - move incorrect references to the setup_indirect to the
>      patch introducing it,
>    - do not bump setup_header version in arch/x86/boot/header.S
>      (suggested by H. Peter Anvin).
> ---
>  Documentation/x86/boot.rst             | 9 ++++++++-
>  arch/x86/boot/compressed/kernel_info.S | 5 +++++
>  arch/x86/include/uapi/asm/bootparam.h  | 3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index c60fafda9427..1dad6eee8a5c 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -73,7 +73,7 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
>  		(x86/boot: Add ACPI RSDP address to setup_header)
>  		DO NOT USE!!! ASSUME SAME AS 2.13.
>  
> -Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
> +Protocol 2.15:	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
>  =============	============================================================
>  
>  .. note::
> @@ -981,6 +981,13 @@ Offset/size:	0x0008/4
>    This field contains the size of the kernel_info including kernel_info.header
>    and kernel_info.kernel_info_var_len_data.
>  
> +============	==============
> +Field name:	setup_type_max
> +Offset/size:	0x0008/4

You already have

Field name:     size_total
Offset/size:    0x0008/4

at that offset.

I guess you mean setup_type_max's offset to be 0x000c and it would be
that member:

.long   0x01234567      /* Some fixed size data for the bootloaders. */

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
