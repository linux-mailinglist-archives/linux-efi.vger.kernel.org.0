Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8941A1A42CC
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 09:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDJHIN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 03:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgDJHIN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 03:08:13 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FA72166E;
        Fri, 10 Apr 2020 07:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586502493;
        bh=qZUrGgs9MA+6DN+o3ifCTBbl77+DpyVEavu1CJytVio=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ikjF5Wt+mJkvpDJw2jz7w0Pek+ks1rUVUZKSMSQmRIQ46xLgzYpYHcV0nGxZaEKmV
         swT9gK3z3NrodGHSzYoeEuCfWWObccMj4dgjjGzp/au5fgcjcjEWrRrffN0pWsvBRd
         +Tmhbn1YqdBHfX8uvaO7ymN0Fq0szjM7rbL6BHBo=
Received: by mail-io1-f53.google.com with SMTP id n10so923936iom.3;
        Fri, 10 Apr 2020 00:08:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuZwjfqVFfGa/ugDPobzUzNVpVO1xF5YkC+x0XUeC/8WCGl92iKR
        WjFGOfDFyOfYPjV27U/3pTD+zJ4a+Qk+iYSZxt0=
X-Google-Smtp-Source: APiQypK6ZCQ31ZOyfnieUvolvVloPKu2SLyozbl68q7Ih7U3rsPqULWXxtRpIdDq93/HIF3RpPsK/zaS08LRAtfRAzc=
X-Received: by 2002:a02:7785:: with SMTP id g127mr3329097jac.134.1586502492857;
 Fri, 10 Apr 2020 00:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409130434.6736-1-ardb@kernel.org> <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu> <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
In-Reply-To: <20200409235716.GF45598@mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 09:08:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
Message-ID: <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
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

On Fri, 10 Apr 2020 at 01:57, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Apr 09, 2020 at 11:29:06PM +0200, Ard Biesheuvel wrote:
> > > What happens is that the kexec'ed kernel immediately crashes, at which
> > > point we drop back into the BIOS, and then it boots the Debain 4.19.0
> > > distro kernel instead of the kernel to be tested boot.  Since we lose
> > > the boot command line that was used from the kexec, the gce-xfstests
> > > image retries the kexec, which fails, and the failing kexec repeats
> > > until I manually kill the VM.
> >
> > Does this help at all?
> >
> > diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> > index 781170d36f50..52f8138243df 100644
> > --- a/arch/x86/include/asm/efi.h
> > +++ b/arch/x86/include/asm/efi.h
> > @@ -180,6 +180,7 @@ extern void __init
> > efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
> >
> >  struct efi_setup_data {
> >         u64 fw_vendor;
> > +       u64 __unused;
> >         u64 tables;
> >         u64 smbios;
> >         u64 reserved[8];
>
>
> Tested-by: Theodore Ts'o <tytso@mit.edu>
>

OK, I'll spin a proper patch

> Yep, that fixed it.  Thanks!!
>
> I wonder if this structure definition should be moved something like
> arch/x86/include/uapi/asm/efi.h so it's more obvious that the
> structure layout is used externally to the kernel?
>

Well, 95% of the data structures used by EFI are based on the UEFI
spec, so the base assumption is really that we cannot make changes
like these to begin with. But I'll add a DON'T TOUCH comment here in
any case.
