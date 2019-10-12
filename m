Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9992D4C89
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2019 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfJLDqz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 23:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfJLDqz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Oct 2019 23:46:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A562D83F42
        for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2019 03:46:54 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id g126so17447949iof.3
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 20:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX6rdBEDjPMIvpmo1yfONxMIg/joRZEC9Kr+34iTwtQ=;
        b=X0zm6lCI+G3yJRNSdZfwZXZPcJLiBBD3MLHbClaFnUCZIukdwB+cyxk+7uHH7dbc6s
         jMrVBS/bl9TnzObFPTSRKhyqjnjR5WLJ04ngJ1Ssp513I61EHlX1IHdJ0irWjr+t8Sw+
         NfFrQm03RXpNkWk6r7U1ZryIcSSor+SUP1QT97xNyTlUw80XP2a4Mu8zpD0djNdq1zc1
         Y6N9r0lVgDe6si1jDfgMKBlPxW4ZfDHgQyO/n/3R4U4s9hI8NMDn5n1HJB15XjDlEIP7
         uINJlJ8xcNm9nhLdPLkYBt/mAz01cJCmfCDiPdg/F3voVObews/59fSGZFrkwQGzSQ5h
         +Sig==
X-Gm-Message-State: APjAAAUemZ15Axp8ZklGc1xAtbnPq/U1QNjugGf8aPSJewkbX5cFZt0T
        UvTR6IYApRVRlBZbLFWD1dcwxT3dXoCileOlFY8vuGJyJII4zJnXjESNljykm8rT37P+jaH8yhY
        3cwE41HsGgA2E3/SPmcPre5usEAB92n8H6vh1
X-Received: by 2002:a5d:9052:: with SMTP id v18mr2839598ioq.13.1570852014001;
        Fri, 11 Oct 2019 20:46:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxgN/oeG+/byRql2+hJra84DTMBSjIQyBIvwut4vl0gjW2FpkzZ8PlIJObwmJP2KyWI5PgCHtWv22SL2Ku3iwE=
X-Received: by 2002:a5d:9052:: with SMTP id v18mr2839572ioq.13.1570852013679;
 Fri, 11 Oct 2019 20:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com> <20191011132339.GB8824@zn.tnic>
In-Reply-To: <20191011132339.GB8824@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Sat, 12 Oct 2019 11:46:42 +0800
Message-ID: <CACPcB9cK1DfxbVjTV0oFz__RvNwzR=JA2CFx9c8THdS=hdZsZw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Fri, Oct 11, 2019 at 9:24 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 20, 2019 at 12:05:21AM +0800, Kairui Song wrote:
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
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
> > Efi stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, efi stub can't relocate kernel to the preferred
> > address, so it fallback to query and alloc from EFI firmware for lowest
> > usable memory region.
> >
> > It's incorrect to use the lowest memory address. In later stage, kernel
> > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > but efi stub will end up relocating kernel below it.
>
> So far, so good.
>
> > Then before the kernel decompressing. Kernel will do another relocation
> > to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> > over write the blockage at the default load address, which efi stub tried
> > to avoid, and lead to unexpected behavior. Beside, the memory region it
> > writes to is not allocated from EFI firmware, which is also wrong.
>
> This paragraph is an unreadable mess and should be rewritten in simple,
> declarative sentences.
>
> The patch itself looks ok.

Thanks. I've sent V3 updating that paragraph.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
--
Best Regards,
Kairui Song
