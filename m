Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE879B1581
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2019 22:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfILUmx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Sep 2019 16:42:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46317 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfILUmx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Sep 2019 16:42:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so17074163wrq.13
        for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2019 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5mdDmoc/tRZLT/rMtSHVbAXuFwLBlHwKfuGmHz7Qgk=;
        b=CBcmH+lHnBFABg/DhqAXzodWiXsBrFjJOe8H3EeMH4vqrwBsJ1pir3NMhCjcEG6GkV
         BEI2Xe7PVSZABOmJ4otoxTws1GqqfcUKQ0FIerLh7RQ77i+9hG+KOCZftLdI0hACy0t9
         D6mtVSIrtHteuEfPRNd1QmDmsAhchdUmWfOkRgVsdO2lQuShlN+Qhk+hEeK3Wy6F9UHl
         PjPunX31lhJBR/svogTzIiVTIFJVAapcZaMzx3PX3zsAz9mJIID5Wk5qn3cyZWiEduFr
         QcucwCFeof3rEBUjixXe0OjmWlxr5+7/ZOBmPxfZoa2Q9Q7G3Y5PyAwY6G6osw+wGekr
         hdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5mdDmoc/tRZLT/rMtSHVbAXuFwLBlHwKfuGmHz7Qgk=;
        b=p1Bl7G07stAY27tuH4khZ/W/VaNlv97pseYXVOiB9GExzupc/Iv1pqtPmMtyMM0aLV
         xEGhzTugsxtzIXJp9KVj8szZAv42hbsrIzgw5A84nuOzlPwAlaZB0v1ae9SjJYa4ftz3
         dYVJDSCJDTfNtbzYWWatFbTiOrKWKJJvz+iDh0sSlR54LyV0Ko1CCJvxoHh22csA9K8w
         buySrta92BgCOJu53CVDt35YaYjxF2zkpjbpXJZ4yI8x9dY0XxcYNbwVrtJJK52xJRvS
         TVN6E7x2dNAx9kocH+CbRjYfgdRzXQVGK99SPvhwe4GIBdca5olkvufE3J/JuWc7sayn
         L+2w==
X-Gm-Message-State: APjAAAUoCVKyYIzt9RdezQCI3AZJteD0XIt6q8nrafF3LwG5l4kHQKGI
        VBPCylLZiNLgyipf8gfylT4wwjp71SsRRD58VgHWMnjkfZgV4w==
X-Google-Smtp-Source: APXvYqxhkXSzwltjlUOxK+zSt/zhI1dpxfX3bOURmQlDuGKptEs9E8/DkAs24FO+IljuFH0aYQawu2Hw3KtOLVcGwcA=
X-Received: by 2002:a5d:638f:: with SMTP id p15mr320900wru.169.1568320969599;
 Thu, 12 Sep 2019 13:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190911233239.5916-1-ard.biesheuvel@linaro.org> <alpine.DEB.2.21.1909121533270.30174@bear.techie.net>
In-Reply-To: <alpine.DEB.2.21.1909121533270.30174@bear.techie.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Sep 2019 21:42:28 +0100
Message-ID: <CAKv+Gu95wtjPXRUF=wK3-Y6+zNcvaqpr+T4Z4-wV3OJH+oNgVg@mail.gmail.com>
Subject: Re: [PATCH] efi: don't iterate over EFI vars pointlessly if no SSDT
 override was specified
To:     Scott Talbert <swt@techie.net>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 12 Sep 2019 at 20:35, Scott Talbert <swt@techie.net> wrote:
>
> On Thu, 12 Sep 2019, Ard Biesheuvel wrote:
>
> > The kernel command line option efivar_ssdt= allows a EFI variable name
> > to be specified which contains an ACPI SSDT table that will be loaded
> > into memory by the OS.
> >
> > Currently, that code will always iterate over the EFI variables and
> > compare each name with the provided name, even if the command line
> > option wasn't set to begin with.
> >
> > So bail early when no variable name was provided.
> >
> > Cc: Scott Talbert <swt@techie.net>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > drivers/firmware/efi/efi.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index ad3b1f4866b3..8f020827cdd3 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -282,6 +282,9 @@ static __init int efivar_ssdt_load(void)
> >       void *data;
> >       int ret;
> >
> > +     if (!efivar_ssdt[0])
> > +             return 0;
> > +
> >       ret = efivar_init(efivar_ssdt_iter, &entries, true, &entries);
> >
> >       list_for_each_entry_safe(entry, aux, &entries, list) {
>
> Thanks for the quick fix!
>
> I can confirm this fixes booting on my Mac Pro 2012 system when applied to
> 5.3-rc7.
>
> Whenever this makes it in, if it could be targeted for the stable kernels
> as well, that would be appreciated.
>

I'll send it out as a fix with a cc to -stable.

Thanks,
Ard.
