Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58621A1CD4
	for <lists+linux-efi@lfdr.de>; Wed,  8 Apr 2020 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDHHt2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 03:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgDHHt1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 8 Apr 2020 03:49:27 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300B720857;
        Wed,  8 Apr 2020 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586332167;
        bh=LFSPRKgmR8auwK03bWcZlzXa6g+J6cxGqFZeIyDLWBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M4A3XfdLzGoCqjFphZs46oHKHPvNRNyaxBpA9xZOfsoCACHV49gh3cMPEQj0HjuuH
         K5KQp0P7ZX1Za5RsThorpN36rb8kGaUgiaq32dYWGNm/PIEGD7Xe4ymWpTMGYbdsuu
         gSRBrZ2r52eMPpBPRm9gCBQCDV5PL1qvhKb/3sxc=
Received: by mail-io1-f54.google.com with SMTP id b12so6153064ion.8;
        Wed, 08 Apr 2020 00:49:27 -0700 (PDT)
X-Gm-Message-State: AGi0PuZtXrHE6BJHRoT5TAyDCbab9LHXjcCi6fR3Oyja3IP1Pcug2yr4
        jZpkLKZnZ/b6PHrWjviDRaWZR8QSdflqXaKQBb4=
X-Google-Smtp-Source: APiQypJAwEiSBhRkO0KExJ3QXtqZu8DVb4U6xjsYMWHvwGiy5FHwkV4VytajI+cifcoP5E+rtFqkmv24wXCBpeMiAEI=
X-Received: by 2002:a6b:f413:: with SMTP id i19mr5867611iog.203.1586332166519;
 Wed, 08 Apr 2020 00:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXEUkJ1XJ9OTsijeq8tNNYC00bXqEV44OMtX5ugo9WoLKA@mail.gmail.com>
 <20200406180614.429454-1-nivedita@alum.mit.edu> <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200408074334.GA21886@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Apr 2020 09:49:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
Message-ID: <CAMj1kXGPOZ6zWtgGScLy0ECrTtf1yhngDTNE1chW-MQw3XQp9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi/x86: Move efi stub globals from .bss to .data
To:     Dave Young <dyoung@redhat.com>, pjones@redhat.com,
        daniel.kiper@oracle.com, Leif Lindholm <leif@nuviainc.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Sergey Shatunov <me@prok.pw>,
        hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>,
        initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(add Peter, Leif and Daniel)

On Wed, 8 Apr 2020 at 09:43, Dave Young <dyoung@redhat.com> wrote:
>
> On 04/06/20 at 02:06pm, Arvind Sankar wrote:
> > Commit
> >
> >   3ee372ccce4d ("x86/boot/compressed/64: Remove .bss/.pgtable from
> >   bzImage")
> >
> > removed the .bss section from the bzImage.
> >
> > However, while a PE loader is required to zero-initialize the .bss
> > section before calling the PE entry point, the EFI handover protocol
> > does not currently document any requirement that .bss be initialized by
> > the bootloader prior to calling the handover entry.
> >
> > When systemd-boot is used to boot a unified kernel image [1], the image
> > is constructed by embedding the bzImage as a .linux section in a PE
> > executable that contains a small stub loader from systemd together with
> > additional sections and potentially an initrd. As the .bss section
> > within the bzImage is no longer explicitly present as part of the file,
> > it is not initialized before calling the EFI handover entry.
> > Furthermore, as the size of the embedded .linux section is only the size
> > of the bzImage file itself, the .bss section's memory may not even have
> > been allocated.
>
> I did not follow up the old report, maybe I missed something. But not
> sure why only systemd-boot is mentioned here.  I also have similar issue
> with early efi failure.  With these two patches applied, it works well
> then.
>
> BTW, I use Fedora 31 + Grub2
>

OK, so I take it this means that GRUB's PE/COFF loader does not
zero-initialize BSS either? Does it honor the image size in memory if
it exceeds the file size?
