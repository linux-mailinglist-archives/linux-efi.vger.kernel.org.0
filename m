Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E65E866D
	for <lists+linux-efi@lfdr.de>; Sat, 24 Sep 2022 02:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiIXAEc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 20:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiIXAE1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 20:04:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5231213A941
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 17:04:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so1648018pjk.2
        for <linux-efi@vger.kernel.org>; Fri, 23 Sep 2022 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BEWBQ/N1eOSJUx4cKeNRYsp1Xg+eINoB3Vsyk1Ms/PM=;
        b=DHIBNaSzUY2QBwMW/mTvWLgwOCjfKVRV16zgUnhARd9o6Kc5V6a1QVhMaqvxQF7xtC
         jL4jDkZr9JtLjvPiXipG++74X6CSAJ+uVES3b0308HiZU8x0yj98zb8btJPr6iUAavrY
         bcCSOlon43h/N21/TMgK2xg/Qvxaqo3ducGhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BEWBQ/N1eOSJUx4cKeNRYsp1Xg+eINoB3Vsyk1Ms/PM=;
        b=loBehGmwBM9WMO/8yrIReVLb15Xttsf+6t9DPCvtel22wyDnjq++vLgxyNm3VZ4z4J
         V1+zblmR2m4UWEZd5Tnnp7h2adw5jDK/jIEyi9np3ZI5RY6LZl6AcBl5KhA1VZ8e0fqO
         w2tjRLoiqZzfc4pdX2g8ydfWvkmhUJZMLJAq7HwA5Hl9nzwGCzXdmRuq4tVkOq1d1zqI
         5zRYb3zMaxBhXIDi0vxqUZx066fK+RAGeKENIKQwOUQyXCuKeBQK6vdU/jRwnUcDxmL1
         02972CZNralvQm+EEW3KGcitx2ItXIT0KiVSvBDH4HRw818pS7a8yhD10TtT9cgsw9YK
         Pmww==
X-Gm-Message-State: ACrzQf0x0sxqJuK/PwRwTc/qlAPvfWYRLhUwO/wYmrEGGZLZQfbG9xI5
        Fwv+VSrfBOKBaF2orGe78s9sVYC4+yZBOg==
X-Google-Smtp-Source: AMsMyM50Dva1p2XQnnTrxohMW/JBpO1aFwkp6xQNzsqiQrvAdn8RC+aULR1XI9rPbsS7xZtcN69cvQ==
X-Received: by 2002:a17:90b:4f45:b0:203:6d82:205c with SMTP id pj5-20020a17090b4f4500b002036d82205cmr23141222pjb.224.1663977865777;
        Fri, 23 Sep 2022 17:04:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w35-20020a17090a6ba600b002031264a864sm2134200pjj.41.2022.09.23.17.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:04:24 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:04:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm+efi: Avoid creating W+X mappings
Message-ID: <202209231702.DC9FB5860@keescook>
References: <20220922193157.1673623-1-dave.hansen@linux.intel.com>
 <CAMj1kXHcF_iK_g0OZSkSv56Wmr=eQGQwNstcNjLEfS=mm7a06w@mail.gmail.com>
 <Yy1ZadE6Vnnc2dNf@hirez.programming.kicks-ass.net>
 <CAMj1kXEvt-TQzO5jO6srkC8jW5fbou95VKu=os3gt_y87ZPJWg@mail.gmail.com>
 <5f443915-b38a-c78d-cccd-876501434cef@roeck-us.net>
 <CAMj1kXEt1RwYbkBOFa=KsML0KvJ6Zuu9eJ_=jQA7BTW-N2BSeA@mail.gmail.com>
 <202209231126.6855D54@keescook>
 <CAMj1kXHckEg6rwBSEc6piu=-JZzyDh7j+pvGSFp1OBUQuofrEQ@mail.gmail.com>
 <202209231417.F73F40060@keescook>
 <69e00173-087e-6a22-7a02-0c1212f42065@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e00173-087e-6a22-7a02-0c1212f42065@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 23, 2022 at 03:15:15PM -0700, Dave Hansen wrote:
> On 9/23/22 14:19, Kees Cook wrote:
> >> But currently, PAE is not even enabled in the i386_defconfig, and
> >> defaults to off. This means people that are unaware of this won't
> >> enable it, and will be running without NX support.
> > And they all make me cry. ;)
> 
> It's been like that for a long time, presumably because the defconfig
> should *boot* in as many cases as possible.  It wouldn't be hard to
> change.  It also wouldn't be hard to default to HIGHMEM4G (non-PAE) on
> targeted builds for CPUs that don't support it.  Patch attached to do
> that, if anyone else has an opinion.
> 
> We should probably just leave i386 alone, but it breaks my heart to see
> Kees in tears.

*dabs his eyes with tissue*

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..fad978c7b7c5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1363,9 +1363,14 @@ config X86_CPUID
>  	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
>  	  /dev/cpu/31/cpuid.
>  
> +config CPU_HAS_PAE
> +	def_bool y
> +	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !MWINCHIP3D && !MK6
> +
>  choice
>  	prompt "High Memory Support"
>  	default HIGHMEM4G
> +	default HIGHMEM64G if CPU_HAS_PAE
>  	depends on X86_32
>  
>  config NOHIGHMEM
> @@ -1412,7 +1417,7 @@ config HIGHMEM4G
>  
>  config HIGHMEM64G
>  	bool "64GB"
> -	depends on !M486SX && !M486 && !M586 && !M586TSC && !M586MMX && !MGEODE_LX && !MGEODEGX1 && !MCYRIXIII && !MELAN && !MWINCHIPC6 && !MWINCHIP3D && !MK6
> +	depends on CPU_HAS_PAE
>  	select X86_PAE
>  	help
>  	  Select this if you have a 32-bit processor and more than 4

I feel happy now! :)

-- 
Kees Cook
