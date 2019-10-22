Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1665ADFE8C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Oct 2019 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfJVHpC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Oct 2019 03:45:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42478 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfJVHpC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 Oct 2019 03:45:02 -0400
Received: from zn.tnic (p4FED31B8.dip0.t-ipconnect.de [79.237.49.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 220471EC0C5C;
        Tue, 22 Oct 2019 09:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571730301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3ZuiOtOrGhN5RdAedvLTRxybDphCcw+39KdvlnjWico=;
        b=oM1KYUcBqoXeHpCxTGr4T2mCPDOpn/QS1Fu1A7mp42nW8ZFYkoqyrdjc25nKgwQaJRO16b
        Da4jkZsNtNck9RHYVDnUG+f71dJ7X3cYlH6cylJLIg90r1l7pATfn1KqM+kBeSYD/032KA
        AQfYXnUsP/k/wuNcy4CA97yV0Qbgq5s=
Date:   Tue, 22 Oct 2019 09:44:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20191022074422.GA31700@zn.tnic>
References: <20191017093020.28658-1-kasong@redhat.com>
 <CAKv+Gu8nJ0uDn0G9s5N1ZM=FE4JB5c2Kjs=mKpatTFkwF0WaaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8nJ0uDn0G9s5N1ZM=FE4JB5c2Kjs=mKpatTFkwF0WaaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 22, 2019 at 08:13:56AM +0200, Ard Biesheuvel wrote:
> On Thu, 17 Oct 2019 at 11:30, Kairui Song <kasong@redhat.com> wrote:
> >
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused by broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
> >
> > EFI stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, EFI stub can't relocate kernel to the preferred
> > address, so it fallback to ask EFI firmware to alloc lowest usable memory
> > region, got the low region mentioned in condition 3, and relocated
> > kernel there.
> >
> > It's incorrect to relocate the kernel below LOAD_PHYSICAL_ADDR. This
> > is the lowest acceptable kernel relocation address.
> >
> > The first thing goes wrong is in arch/x86/boot/compressed/head_64.S.
> > Kernel decompression will force use LOAD_PHYSICAL_ADDR as the output
> > address if kernel is located below it. Then the relocation before
> > decompression, which move kernel to the end of the decompression buffer,
> > will overwrite other memory region, as there is no enough memory there.
> >
> > To fix it, just don't let EFI stub relocate the kernel to any address
> > lower than lowest acceptable address.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> 
> Ingo, Boris, could you please comment on this?

Yah, the commit message makes more sense now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
