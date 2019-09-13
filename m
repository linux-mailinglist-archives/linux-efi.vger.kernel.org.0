Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7CB24AD
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfIMRjj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 13:39:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37668 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388037AbfIMRji (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 13:39:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so3633167wme.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbdt8DMuaPHekJf0RQCDEBN2zI9VHU/ceA7ZqRfGDhY=;
        b=XCWrWFpOwytN6fNry1tv4OjtVKdxGfxrREb2Wa9Y95soJfcCx/vfndJZcMnvwMFsBb
         Uh9JiyTv8ZSoRjOYTeF7caSQWMKDuLeQdNgrD+KpFSvZyp76aLGA8w7ahPkrDHRFsYK1
         aZQD8aUOg99uAToMv4By0BkX3t+mmQlKZRg+aQyk0HTG0qIjoq7HBO3/V6/Q9vRYNhPq
         TLtUuiwio5ZR4PsJxJdM0cyxEucgRuow6eA+3ikXKBGfpy6H3dNST9pvCUWvNYJEztx5
         CJ21DL0C5rSkMBBAutdxzgQ24HHvyHxRzwqsn8pnuR6HLHJOKkWsI2fPYNsF7sxpaWRf
         v20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbdt8DMuaPHekJf0RQCDEBN2zI9VHU/ceA7ZqRfGDhY=;
        b=FYyinREXv0NlBrnqhWJj0qX4m9V2/aOkg2xBOMmYygCchxh/2gFQ8KwE4wTPuVVdVU
         CZPiHPRADOU3qDrdZhskaAVhQkMr5cCN8JMAV3AEKk8NwhZmHu+c3b4uZp84Xlr45Wm0
         xhl7ckHZ4NBKgXjUz49pZgcrqu8qlj+xzUnCiZcmKTsttZAwqjP8wbsfijQuZvWWkg4M
         OzBlLhrCECLJklGuNw53kphVaLDoeS20Tw9BDCeFZmbaAMCtqJZWOUWyzcs+zMUHPIgQ
         80Rh3jMNkeL2yY8l3v31iRVBclDn9VW0uwA8FVp/JZixr59qXh+4617lKvbbeigj5q8E
         01vw==
X-Gm-Message-State: APjAAAWwawKHKIND5ie7afLjDsgtWTUdq9SEeJSuq5MqH4Fbj8ZLsLJ6
        PhsxkGx/DHyYiqxuiIEYUqhIQsdMYxuMk97bIc0LGg==
X-Google-Smtp-Source: APXvYqwZe1afAeq+1FbxIrzjzP/GZNh2yHs1/HCK3GXpHwPL1dKVW9Vr27GG4tWONkRjWLoL0QJMgD9gRyazDq9iqRk=
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr4075220wma.136.1568396376147;
 Fri, 13 Sep 2019 10:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995890.1616117.10724047366038926477.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8OOeLyuNwgG1eXM2FGDNrLvigMfR63uWwUB-Jg+WXM7A@mail.gmail.com>
 <CAPcyv4hrEsQ0t1hTT1A5WKFqYhANq15n0ru67SLDfGf1ZG-XWA@mail.gmail.com>
 <CAKv+Gu9ofzdrn8AJkXVkiWM+x8=2_ixnC68Y=Gk5KhEi0X35GA@mail.gmail.com> <CAPcyv4jn1UrxodWR77ut9LBGTHa45Q_98kdAhL6wdaHL9V9RsA@mail.gmail.com>
In-Reply-To: <CAPcyv4jn1UrxodWR77ut9LBGTHa45Q_98kdAhL6wdaHL9V9RsA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 13 Sep 2019 18:39:13 +0100
Message-ID: <CAKv+Gu9MMt6FuW+ZuLFMMcA6ku173u4D9g66WaoEafY4i8j2TA@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] x86, efi: Reserve UEFI 2.8 Specific Purpose
 Memory for dax
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 13 Sep 2019 at 17:39, Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Sep 13, 2019 at 9:29 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 13 Sep 2019 at 17:22, Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Sep 13, 2019 at 6:00 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
...
> > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > > > index 363bb9d00fa5..6d54d5c74347 100644
> > > > > --- a/drivers/firmware/efi/efi.c
> > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > @@ -52,6 +52,9 @@ struct efi __read_mostly efi = {
> > > > >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> > > > >         .tpm_final_log          = EFI_INVALID_TABLE_ADDR,
> > > > >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > > > > +#ifdef CONFIG_EFI_SOFT_RESERVE
> > > > > +       .flags                  = 1UL << EFI_MEM_SOFT_RESERVE,
> > > > > +#endif
> > > > >  };
> > > > >  EXPORT_SYMBOL(efi);
> > > > >
> > > >
> > > > I'd prefer it if we could call this EFI_MEM_NO_SOFT_RESERVE instead,
> > > > and invert the meaning of the bit.
> > >
> > > ...but that would mean repeat occurrences of
> > > "!efi_enabled(EFI_MEM_NO_SOFT_RESERVE)", doesn't the double negative
> > > seem less readable to you?
> > >
> >
> > One the one hand, yes. On the other hand, it is the only flag whose
> > default is 'enabled' which is also less than ideal.
>
> Ok, I can get on board with "default 0" being the non exception state
> of the flags.
>

In fact, let's just add something like

static inline bool efi_soft_reserve_enabled(void)
{
    return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE) &&
           !efi_enabled(EFI_MEM_NO_SOFT_RESERVE);
}

to linux/efi.h and use that in the code?
