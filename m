Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D7195B4D
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 17:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgC0Qji (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 12:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgC0Qji (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 12:39:38 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA6F206E6
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 16:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585327177;
        bh=ZEddlQQBVpZaj68WLHeCIllXn470qEYZsu7CXKIM1ME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0JyndC3rN2BUpb325ijRrsPTzuQ8ygS2o+amG95PBOQvI6lG58PIddSXQl1WrRYrk
         Oeb/gCTBhqwNVgZ4/B19Xu8OJK8O9iMorFMcfTG/oe3ePB9mWrdImBLHeduhoICROT
         uVUWHxhWCMefsMfv2J9vxrUfcwJNJppCN+tobQrQ=
Received: by mail-il1-f179.google.com with SMTP id p13so9334074ilp.3
        for <linux-efi@vger.kernel.org>; Fri, 27 Mar 2020 09:39:37 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2KGsnB0BGBfJJffk052hW3mO+TcYoCrBtCP3Jsyhl23o7iuhei
        dCm0VudUwRutnbgfgUf+roz0925RvL7nTvuwh/E=
X-Google-Smtp-Source: ADFU+vuirgriVF5NaFjEEhDBaIwOsBfuw95HZvZrU2mT18aiPHSY2CISoFqvIX1qQZwRmH6GphbGbem1XLIcbGjresU=
X-Received: by 2002:a92:ddcb:: with SMTP id d11mr14616725ilr.211.1585327176978;
 Fri, 27 Mar 2020 09:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200326165905.2240-1-ardb@kernel.org> <20200327131900.000068aa@Huawei.com>
In-Reply-To: <20200327131900.000068aa@Huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Mar 2020 17:39:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHCs8N3AHjhToseAaLAE4VWi_yC=BF6nru9M3gASJz6Jw@mail.gmail.com>
Message-ID: <CAMj1kXHCs8N3AHjhToseAaLAE4VWi_yC=BF6nru9M3gASJz6Jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] efi/arm64: execute the kernel in place if possible
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 27 Mar 2020 at 14:19, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 26 Mar 2020 17:59:03 +0100
> Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > Update the relocation logic in the EFI stub for arm64 so it runs the
> > kernel in place if it was loaded by firmware at an address which allows
> > doing so. Then, update the PE/COFF header metadata and increase the
> > section alignment to force the UEFI image loader to honour the minimal
> > alignment requirement imposed by the kernel proper.
> >
> > Ard Biesheuvel (2):
> >   efi/libstub/arm64: avoid copying the kernel unnecessarily
> >   efi/arm64: increase the PE/COFF alignment so the kernel can run in
> >     place
> >
> >  arch/arm64/kernel/efi-header.S            | 2 +-
> >  arch/arm64/kernel/image-vars.h            | 7 +++++++
> >  drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> Hi Ard.
>
> Seems sensible to me so I decided to give it a quick test.
> As things stand RELOCATABLE is only selectable by selecting
> RANDOMIZE_BASE.   Probably want to be able to configure it
> separately (needs some help text, or a specific option to
> select CONFIG_RELOCATABLE).
>

The idea is really that KASLR kernels that were booted without a seed
(or with 'nokaslr' on the command line) take this path. But in fact, I
realized that the same logic applies to non-relocatable kernels, just
with an alignment of 2 MB rather than 64 KB or 128 KB. So I will be
sending a v2 that looks slightly different. (Another thing that I
realized is that /if/ the KASLR path fails for any reason, we could
still take this path instead of doing the allocation)

> Otherwise, superficially seems to work good for me doing a
> boot via pxe/grub on a Kunpeng 920 with some prints added to
> make sure it's taking the right paths.
>

Excellent! Thanks for testing, and I will be cc'ing you on v2.
