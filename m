Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA412E8F3
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 17:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgABQwx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 11:52:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42131 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgABQww (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 11:52:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so39787588wro.9
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4/bS2HlhDWvMDv8vCGm4tVMXsWRKpkHxnz1ykDX0Rg=;
        b=SfGlOqisnHolcChz2nUCaocIcL2tu2XRuRUL+xyIF5o0jVbHBQbnTaFmcvoun2SvKw
         tY1NfM0xKTsPOYi7eGr6y3Rg/4f6o73h08HVD+BnMHHqux+rY4jyR1nC5zo8TW+iaghL
         XTa5BTO7ghLVPNiOJaXwGKwQCDWs2jFkdQVVQCIMqz8r9OJe1W2qzpi0JlBam7EKgovF
         mz8hRA+G0lzUi07T9Grv5GDrOIKVfn6gKwrSYIYl9XwgP7jqafowyChG/EDXo/Es/HY2
         8AHqTTha10A0dp0Eje3hBv5U3L4sKdEDVmQ6Snynp3vfS+wBJ89o9RZL8oWh6fGmssJf
         nihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4/bS2HlhDWvMDv8vCGm4tVMXsWRKpkHxnz1ykDX0Rg=;
        b=HuEy9h1kFuGc4gybAfa6lfWyrrUEagaohClqJT1VDbduJFsk7hsTaP/9hp6w99RGeL
         7VX97v5LBUqU0wQ/pjRn+VRT+WHE/Hub4bGIQQhK7e0KL6dyQ22OxgXHhA/IkrN++yX9
         XGBztoKVA1Yf0OiB+4IWBi7ZkzImOXBu9NwLOTYSDBtC5KCwQs8iwz/bKV36/Qy2Te9v
         gmOmjVUJKWGig6pLtJRe0kIP5o7FBf278eS+HBPUZXCwVAkJxay/SA5BlJjL1jhmt3Lp
         ZPhiUZcW+Z8Vy3UHSA7DOfbHyiLKvmLna72pCGma4Ow2pRld/Ph9/4Wg+h2QB95fegm9
         +Y7A==
X-Gm-Message-State: APjAAAXcXaQmjVNja7aJh0mBCBS/I3yGHmOjoOVj4ZrLheUGqBeEGuTz
        TcGVGYuiAlKO29Lw4Zx2d4BCFD3a6Pbs+wXSufvz6w==
X-Google-Smtp-Source: APXvYqww2ewegVM4mMpRV1yO4k9uLYBYpqWrK/8KUXB+TnqCTedUTzTpAhVs5dawqLsGdCAygj6h4zcMkXeJp5w3XqQ=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr85966115wrw.246.1577983970518;
 Thu, 02 Jan 2020 08:52:50 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic> <20200102143757.tqhvff32ksc2rpvh@hpe.com>
 <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com> <20200102164536.ks5dmtrbtl4i7rnt@hpe.com>
In-Reply-To: <20200102164536.ks5dmtrbtl4i7rnt@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 17:52:39 +0100
Message-ID: <CAKv+Gu86SaU+D8x2ScRXbTvR8aK23CfhAL=mkUNcn=9vrbgznw@mail.gmail.com>
Subject: Re: [RFC PATCH] efi/x86: limit EFI old memory map to SGI UV1 machines
To:     Russ Anderson <rja@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 Jan 2020 at 17:45, Russ Anderson <rja@hpe.com> wrote:
>
> On Thu, Jan 02, 2020 at 04:04:39PM +0100, Ard Biesheuvel wrote:
> > On Thu, 2 Jan 2020 at 15:38, Russ Anderson <rja@hpe.com> wrote:
> > >
> > > On Tue, Dec 31, 2019 at 05:05:47PM +0100, Borislav Petkov wrote:
> > > > On Tue, Dec 31, 2019 at 12:13:18PM +0100, Ard Biesheuvel wrote:
> > > > > (adding Boris and Dave for the historical perspective)
> > > > >
> > > > > On Thu, 26 Dec 2019 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > We carry a quirk in the x86 EFI code to switch back to an older
> > > > > > method of mapping the EFI runtime services memory regions, because
> > > > > > it was deemed risky at the time to implement a new method without
> > > > > > providing a fallback to the old method in case problems arose.
> > > > > >
> > > > > > Such problems did arise, but they appear to be limited to SGI UV1
> > > > > > machines, and so these are the only ones for which the fallback gets
> > > > > > enabled automatically (via a DMI quirk). The fallback can be enabled
> > > > > > manually as well, by passing efi=old_map, but there is very little
> > > > > > evidence that suggests that this is something that is being relied
> > > > > > upon in the field.
> > > > > >
> > > > > > Given that UV1 support is not enabled by default by the distros
> > > > > > (Ubuntu, Fedora), there is no point in carrying this fallback code
> > > > > > all the time if there are no other users. So let's refactor it a bit
> > > > > > to make it depend on CONFIG_X86_UV, and remove the ability to enable
> > > > > > it by hand.
> > > > > >
> > > > > > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > > > > > Cc: Mike Travis <mike.travis@hpe.com>
> > > > > > Cc: Hedi Berriche <hedi.berriche@hpe.com>
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > >
> > > > > Boris, since you were the one that added efi=old_map: do you know of
> > > > > any cases beyond SGI UV1 where it was actually needed? There is some
> > > > > mention of using it to work around transient breakage on 32-bit caused
> > > > > by your original changes, but other than that, Google doesn't seem to
> > > > > know about any cases where efi=old_map is being used to deal with
> > > > > actual firmware quirks.
> > >
> > > We (SGI -> HPE) have used the efi=old_map quirk to work around issues,
> > > including on the currently shipping HPE Superdome Flex (aka UV4).
> > >
> > > An example was working around an EFI locking issues when calling
> > > into BIOS, fixed by this commit.
> > >
> > >   f331e766c4be ("x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls")
> > >
> > > We do not currently use the quirk, and nopefully never will need to
> > > use it again, but it has been used recently and are very glad Boris
> > > added it.  I am hesitent to remove it because it has been used recently
> > > on currently shipping hardware.
> > >
> >
> > Thanks for the data point.
> >
> > So what about making it depend on CONFIG_X86_UV=y, would that still
> > work for you?
>
> I want to make sure my undestanding of what you are proposing
> is the same as what you are proposing.
>

What I am proposing is to document efi=old_map as only being available
on kernels built with CONFIG_X86_UV=y, and moving the code that
implements it into the UV support code.

> I will have some additional background information shortly.
>

Thanks, that is very helpful.
