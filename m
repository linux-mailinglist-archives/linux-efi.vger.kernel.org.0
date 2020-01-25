Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8B149410
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jan 2020 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgAYJMv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jan 2020 04:12:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33210 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYJMv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jan 2020 04:12:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so4969647wrq.0;
        Sat, 25 Jan 2020 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DGhvVqW5myL1qX8XhMf5p5YSpZ2Kzi7HZG5T95QDfq0=;
        b=csCUk16YjSkFbkGccWgYuAGBtgbQUSMLW5aKQ+wvQzeZss0mibeNaIvTM7ADdlVAXd
         UTD41j3IDD7/NS4jeoG6Et16ccWR+eINuEquc4lMFrXm8iAh1GyKrlVp+X/7uh/oPZdO
         dcuhBN4v95SHm6vWeCzSBdmaf02RQ1vUlZizB8VV0abBAojO+bEBhAZxYyqOpk79tO3T
         IUHLgo6XQ5WjItnhD5+1FZeM98y6ffmLaSn22BI3odvluTNHd4F6BnWTTpbzou4OF6R2
         DD473+no85uxgtN6Ku4xfZ7yojdzIKi75UZYmtWVTTny143917kggXoS+QdIDGYELInQ
         BZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DGhvVqW5myL1qX8XhMf5p5YSpZ2Kzi7HZG5T95QDfq0=;
        b=GOyu7/x5zEIQa+McDS6hajtjj37v0PHXg7ut43eSnCbzJFT6nfYB4vg2hnxL7o3ul5
         oD13SI0bebsKUnpQgWNmWx5Gk8kIBWvX+fWcYjDDXTbRKTWYX58L37agTx3nLQSe18XR
         ZPQgGlvkgrpA7J36N5O18bfWQwmaNmEBK+BEUqXY8/5RK1XsiVLxqlGOSYjWQMnzJ9gb
         v3FJrCaTGOOb+fptdObs/nXxXyw51lcEeBZMLwWnnRwR/zs0gNE2sfZbOj6zQdXKf2sZ
         9vvwBsIn/BV9UEtX8R9rR17WFr91bIq0eS7vvJRbPX3H6tvqzjBGbXzx0tMZEd8AW/ei
         FReQ==
X-Gm-Message-State: APjAAAVY2BQjLCioO900TAqtPJXjeZcY1Jjvt/BDXmtssM/kg77tC8of
        EJqFTYJIOgoJV+vUloW/FM4=
X-Google-Smtp-Source: APXvYqz7DD1aj8WqnelJyQVSzVTbX879cPiG4iMawjI634I8UE/9j1iG5F7Hm/puJMq2fOk+eoGiIg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr9281392wrl.389.1579943570008;
        Sat, 25 Jan 2020 01:12:50 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c5sm10400872wmb.9.2020.01.25.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 01:12:49 -0800 (PST)
Date:   Sat, 25 Jan 2020 10:12:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] efi/libstub/x86: fix an EFI server boot failure
Message-ID: <20200125091247.GC3028@gmail.com>
References: <20200122191430.4888-1-cai@lca.pw>
 <CAKv+Gu_snhTpsM4cjZ38UhH02v151NW4cJdQu9QVqCWu4rFVZw@mail.gmail.com>
 <CAKv+Gu9R40uywfPkq02AGtKAWqvq+63EEOrhGJf5_gY1xfHkNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9R40uywfPkq02AGtKAWqvq+63EEOrhGJf5_gY1xfHkNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Wed, 22 Jan 2020 at 20:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Wed, 22 Jan 2020 at 20:15, Qian Cai <cai@lca.pw> wrote:
> > >
> > > x86_64 EFI systems are unable to boot due to a typo in the recent commit.
> > >
> > > EFI config tables not found.
> > >  -- System halted
> > >
> > > Fixes: 796eb8d26a57 ("efi/libstub/x86: Use const attribute for efi_is_64bit()")
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  arch/x86/boot/compressed/eboot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > index 82e26d0ff075..287393d725f0 100644
> > > --- a/arch/x86/boot/compressed/eboot.c
> > > +++ b/arch/x86/boot/compressed/eboot.c
> > > @@ -32,7 +32,7 @@ __attribute_const__ bool efi_is_64bit(void)
> > >  {
> > >         if (IS_ENABLED(CONFIG_EFI_MIXED))
> > >                 return efi_is64;
> > > -       return IS_ENABLED(CONFIG_X64_64);
> > > +       return IS_ENABLED(CONFIG_X86_64);
> > >  }
> > >
> > >  static efi_status_t
> >
> > Apologies for the breakage - your fix is obviously correct. But I did
> > test this code, so I am curious why I didn't see this problem. Are you
> > booting via GRUB or from the UEFI shell? Can you share your .config
> > please?
> 
> Hmm, I guess it is simply the absence of CONFIG_EFI_MIXED=y ...
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Ingo, Thomas, could you drop this into efi/core directly please? Thanks.

Sure, done!

Thanks,

	Ingo
