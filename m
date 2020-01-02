Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E512E7DE
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgABPEw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 10:04:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32913 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgABPEv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 10:04:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so39564704wrq.0
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkYbZ6KK3Y7fEdmYILUpQ8qGJR+P0Laq+aZlM488zgo=;
        b=lfT5MoUgc3PILoQ+mSA7bTv8pSlmh57gre4kEqsWLpdiqzKMCS7WPDAiNPhfPHooDa
         94OymvrAHNgN4+8WFWYu1Ka4aPiJRBVCLEuJRcM6OdGKzfwan9HQNxoZpqu2lYt0YWKG
         wrpqgD7AO48TyZaRJZsI4zojy6UJko9jaUji2TlriQOQrmlh81864I1zZ0L+KMLxAdmb
         BluM3OKOz4kXti1Ug3U7UohTElXsK8hda3gIsuE7POtUfEuTdcNMo1ENTadbJ9fC+Iys
         Quu1jD5reCYuXst2NVm58ntK5iKR6A6Pv9QLw/KBOsBxj6ozJ9mOPhq1BT5GN+bPr09L
         Ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkYbZ6KK3Y7fEdmYILUpQ8qGJR+P0Laq+aZlM488zgo=;
        b=jaf61i1bsdvKGmdPzbIeVOstc99htootXOWppUIx0k3TkCGrueiqgXPy0IV8q055Bk
         M9jVBnE2VeA9s4pDQrmIMgwc897pkjA/M61dq+iuAoJT+d/X3ofrua9josZdGT0u5U6D
         HBnsVI6I/vhk0IRXE/k55xLt8LijVxJtxbLeX3RtsRkq6iwiKBV+/QCmMWvWO1OQFjfR
         BuSWTl5aB2PoikiJg5uaTBKE7Swxxy9tLgjua4FAm0HSqqlRMyAlCeeeeU7jk8zgWAdH
         fuNSGctOkXKYJSgERxXKeJzOUu3h3jp14gKlluJx82iq4R3D3Rr0vHMYpkKCSK14RUen
         jKKQ==
X-Gm-Message-State: APjAAAUMTWtrpkcH7zU52w4Bc/pj9CzL123nfSYn9I4j0SQBuMzzmAdI
        1xepWjp/VxIbk0jO6hB+V0Sid302yltA3OM4cwtRAQ==
X-Google-Smtp-Source: APXvYqxoqeF3xt7ysAaxNQSPnUv2vTlnqGeO6LqxbiS4QsqmIdBhx5PcGmNPXfD0NCCXgbntwmuJ3wKZ0ERtDCEsH5s=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr81067180wrs.200.1577977490225;
 Thu, 02 Jan 2020 07:04:50 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu82ZCk3Wy6NHHyRs0CAFXJDMfDu2KpH3PZ-Le1SjsQLLQ@mail.gmail.com>
 <20191231160547.GB13549@zn.tnic> <20200102143757.tqhvff32ksc2rpvh@hpe.com>
In-Reply-To: <20200102143757.tqhvff32ksc2rpvh@hpe.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 Jan 2020 16:04:39 +0100
Message-ID: <CAKv+Gu9y9yA+4cnii6QvJ3CjxqmxPmEc333cKezzxwrPCKvKGQ@mail.gmail.com>
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

On Thu, 2 Jan 2020 at 15:38, Russ Anderson <rja@hpe.com> wrote:
>
> On Tue, Dec 31, 2019 at 05:05:47PM +0100, Borislav Petkov wrote:
> > On Tue, Dec 31, 2019 at 12:13:18PM +0100, Ard Biesheuvel wrote:
> > > (adding Boris and Dave for the historical perspective)
> > >
> > > On Thu, 26 Dec 2019 at 10:55, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > We carry a quirk in the x86 EFI code to switch back to an older
> > > > method of mapping the EFI runtime services memory regions, because
> > > > it was deemed risky at the time to implement a new method without
> > > > providing a fallback to the old method in case problems arose.
> > > >
> > > > Such problems did arise, but they appear to be limited to SGI UV1
> > > > machines, and so these are the only ones for which the fallback gets
> > > > enabled automatically (via a DMI quirk). The fallback can be enabled
> > > > manually as well, by passing efi=old_map, but there is very little
> > > > evidence that suggests that this is something that is being relied
> > > > upon in the field.
> > > >
> > > > Given that UV1 support is not enabled by default by the distros
> > > > (Ubuntu, Fedora), there is no point in carrying this fallback code
> > > > all the time if there are no other users. So let's refactor it a bit
> > > > to make it depend on CONFIG_X86_UV, and remove the ability to enable
> > > > it by hand.
> > > >
> > > > Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> > > > Cc: Mike Travis <mike.travis@hpe.com>
> > > > Cc: Hedi Berriche <hedi.berriche@hpe.com>
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Boris, since you were the one that added efi=old_map: do you know of
> > > any cases beyond SGI UV1 where it was actually needed? There is some
> > > mention of using it to work around transient breakage on 32-bit caused
> > > by your original changes, but other than that, Google doesn't seem to
> > > know about any cases where efi=old_map is being used to deal with
> > > actual firmware quirks.
>
> We (SGI -> HPE) have used the efi=old_map quirk to work around issues,
> including on the currently shipping HPE Superdome Flex (aka UV4).
>
> An example was working around an EFI locking issues when calling
> into BIOS, fixed by this commit.
>
>   f331e766c4be ("x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls")
>
> We do not currently use the quirk, and nopefully never will need to
> use it again, but it has been used recently and are very glad Boris
> added it.  I am hesitent to remove it because it has been used recently
> on currently shipping hardware.
>

Thanks for the data point.

So what about making it depend on CONFIG_X86_UV=y, would that still
work for you?
