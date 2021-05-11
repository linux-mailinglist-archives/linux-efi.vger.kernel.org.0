Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8F37B151
	for <lists+linux-efi@lfdr.de>; Wed, 12 May 2021 00:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEKWII (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 May 2021 18:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhEKWIH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 11 May 2021 18:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC9D0616EA;
        Tue, 11 May 2021 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620770820;
        bh=VqXQJ3bvlOwIHMtxFA0B6zkp90401MM2U+HgMCcnldw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PF/0OclrsY78SxKAdd/IFRhyMLoT+9uHWOWCTYK0/ZRvTPoumVcfsbxVLtyAFFqYb
         MsI+q4ugqK8yHypA9r0TgVahyE6QulWg5Gm9wqDW2W4o+YR3D9qVU+JjirABnBIeyG
         obUG63V3qbIZIFJQqbC3j61c7+YeBYw1ivNsRMduUeze/RcBwE13VzNpH/xY5pPStx
         HXhHjeaoLDldisHwgggn/lqCvX5UYAnPo/D0QsDdy2zhyV5Ovnc+z0W/gFjp19GIyH
         NaE7Gjg3mX+7Dl27eP5dUyU2Pwptos+ppJ+SPhbBNA3Z1meUBs53rXvd2lq+dCk0wI
         uWwjxaqTUkE9g==
Received: by mail-ot1-f53.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so8680965otg.2;
        Tue, 11 May 2021 15:07:00 -0700 (PDT)
X-Gm-Message-State: AOAM532ehy/x6wwsYEJJBw4sCEJ92hqt3Bq6lT0pXTl/AeXk0n1bBRCj
        Z7cPBXYv4k0orER71cs13RefN26pxB9NkR3wut4=
X-Google-Smtp-Source: ABdhPJzsqvaOtbjaKcWWaTisW6Ae9QjWZOqqWUxE/uaTDn7ou3mvOJLvt94IBW1BlmHqkGDU+pjdFuA5gVnCoWstcU8=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr27807293otd.77.1620770819934;
 Tue, 11 May 2021 15:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <b075e45e-365a-dafb-503c-615c41168b0d@molgen.mpg.de> <706be699-7f79-391c-bbac-a4b3820511d8@molgen.mpg.de>
In-Reply-To: <706be699-7f79-391c-bbac-a4b3820511d8@molgen.mpg.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 May 2021 00:06:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFoEU-ZA9=QunkBM+i1rOLnNnruo8OLF-aAjO3k8GFJtg@mail.gmail.com>
Message-ID: <CAMj1kXFoEU-ZA9=QunkBM+i1rOLnNnruo8OLF-aAjO3k8GFJtg@mail.gmail.com>
Subject: Re: efivarfs fails with `No such device` when EFI runtime is missing
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 11 May 2021 at 22:58, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Use Ard=E2=80=99s current email, and add other maintainers]
>
> Am 11.05.21 um 22:55 schrieb Paul Menzel:
> > Dear Linux folks,
> >
> >
> > I migrated a 32-bit GNU/Linux installation from BIOS to EFI. Trying to
> > edit the entries in UEFI=E2=80=99s Boot Manager with `efibootmgr`, I go=
t the error:
> >
> >     EFI variables are not supported on this system
> >
> > `sudo modprobe efivarfs` fails with
> >
> >     No such device
> >
> > After several tries, I found
> >
> >     [    0.000000] efi: No EFI runtime due to 32/64-bit mismatch with
> > kernel
> >
> > logged by Linux, and then I found the Stack Overflow thread *How could
> > 32bit kernel read efivars from 64bit UEFI?* [1].
> >
> > I would have thought, setting EFI variables is just directly writing to
> > some storage. But probably not.
> >
> > Could the error message for the efivarfs load failure be improved, that
> > *device* means the runtime service (if I am not mistaken)?
> >

Not sure what you are asking for here. The efivarfs module fails with
-ENODEV if EFI runtime services are not supported by the kernel (for
whatever reason), and it is actually modprobe in user space that
prints glibc's default error string for ENODEV.

What we could do is print something to the kernel log when this
situation occurs, in addition to the current behavior of modprobe,
which is difficult to change.

Patches welcome.
