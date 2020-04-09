Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080411A3BED
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 23:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgDIV3S (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 17:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgDIV3S (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 17:29:18 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB0620B1F;
        Thu,  9 Apr 2020 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586467757;
        bh=ScDbH132wmevlViehYSb3vPuHS7/Osy+J1p9xXpIiA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w2RqWeUVJ78hOhcm/TJInru4bbWjBYTaBM0fSwPDxNas3PeGhrcp3DeduHq1drjJ+
         /ZNObBWtly5M1z0oxxWLxo6sbB94yEDw3x8tMqs6plwO8JQUBLaepC5RRKCvb0EDPR
         SkDmOehHTmSdsLRf2YigWQWaWadwsZNEsZWlAkvo=
Received: by mail-io1-f49.google.com with SMTP id w20so1126971iob.2;
        Thu, 09 Apr 2020 14:29:17 -0700 (PDT)
X-Gm-Message-State: AGi0PubuvBm6Na5dqscAiiKoDY2Fd3aJrR/UORary0BzyXJhlz7l8QXn
        lLei9hUh5NfuiVuycU3rwO172HTCfw+ef+I7cTg=
X-Google-Smtp-Source: APiQypKWBwnqQybIW4xlFVNQhFjET+Pm794MfxAc7HzWxprhbyIfqYLTa73CdHEguIc+eVUdm26A4hOgp58lmjJKw2Q=
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr1244659iow.171.1586467756995;
 Thu, 09 Apr 2020 14:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com> <20200409201632.GC45598@mit.edu>
In-Reply-To: <20200409201632.GC45598@mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 23:29:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
Message-ID: <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 22:16, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Apr 09, 2020 at 09:04:42PM +0200, Ard Biesheuvel wrote:
> >
> > > I'm currently building Linus's latest branch to see if it's been fixed
> > > since v5.6-11114-g9c94b39560c3 (which is where I first noticed it) and
> > > while I was waiting for v5.6-12349-g87ebc45d2d32 to finish building so
> > > I could test it, I noticed these patches, and so I figured I'd fire
> > > off this quick question.
> > >
> >
> > I think we might be able to downright revert that patch if the
> > underlying assumption on my part is inaccurate, which was that the
> > fact that the boot code no longer uses the runtime table address
> > implies that there is no longer a reason to pass it.
>
> Unfortunately, it doesn't cleanly revert, which is why I started
> checking to see if it might be fixed already before trying to figure
> out how to do a manual revert.  I just tested and the tip of Linus's
> tree still has the failure.
>
> The short description of the failure: I'm using Debian Stable (Buster)
> with a 4.19 distro kernel and kexec-tools 2.0.18 to kexec into the
> kernel under test.  I'm using a Google Compute Engine VM, and the
> actual kexec command is here:
>
> https://github.com/tytso/xfstests-bld/blob/master/kvm-xfstests/test-appliance/files/usr/local/lib/gce-kexec#L146
>
> What happens is that the kexec'ed kernel immediately crashes, at which
> point we drop back into the BIOS, and then it boots the Debain 4.19.0
> distro kernel instead of the kernel to be tested boot.  Since we lose
> the boot command line that was used from the kexec, the gce-xfstests
> image retries the kexec, which fails, and the failing kexec repeats
> until I manually kill the VM.
>
> The bisect fingred v5.6-rc1-59-g0a67361dcdaa ("efi/x86: Remove runtime
> table address from kexec EFI setup data") as the first failing commit.
> Its immediate parent commit, v5.6-rc1-58-g06c0bd93434c works just
> fine.
>
> Is there any further debugging information that would be useful?
>

Does this help at all?

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 781170d36f50..52f8138243df 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -180,6 +180,7 @@ extern void __init
efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);

 struct efi_setup_data {
        u64 fw_vendor;
+       u64 __unused;
        u64 tables;
        u64 smbios;
        u64 reserved[8];
