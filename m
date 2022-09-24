Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9495E88DA
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 08:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiIXGwv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Sep 2022 02:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXGwu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Sep 2022 02:52:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A641CB2A;
        Fri, 23 Sep 2022 23:52:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso2132941pjd.4;
        Fri, 23 Sep 2022 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=emY21qk/ZfJgKldq05p0//jaBtF7OQGgCZUbCkhohso=;
        b=KaeXkFVe+dMPui9e25XdO6WVWZYIzmf9fKX27ikq2fcdg7bg7k/g7c6ptmtcokUPIr
         jPhuL6ReWbNafgxcNNZiFWKguhfWwxbvf7K8SPdQrNMPXR47rmmqC9RmFBQDQ3QTk3Rs
         +9JFiUtr6wzgVGLRZHFGuzqHbOQMJZhQZujybM+tUpeUP0eZobINmd1XC+vZ3/pCj1I0
         hu8sJYsErH6jy/yWd5JLY0P+oLwBAgX8w2pd2LIzFHkYTeQ82LCDnIBOjIgRzY0o+Wox
         s9VLSjx37rwBsNWGUrCuzZ2lITf3Ap3JNjplW8kNTBGx3xptAAMQ3bmauFJ9Zy5A8Qak
         OFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=emY21qk/ZfJgKldq05p0//jaBtF7OQGgCZUbCkhohso=;
        b=Jjy5ALGgpru1tBXWCLKgLH3Bhbqriw1uG4FuN2tapTLd0muwE4XYwTADg/tlKcTO92
         WajNYDEw+EEhNT8wJks7eUmqPsfU3ojOssgPRzgDnVXfrJJfzbtcWqmmZAnG1t9VC8iY
         5TOQWyXxKJr60YhKrFKgyLT+oSZZMqpo/LV9DGIPp3H19w+m5Gj+1uz6bXYe6Fo1Aus6
         JON+gX+OZ0YPsRCo6HV1pzs+IzN9kf2o0evOojoyA3JKSPqcl3sAs95r2spuWWoSXhH9
         298P0XyaLQ88AK7qZo2BJIetaX0ySN7LQ+LzSnYYTVvl1qZ4IVfFToaAhd0p9Yc/hiU6
         YAbw==
X-Gm-Message-State: ACrzQf0gCqvpAMefraxU9l1sUpVTAhwCHWVQA5bdCw6auspTSEcY2+to
        It/t0zkrawIjmNZn61OZe5c=
X-Google-Smtp-Source: AMsMyM6mlyLmU2swxYWvqODYQ1bK2mI5FY5c1bxYVhwp5XLf4DUAl42D37hU/JX0cqOymfjx1ga35Q==
X-Received: by 2002:a17:902:e951:b0:178:93cf:3ebe with SMTP id b17-20020a170902e95100b0017893cf3ebemr12016162pll.74.1664002368960;
        Fri, 23 Sep 2022 23:52:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b0016c57657977sm7082585plb.41.2022.09.23.23.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 23:52:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 23 Sep 2022 23:52:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Message-ID: <20220924065245.GA705155@roeck-us.net>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 03:17:30PM -0700, Dave Hansen wrote:
> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
> even have NX support.  Even PAE builds that support NX have to contend
> with things like EFI data and code mixed in the same pages where W+X
> is unavoidable.
> 
> The folks still running X86_32=y kernels are unlikely to care much about
> NX.  That combined with the fundamental inability fix _all_ of the W+X
> things means this code had little value on X86_32=y.  Disable the checks.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-efi@vger.kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/all/CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com/

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/x86/mm/pat/set_memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20b1e24baa85..efe882c753ca 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -587,6 +587,14 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  {
>  	unsigned long end;
>  
> +	/*
> +	 * 32-bit has some unfixable W+X issues, like EFI code
> +	 * and writeable data being in the same page.  Disable
> +	 * detection and enforcement there.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32))
> +		return new;
> +
>  	/* Only enforce when NX is supported: */
>  	if (!(__supported_pte_mask & _PAGE_NX))
>  		return new;
> -- 
> 2.34.1
> 
