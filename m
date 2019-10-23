Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3855E123A
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 08:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbfJWGiF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 02:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42107 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbfJWGiF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Oct 2019 02:38:05 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A183281F13
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 06:38:04 +0000 (UTC)
Received: by mail-il1-f199.google.com with SMTP id x13so11660536ilg.17
        for <linux-efi@vger.kernel.org>; Tue, 22 Oct 2019 23:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZiwgaG4Q2oxKOaeX7bWyobeJyJbNtWOopUfWLYGvao=;
        b=fkAmMqn1A0RVqAIys7Jh9R6OKKz8myopYl5xl0U2QtRtQgR8yn0SZZ2K8Kff8r8O0R
         ykVU10SpMory0U5OLnCaAuA77/D4D+Iv6O3OnLfwUEBJY0qTmnsToxt32awZqIzNYbnW
         DKFKxNVVcUb8/bM7R1mID8X/T6F+mNPi4tXjAkqk1BOXw98Ygv8HDZaMFQsEn+4Qqtg3
         sssTFL1nlSKiZF0RpdGgdSvdajcl+MDt9PNHZRC62UL4CFNXyUfWvHrh47XkUEwTnsbh
         YccOqokKwtkJlF3NpafntjeK42QTZ377HlnxiuSdAAy+lexI6oK6wYQ9fSIJQQRMG77u
         QV/w==
X-Gm-Message-State: APjAAAXFq5JUx5UrS8kJhu5sus2SUSihaU5M3dB/9zrEMC1sDJNahou8
        A2jS0e3AbvQqgahcWiV+ehvMr8wJWYDysXUoa1DEcNkURp76UG+BQgPBdIKTuE6GccfKeamfVIU
        fM6J4ka5YSCSnSAaE6ceFsaxIa1DsyFJbBh5W
X-Received: by 2002:a6b:c701:: with SMTP id x1mr1787388iof.162.1571812683950;
        Tue, 22 Oct 2019 23:38:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz87D0JJBDmy24snBhOLsA0a1X8znm+78nXbfkXRsztcEsuLQnqi8SeRaKSgs996uX8hxQVx/gXzwCiBUSBCM4=
X-Received: by 2002:a6b:c701:: with SMTP id x1mr1787376iof.162.1571812683643;
 Tue, 22 Oct 2019 23:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191017093020.28658-1-kasong@redhat.com> <CAKv+Gu8nJ0uDn0G9s5N1ZM=FE4JB5c2Kjs=mKpatTFkwF0WaaQ@mail.gmail.com>
 <20191022074422.GA31700@zn.tnic> <CAKv+Gu_GxP+83D0cOT=0UgDrxunm2CuKpAfK1SnVkVqV=E0Ozw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_GxP+83D0cOT=0UgDrxunm2CuKpAfK1SnVkVqV=E0Ozw@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 23 Oct 2019 14:37:51 +0800
Message-ID: <CACPcB9fFaU1JQaZvXZTjHJ7mqay64RS-ruWY0i9uo+ad8PTnyg@mail.gmail.com>
Subject: Re: [PATCH v4] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 22, 2019 at 6:15 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 22 Oct 2019 at 09:45, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Oct 22, 2019 at 08:13:56AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 17 Oct 2019 at 11:30, Kairui Song <kasong@redhat.com> wrote:
> > > >
> > > > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > > > And it's a potential issue on all platforms.
> > > >
> > > > It's caused by broken kernel relocation on EFI systems, when below three
> > > > conditions are met:
> > > >
> > > > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> > > >    by the loader.
> > > > 2. There isn't enough room to contain the kernel, starting from the
> > > >    default load address (eg. something else occupied part the region).
> > > > 3. In the memmap provided by EFI firmware, there is a memory region
> > > >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> > > >    kernel.
> > > >
> > > > EFI stub will perform a kernel relocation when condition 1 is met. But
> > > > due to condition 2, EFI stub can't relocate kernel to the preferred
> > > > address, so it fallback to ask EFI firmware to alloc lowest usable memory
> > > > region, got the low region mentioned in condition 3, and relocated
> > > > kernel there.
> > > >
> > > > It's incorrect to relocate the kernel below LOAD_PHYSICAL_ADDR. This
> > > > is the lowest acceptable kernel relocation address.
> > > >
> > > > The first thing goes wrong is in arch/x86/boot/compressed/head_64.S.
> > > > Kernel decompression will force use LOAD_PHYSICAL_ADDR as the output
> > > > address if kernel is located below it. Then the relocation before
> > > > decompression, which move kernel to the end of the decompression buffer,
> > > > will overwrite other memory region, as there is no enough memory there.
> > > >
> > > > To fix it, just don't let EFI stub relocate the kernel to any address
> > > > lower than lowest acceptable address.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > >
> > >
> > > Ingo, Boris, could you please comment on this?
> >
> > Yah, the commit message makes more sense now.
> >
>
>
> Thanks Boris.
>
> Kairui, I will apply the requested changes myself - no need to spin a v5

Thanks for review and the suggestion, that change is a good idea.

-- 
Best Regards,
Kairui Song
