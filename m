Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062811DFFAD
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgEXPIr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 May 2020 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbgEXPIp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 May 2020 11:08:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E4C05BD43;
        Sun, 24 May 2020 08:08:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v19so7449576wmj.0;
        Sun, 24 May 2020 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1gyVEfsYNacJFc5KocHHb7hmm4985MqiuLspiDPh0s=;
        b=Ri5CCc6DhJf25jmxXNkWbUeANRV+cYc0dpgPD020+PpGe7765dfSIeLqgDXc7qV9mp
         tCgrzkdG8YUhWHsytk1Fknpwheg+pqP2H3B6PJuQGyzxEVchyljUfHWFM+OIpiqtbNAP
         XVOj3Yz/acVILpmjp6wZ7HzDTJPLXVePhkUiDSf+N7x3TodV1VG5+Z1nhTA2YxhkRai8
         aTEvOtVdUo7ZRGYdU/o753fDzETL43RiFGUDvUpk1ThMGeIWSgu7RyaVbt/39KnGzdls
         SmkfRHwgBOOtnucb5sSVZEMk9XXzT6rSc8Pw2tA5O/3UgOaCFGm0Zu2ATIuyNqM3yKhu
         xjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o1gyVEfsYNacJFc5KocHHb7hmm4985MqiuLspiDPh0s=;
        b=A+mhicO1APtr6fuwcPC4XPCt5YMLGVvi2opXaznBOAEJB3yeqA/XrulkledVz3BByf
         vNXf1wGxmF7hWHq+0KUsN8kYCO3H060JZcmC/rPe9NmMVAcKakV6/cXv2mLB345udkW1
         CL0Vp74XO2cV9wEl7j9PjttLQc4Xsd4uft27BYBXXyu52rh9nFYOWGLffrI7yX41T9v8
         o56T1JvSFCpwbV734AQNaaKJLbaGMhFv3DX+oUBB39v5+DvcTJ55SsgywJApHnhkmbJi
         +Blc+cF38jRsmcYy+fWlhPbmqI9GbRMrkPnmW8vVQLUhKDun2304oACx3wKAHrKWSXIA
         Mm8g==
X-Gm-Message-State: AOAM533z/Y3x/vETzvOoumzH2jkPAA5nCHQhwDQ7AjtesXfqTRdzS7Mu
        jTNkPC3sXiKAe9hB+ZbPUCRnQ5Uz
X-Google-Smtp-Source: ABdhPJzqZTqtIm/t+i0lCy81mdQW9Cf+Iadwb/YZe+oSsON2T+w21CgdZdKvH2v5Lu4cSjjBMyqZsw==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr827300wmi.186.1590332924206;
        Sun, 24 May 2020 08:08:44 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g10sm15050075wrx.4.2020.05.24.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 08:08:43 -0700 (PDT)
Date:   Sun, 24 May 2020 17:08:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 1/3] x86/boot/compressed: move .got.plt entries out of
 the .got section
Message-ID: <20200524150841.GA11617@gmail.com>
References: <20200523120021.34996-1-ardb@kernel.org>
 <20200523120021.34996-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523120021.34996-2-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The .got.plt section contains the part of the GOT which is used by PLT
> entries, and which gets updated lazily by the dynamic loader when
> function calls are dispatched through those PLT entries.
> 
> On fully linked binaries such as the kernel proper or the decompressor,
> this never happens, and so in practice, the .got.plt section consists
> only of the first 3 magic entries that are meant to point at the _DYNAMIC
> section and at the fixup routine in the loader. However, since we don't
> use a dynamic loader, those entries are never populated or used.
> 
> This means that treating those entries like ordinary GOT entries, and
> updating their values based on the actual placement of the executable in
> memory is completely pointless, and we can just ignore the .got.plt
> section entirely, provided that it has no additional entries beyond
> the first 3 ones.
> 
> So add an assertion in the linker script to ensure that this assumption
> holds, and move the contents out of the [_got, _egot) memory range that
> is modified by the GOT fixup routines.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 0dc5c2b9614b..ce3fdfb93b57 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -44,10 +44,13 @@ SECTIONS
>  	}
>  	.got : {
>  		_got = .;
> -		KEEP(*(.got.plt))
>  		KEEP(*(.got))
>  		_egot = .;
>  	}
> +	.got.plt : {
> +		KEEP(*(.got.plt))
> +	}
> +
>  	.data :	{
>  		_data = . ;
>  		*(.data)
> @@ -75,3 +78,11 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>  	_end = .;
>  }
> +
> +#ifdef CONFIG_X86_64
> +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> +	"Unexpected GOT/PLT entries detected!")
> +#else
> +ASSERT (SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc,
> +	"Unexpected GOT/PLT entries detected!")
> +#endif

Cool debugging check!

Minor consistent-style nit:

s/ASSERT (
 /ASSERT(

Optional: maybe even merge these on a single line, as a special exception to the col80 rule?

 #ifdef CONFIG_X86_64
 ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
 #else
 ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) ==  0xc, "Unexpected GOT/PLT entries detected!")
 #endif

But fine either way.

Thanks,

	Ingo
