Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0103F20AEC
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2019 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPPRB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 May 2019 11:17:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38869 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPPRA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 May 2019 11:17:00 -0400
Received: by mail-io1-f66.google.com with SMTP id x24so2884846ion.5
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2019 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daNJlRWE2YLofylHIDSaR/X3IJLuyNvlvoXE5tyTYjk=;
        b=z5iIhn/H1NBgeIUcEBSIAMjKWsA246cckLhbsNw/Wx+7OJULS7GY6wFtBVpfnsXeKA
         K+EAMqxvLP6TVd2T43ZO+onU+FRikUBgvEMockWoLxsJenaEIxbd8YKlLRQqbpNzPvf2
         a2hvaS5PnRZNp70jSDBva2lWPHZhPe/ewEVCHC65xmebORXI78UWnhHfWYcM+mzhsKCG
         +eBx1Ds2zT6VidHWLuiOBLrohLXwPin1ghQ7XKGnpcJdrG0F9iNRIWUILOEdZO8ihoRk
         eF2GoH8UAEA8asRqmhutFEHwVFsF1KVdzBOAmuaNSxMCT2dE66nU/oGpNZ/Hi54PcBv0
         oktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daNJlRWE2YLofylHIDSaR/X3IJLuyNvlvoXE5tyTYjk=;
        b=snzxX77feHEa5NWPsYRdOXF/IerMEkDeKyijv4j4dxPJdN2jquTi88MChq0zP73dEw
         zMKQNLRzAUYdJsuBPj8iBViloUN55uU6E59hyStMxDF0HK5NiTlYdBzAdYQBpK7zg8gx
         HaSF8q4qZwlaqcTBZcTgs7MA+zKFC49kBA84JijrwcPB+VKq0608bpqyGfAJ8jzxj8El
         RzKVjXFdG0Vnwsl9i32O4SP8VlZmXpUBlEGINVybE5whbj+u1aqFQ/ayPurPEr5n+URS
         iJZspxLAuFfttkB76CwaFw9Cfz1kYIb1ocgzlxB6ZdmlHcWz6N0TBAJxR3mY10soByvo
         NWsw==
X-Gm-Message-State: APjAAAWToikgDef7DcFinYzTcQJDsBRAavQuMv41W7QJeudR/mG/iDR6
        m3ZCTb4G9Umj4ewpuFuVq1W0sBoG6F5a3wLnMcTV5g==
X-Google-Smtp-Source: APXvYqz6KouLHZ0E2/SfOs37Sy8GAsrGH2UQkeWUaN1f0I9toUUn1FONL7cgMkFhdxf92ZC0ez2EZDaHDLfr/s+s8Rs=
X-Received: by 2002:a6b:ea12:: with SMTP id m18mr28631230ioc.173.1558019819811;
 Thu, 16 May 2019 08:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190423144354.3465-1-ard.biesheuvel@linaro.org>
 <CADvTj4pYsCq8ZgcL7kELuT77URZbaDmDe-o8qj-M97e0aeCGUw@mail.gmail.com>
 <CAKv+Gu_EN2A9fBOuw34xw=Exjbqz_0J7BzrOb2ZuWK26ouxtCQ@mail.gmail.com> <CADvTj4r4bJFHU6XELFrJ9DsT9Ao92BbcHr0GhtYzFVs8+JrTSQ@mail.gmail.com>
In-Reply-To: <CADvTj4r4bJFHU6XELFrJ9DsT9Ao92BbcHr0GhtYzFVs8+JrTSQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 16 May 2019 17:16:47 +0200
Message-ID: <CAKv+Gu8=6D46bjfq05v7JHFWoR5mLWbDoV8eNw1-HsBR1uqOSA@mail.gmail.com>
Subject: Re: [PATCH] fbdev/efifb: ignore framebuffer memmap entries that lack
 any memory types
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 May 2019 at 15:23, James Hilliard <james.hilliard1@gmail.com> wrote:
>
> On Tue, Apr 23, 2019 at 5:38 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 23 Apr 2019 at 17:01, James Hilliard <james.hilliard1@gmail.com> wrote:
> > >
> > > On Tue, Apr 23, 2019 at 4:44 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > Commit 38ac0287b7f4
> > > >
> > > >   ("fbdev/efifb: Honour UEFI memory map attributes when mapping the FB")
> > > >
> > > > updated the EFI framebuffer code to use memory mappings for the linear
> > > > framebuffer that are permitted by the memory attributes described by the
> > > > EFI memory map for the particular region, if the framebuffer happens to
> > > > be covered by the EFI memory map (which is typically only the case for
> > > > framebuffers in shared memory). This is required since non-X86 systems
> > > > may require cacheable attributes for memory mappings that are shared
> > > > with other masters (such as GPUs), and this information cannot be
> > > > described by the Graphics Output Protocol (GOP) EFI protocol itself,
> > > > and so we rely on the EFI memory map for this.
> > > >
> > > > As reported by James, this breaks some x86 systems:
> > > >
> > > >   [ 1.173368] efifb: probing for efifb
> > > >   [ 1.173386] efifb: abort, cannot remap video memory 0x1d5000 @ 0xcf800000
> > > >   [ 1.173395] Trying to free nonexistent resource <00000000cf800000-00000000cf9d4bff>
> > > >   [ 1.173413] efi-framebuffer: probe of efi-framebuffer.0 failed with error -5
> > > >
> > > > The problem turns out to be that the memory map entry that describes the
> > > > framebuffer has no memory attributes listed at all, and so we end up with
> > > > a mem_flags value of 0x0.
> > > >
> > > > So work around this by ensuring that the memory map entry's attribute field
> > > > has a sane value before using it to mask the set of usable attributes.
> > > >
> > > > Reported-by: James Hilliard <james.hilliard1@gmail.com>
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > ---
> > > >
> > > > James, could you give this a try please? Thanks.
> > > I can confirm this fixes the regression on my system, thanks.
> >
> > Thanks James, I will add your tested-by.
> >
> > I forgot to include EFI_MEMORY_UC in the first mask, so I will respin
> > and resend.
> Is there an updated patch I should test?

No, apologies for the delay - I have updated the patch and will send
it upstream as a fix once I have confirmed that it doesn't cause any
regressions.
