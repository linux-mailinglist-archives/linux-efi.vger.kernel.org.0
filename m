Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F8795E7D
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfHTM2j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 08:28:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39900 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfHTM2i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 08:28:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so2473489wmg.4
        for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2019 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD0Co8FG/hJyJAYUqVEMglsK3T7bNz9NWAIKm1yXSok=;
        b=IAB/CxVy5OTM+bm1P/vwQO5e1zYJhw5W+8ZMfEr0TwRT2EHai9xEb7z0JLGvQL+AEM
         noesBxet+SdZXcyD+TDMiDedkuNJmvs0pynLhCizA0UKehvY/U9nfrqf3O3c50RdYmHc
         EgXw+nNiCh+Jqg7tX3pehf5oIkz3QOguhxAmmqUBwDTwZURbQrU1MliR4D+sVI/Dws45
         /wPIeJtLO2Bq1hSk5IZ6nNWF4wkRDFhE2tHy/FDvCFmeq3K+tWEMzX5g+jIp+xLZV1MA
         bPVJnH/qV91SbwdsFTlvnaGFPw3OEGc2X0UvXAcuGwYmdjhJpONCMhMRLJlRJAWxww/3
         gCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD0Co8FG/hJyJAYUqVEMglsK3T7bNz9NWAIKm1yXSok=;
        b=WK4n2bM0WxZbXOH7ieiy+A+jgX7n1buA38dWdtxVpfmR9gOvTQ8z2WpcX08wUDVOzW
         Gy67UC5e56UWEQQ5HZyEqKtZnUYY3G7QLbKoPYxpw6Rvxosz31IGBbUM1DFypQb5YNLb
         HO0r4CH4pW2uhUPeQ7TsFh7mlLnfSP9nIt8ZOlIusYUE/21djpng76N8B+s+nnAKZWNW
         wd8xnKIUib9OUoLRHxj93xZ3TKlXqaNnHGrYn3yUZC74dEOHoVh2wzScCMMZAe4PZAcr
         q616gfmtndSgu6GkL8g329SgAfRLwAyQjZKmGe3EJzl9jTO+ydZoROFCKqt+7OfSD9CU
         tN/A==
X-Gm-Message-State: APjAAAXlB7x1PVqqqXacZP/m2OI+snCcUcjwO3xgIwVS6hKbtxgzV9WQ
        VJJoZxTTnoeolwquWOFQ8SRTQdYbd+7pc5OmkHVZAQ==
X-Google-Smtp-Source: APXvYqwSKf9shWqXFfBH3UvF0PUWc/5bjTYYsXrXLzFdNVsyC2m1uK+Ysr6+BUjAuYl3vNvngGtA/b2r1ypTsOqz4Ps=
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr25055919wmm.119.1566304116782;
 Tue, 20 Aug 2019 05:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <20190820115645.GP13294@shell.armlinux.org.uk>
In-Reply-To: <20190820115645.GP13294@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 20 Aug 2019 15:28:25 +0300
Message-ID: <CAKv+Gu_0wFw5Mjpdw7BEY7ewgetNgU=Ff1uvAsn0iHmJouyKqw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Chester Lin <clin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Aug 2019 at 14:56, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Aug 02, 2019 at 05:38:54AM +0000, Chester Lin wrote:
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index f3ce34113f89..909b11ba48d8 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1184,6 +1184,9 @@ void __init adjust_lowmem_bounds(void)
> >               phys_addr_t block_start = reg->base;
> >               phys_addr_t block_end = reg->base + reg->size;
> >
> > +             if (memblock_is_nomap(reg))
> > +                     continue;
> > +
> >               if (reg->base < vmalloc_limit) {
> >                       if (block_end > lowmem_limit)
> >                               /*
>
> I think this hunk is sane - if the memory is marked nomap, then it isn't
> available for the kernel's use, so as far as calculating where the
> lowmem/highmem boundary is, it effectively doesn't exist and should be
> skipped.
>

I agree.

Chester, could you explain what you need beyond this change (and my
EFI stub change involving TEXT_OFFSET) to make things work on the
RPi2?
