Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B2282B4C
	for <lists+linux-efi@lfdr.de>; Sun,  4 Oct 2020 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJDOkw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 4 Oct 2020 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOkv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 4 Oct 2020 10:40:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07DAC0613CE;
        Sun,  4 Oct 2020 07:40:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o5so8766028qke.12;
        Sun, 04 Oct 2020 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZRiP4Emq2Z7C3Y4jfd7qgj2bjSoEYPQwBWLcol5Z8U=;
        b=M+ezeqbZ5OZCUYeK09zXeqm2wMzr8wo0mJqZ0KLOfUpVczKGkPqTGLYbCYRjUFXydn
         XzdpF3I6GwIeAA/7lBHF4IfOQYtBpAT8xmNuqh9bHGNuGxhTGCOnFySy0I8w3D3I/6/3
         7Ei2Z0jnvlin7pOWesflWQJ/5gIuv2CocwqRuPeBj7z1rhuDom7mq3/XIzhVS5jnpqLX
         9p+Wx8zSgAc4PKqF/+u9lbC5n31Q4IsYAkN3wvCrNmMt1KbpduJPrfzqTf+wl0WCo/Kd
         bbkZetJO74IOedYPVhpb3y4Tnu0B5+L35A8cteYmc0cMZoN/46hF4Q1XY7D240z+eQsV
         iy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KZRiP4Emq2Z7C3Y4jfd7qgj2bjSoEYPQwBWLcol5Z8U=;
        b=Xz6hV4N72BemgsKkGABGHVeP2JkewlXxW76In3mIDsFZ4IHXZcoyMTfA3NwSl0PmQw
         3qCrAWagkklDq50VoVaiJG25BCWU+DdJdAAhfrNcYpQM4qjzsIPgQAjKdFXwskhXwe8I
         FzORVPJ41BWNa4W5f/0GmrdtLmITih/ZgxSyg2WpqxbyQb3uj2kERGBf0+4eJCjQwxkv
         5Ozd5gFqnu7qDxrgg9NNwv0NHtodurR5Cw368Jt/PwLYasSQRF5Df1IJ/sRdwwFtyi77
         PeRrbt4UU7Jz7gZqkgnPYUHKQqNfype+xU7gz4+AQY+oV8ImHOUihlMTKdwI3eAH4ZuL
         NCdg==
X-Gm-Message-State: AOAM5324u4onD+y62GnfjZIX9wVmuejE82pfr+zQhVi0rYB7zDO8Gpaa
        Ou/Lt0SruHBcW3GsJv1NEEo=
X-Google-Smtp-Source: ABdhPJxlqZLQCHP6LaykV/D7dRUSpZaD6Wuzq59NB6FH6I1JFtT3UETnP1/iHfDrHVWvbrxUKJeqQQ==
X-Received: by 2002:a37:6805:: with SMTP id d5mr10038621qkc.116.1601822450631;
        Sun, 04 Oct 2020 07:40:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 192sm5557247qkn.9.2020.10.04.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 07:40:50 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 4 Oct 2020 10:40:48 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] efi/libstub/x86: simplify efi_is_native()
Message-ID: <20201004144048.GA1526180@rani.riverdale.lan>
References: <20201003060356.4913-1-xypron.glpk@gmx.de>
 <CAMzpN2hZ6833u4P=Vr1hueoYCfYryHoTW1dpa-9FTL3nvehJ0A@mail.gmail.com>
 <20201003194429.GA768061@rani.riverdale.lan>
 <CAMj1kXHW-WSYM+dDJObsG6EL4WXHqmqpRfwLqG3hs4NO2wC=-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHW-WSYM+dDJObsG6EL4WXHqmqpRfwLqG3hs4NO2wC=-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 04, 2020 at 04:14:11PM +0200, Ard Biesheuvel wrote:
> On Sat, 3 Oct 2020 at 21:44, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sat, Oct 03, 2020 at 01:28:18PM -0400, Brian Gerst wrote:
> > > On Sat, Oct 3, 2020 at 2:05 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > CONFIG_EFI_MIXED depends on CONFIG_X86_64=y.
> > > > There is no need to check CONFIG_X86_64 again.
> > > >
> > > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > ---
> > > >  arch/x86/include/asm/efi.h | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > > > index b9c2667ac46c..ab28bf1c74cf 100644
> > > > --- a/arch/x86/include/asm/efi.h
> > > > +++ b/arch/x86/include/asm/efi.h
> > > > @@ -223,8 +223,6 @@ static inline bool efi_is_64bit(void)
> > > >
> > > >  static inline bool efi_is_native(void)
> > > >  {
> > > > -       if (!IS_ENABLED(CONFIG_X86_64))
> > > > -               return true;
> > > >         return efi_is_64bit();
> > > >  }
> > >
> > > This would then return false for native 32-bit.
> > >
> > > --
> > > Brian Gerst
> >
> > 32-bit doesn't use this implementation: it's #define'd to true in
> > drivers/firmware/efi/libstub/efistub.h.
> >
> 
> Yes, and the reason this [now redundant] test exists is because this
> did not use to be the case before
> 
> de8c55208c386 efi/libstub: Fix mixed mode boot issue after macro refactor

Heh, my fault for not cleaning it up then :)

> 
> So for this patch
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> I'll queue this up
