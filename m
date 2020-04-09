Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867831A3215
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIJpP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 05:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIJpP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 05:45:15 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C855E214D8;
        Thu,  9 Apr 2020 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586425514;
        bh=A5ttw0wxiG440jjRYkFi9rF7N++NdUJK1VjeW4v3ff8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z/aNYOEskI02i3kV8H6MN7za7LVank8U2o2tYU8YcETBlzAWs4C7ojNrbZ1xig3xN
         6e68iiI15dDlfc6dVwiDXfb2INj+BxMJIRKNUFXPLS1eLACrogF/I7VF5cWUnJi4Pz
         qldO0c18PlAnvcaKs/O1mMZKvWvnsNsOvkC34s/M=
Received: by mail-io1-f52.google.com with SMTP id b12so3185395ion.8;
        Thu, 09 Apr 2020 02:45:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuYLUZere7WF/zYFZlg3bIqRfoWKQj/aaPWn9nDsciS/lG7uLTrg
        ZrMTTQvdfcj3vQt6dPbmIPox/P6Dsk1Fd1FazZE=
X-Google-Smtp-Source: APiQypKYlj97ebVeCKMbb/G38jXlGKLN2lQo+owDPErNhcVXNc3z3B626baI93YbEqM6CsakelBElxB1zRGYlduAMz4=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr11156147iot.161.1586425514263;
 Thu, 09 Apr 2020 02:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
 <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz> <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
In-Reply-To: <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 11:45:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFBoM03po-nmi+BWXOh6RQRNPmpkxnNFe-bf2bsVNW4Cg@mail.gmail.com>
Message-ID: <CAMj1kXFBoM03po-nmi+BWXOh6RQRNPmpkxnNFe-bf2bsVNW4Cg@mail.gmail.com>
Subject: Re: [PATCH 05/13] efi/x86: don't map the entire kernel text RW for
 mixed mode
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Gary Lin <glin@suse.com>, linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 9 Apr 2020 at 11:09, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 9 Apr 2020 at 10:36, Jiri Slaby <jslaby@suse.cz> wrote:
> >
> > On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
> > >>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> > >>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> > >>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> > >>>> /usr/share/doc/packages/ovmf
> > >>>> /usr/share/doc/packages/ovmf/README
> > >>>
> > >>> Hmmm, it's weird that OBS doesn't list all derived files.
> > >>> Anyway, the ia32 ovmf is available in
> > >>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
> > >>
> > >> It indeed does:
> > >> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
> > >>
> > >> Note that the ia32 version is noarch, built on i586.
> > >>
> > >
> > > I am not able to reproduce this issue using the linked firmware image
> > > and a 5.6 x86_64_defconfig with efivarfs built in.
> >
> > Yeah, I had to use the distro config too. Not sure what the trigger is.
> > Maybe some NUMA configs or something.
> >
> > > Could anyone share the full log, please, along with the kernel config
> > > that was used?
> >
> > Both uploaded:
> > http://decibel.fi.muni.cz/~xslaby/err/
> >
>
> With the same config, I am still not seeing the issue.
>
>
> > Note that I switched the for-me-necessary =m configs to =y. So that it
> > is enough to build bzImage, w/o modules...
> >
>
> Could you please try running it again with CONFIG_EFI_PGT_DUMP=y enabled?
>
> In the mean time, I will try to install Tumbleweed from scratch. Do
> you have any steps I could follow to reproduce your setup?
>

The faulting code decodes to

  2a:* 89 03                mov    %eax,(%ebx) <-- trapping instruction
  2c: be 05 00 00 80        mov    $0x80000005,%esi
  31: a1 74 63 31 3d        mov    0x3d316374,%eax
  36: 83 c0 48              add    $0x48,%eax
  39: e8 44 d2 ff ff        call   0xffffd282
  3e: eb 05                 jmp    0x45

which looks suspiciously like

MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c-2390-  } else {
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c-2391-
*DataSize = VarDataSize;
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c:2392:    Status
= EFI_BUFFER_TOO_SMALL;
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c-2393-    goto Done;
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c-2394-  }

in EDK2, so it seems like the GetVariable() is being called with a
datasize pointer that resides in r/o memory

It would be very helpful if we could get the memory dump that
CONFIG_EFI_PGT_DUMP=y provides, as well as some idea of the call stack
that performs get GetVariable() call at this point. The mixed mode
code just passes the address it gets, but it does translate it to a
physical address, which means it accesses the memory via a different
mapping.
