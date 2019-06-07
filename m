Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56E39663
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfFGUDi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 16:03:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34097 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfFGUDi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 16:03:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id u64so2302938oib.1
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNWHofgNaqy6pErzI2UDdlfPXYGdisLICCNigvI4kL0=;
        b=u6rXT3Xk89E7qKZJuqet/kerwsW/8pbifYfbULG0Hl/9cqx/I2ZRAEyvBG62o4extZ
         wAaIEjw3XjBv16xyVl1le/CrVWXfxtjbO+/oJacrZ7oKh3hvurUvbwDA/9HTSM20GBjn
         w5BBygSxhP2JKc63CxyI3teYBc84w8qnOmwxMKIgAOtMMiuAcSIq4AtgY5fyAra+CJHI
         oF4c/P4dsqTzwVfwmGRtz2IoT9hpxJhBJtN/CXH5nQ6lK38J+bgrm3NiRudTmRV4xr8B
         w9zoN74jsv49+DgrTPWzcfpX7kTtx8FhE+9Qxspy8dgylv58d2b5qynGCr7A6rUP8kjG
         xw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNWHofgNaqy6pErzI2UDdlfPXYGdisLICCNigvI4kL0=;
        b=rIMfwrNVlL5I07/h5txImrrl3+Zm3cwb8kUgWGn0uG7dJFSXNkFnlZgG4y2z7jNFwX
         XvrvimidCJ4N/HE3hEVwLQNl3pe7G1Mj2Tp53IQTXrrxaWWo3HcULHn0VGgKCz2SDm17
         GVHM73POsV9aTDE4mgNDAS9ERf/FeEzaQZNJIb20PW1F15pFXxwFVv/DY5c24hFptZcp
         09DjhbxyqoWpUn11WN2bXzgZZbbqgJxoLDUFjD8QOT4L4VnMD804qs49Ft0CXbmCP2pH
         9FJ/zOaDmglClmyV0N5qbjYxUhpZDYItGW+NVJLNyBBSL/FL7PH8bbWXme3cmjU7vCvE
         d3UQ==
X-Gm-Message-State: APjAAAW0yw8xo+2v+NLpTjhHqOz2GvPl5TdKzPBlk2KwPkmGKktXYrLt
        mGSFOYthD7vo3xIBfCszFNmzQidm7zU12pAgvb53gw==
X-Google-Smtp-Source: APXvYqzjRw0XmHbFfB6N+LCDL02dSt9gHYEVSEZPCDUNI5M9/YAyKIO6lrQhDDoN+9fLMKTRkM2lsSceY96vks8ggTQ=
X-Received: by 2002:aca:aa88:: with SMTP id t130mr2819351oie.70.1559937817614;
 Fri, 07 Jun 2019 13:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993564854.3036719.3692507629721494555.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f6c2d673-a202-4ad5-7055-5aaece9356e1@intel.com>
In-Reply-To: <f6c2d673-a202-4ad5-7055-5aaece9356e1@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 13:03:26 -0700
Message-ID: <CAPcyv4iFG3Z9xL9TSmqLVHxLZ6oiz-uWD6iKgJ8LF4f0n=m9=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] efi: Enumerate EFI_MEMORY_SP
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 7, 2019 at 12:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 12:27 PM, Dan Williams wrote:
> > @@ -848,15 +848,16 @@ char * __init efi_md_typeattr_format(char *buf, size_t size,
> >       if (attr & ~(EFI_MEMORY_UC | EFI_MEMORY_WC | EFI_MEMORY_WT |
> >                    EFI_MEMORY_WB | EFI_MEMORY_UCE | EFI_MEMORY_RO |
> >                    EFI_MEMORY_WP | EFI_MEMORY_RP | EFI_MEMORY_XP |
> > -                  EFI_MEMORY_NV |
> > +                  EFI_MEMORY_NV | EFI_MEMORY_SP |
> >                    EFI_MEMORY_RUNTIME | EFI_MEMORY_MORE_RELIABLE))
> >               snprintf(pos, size, "|attr=0x%016llx]",
> >                        (unsigned long long)attr);
> >       else
> >               snprintf(pos, size,
> > -                      "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> > +                      "|%3s|%2s|%2s|%2s|%2s|%2s|%2s|%2s|%3s|%2s|%2s|%2s|%2s]",
> >                        attr & EFI_MEMORY_RUNTIME ? "RUN" : "",
> >                        attr & EFI_MEMORY_MORE_RELIABLE ? "MR" : "",
> > +                      attr & EFI_MEMORY_SP      ? "SP"  : "",
> >                        attr & EFI_MEMORY_NV      ? "NV"  : "",
> >                        attr & EFI_MEMORY_XP      ? "XP"  : "",
> >                        attr & EFI_MEMORY_RP      ? "RP"  : "",
>
> Haha, I went digging in sysfs to find out where this gets dumped out.
> The joke was on me because it seems to only go to dmesg.
>
> Separate from these patches, should we have a runtime file that dumps
> out the same info?  dmesg isn't always available, and hotplug could
> change this too, I'd imagine.

Perhaps, but I thought /proc/iomem was that runtime file. Given that
x86/Linux only seems to care about the the EFI to E820 translation of
the map and the E820 map is directly reflected in /proc/iomem, do we
need another file?
