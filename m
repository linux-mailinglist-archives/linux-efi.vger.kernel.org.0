Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC981A3324
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDILZb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 07:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgDILZb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 07:25:31 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3439821655;
        Thu,  9 Apr 2020 11:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586431531;
        bh=pZaCgk4fe9qVDezZmFxHsQI5ERTJ0fxa4TeJSZBvIMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WVv8TH180MosttzZ7CrKsHsa+98uqe9Si2Nn/uy58C3wDVJ2cAyGh2IIHpqmmB4gz
         02uPIp2bCK0k3pZ+QmVBm/VOD0abv1lgFBRsnLLD96VM0AgyOS6uHeNqdsQlmxILtq
         6bJ3lVvFp+jYtV0zqOgXRN9nsQfMfudTI7GdJHHM=
Received: by mail-io1-f41.google.com with SMTP id h6so3405581iok.11;
        Thu, 09 Apr 2020 04:25:31 -0700 (PDT)
X-Gm-Message-State: AGi0PubcGRDMCYLMgJ2TfSmdRU52Fg2ginWLACIDYqEMMcZYSHZt7V4u
        XUmfzLNOkbMI95kN4VCx7JAnOaW+FS+45zy2KOQ=
X-Google-Smtp-Source: APiQypJUNHXZ7kzlhiVsDGZYvX1sItKiakzaHFgIAx5133GDf10QUpQHJoK5litM/tSHaUhi9lwMy04JBweQTmlcUC0=
X-Received: by 2002:a5e:8b47:: with SMTP id z7mr11257862iom.16.1586431530471;
 Thu, 09 Apr 2020 04:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
 <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz> <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
 <b6006dd7-2ce0-0776-9a61-52377b8eef63@suse.cz> <CAMj1kXFsaoUoWbwRVFJX_ze+gJHOKRLyTL5kEecYJRPr84wWqw@mail.gmail.com>
 <CAMj1kXEhLjh4NENkzfKmO=eLxEXmgU7MDyJsL51Ctas5XW40Sw@mail.gmail.com>
In-Reply-To: <CAMj1kXEhLjh4NENkzfKmO=eLxEXmgU7MDyJsL51Ctas5XW40Sw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 13:25:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFJ3WvtTKejKFwY-JKsTBjANdM8+Mae8+Yvfsu15ke+zg@mail.gmail.com>
Message-ID: <CAMj1kXFJ3WvtTKejKFwY-JKsTBjANdM8+Mae8+Yvfsu15ke+zg@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 13:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 9 Apr 2020 at 12:45, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 9 Apr 2020 at 12:09, Jiri Slaby <jslaby@suse.cz> wrote:
> > >
> > > On 09. 04. 20, 11:09, Ard Biesheuvel wrote:
> > > > On Thu, 9 Apr 2020 at 10:36, Jiri Slaby <jslaby@suse.cz> wrote:
> > > >>
> > > >> On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
> > > >>>>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> > > >>>>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> > > >>>>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> > > >>>>>> /usr/share/doc/packages/ovmf
> > > >>>>>> /usr/share/doc/packages/ovmf/README
> > > >>>>>
> > > >>>>> Hmmm, it's weird that OBS doesn't list all derived files.
> > > >>>>> Anyway, the ia32 ovmf is available in
> > > >>>>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
> > > >>>>
> > > >>>> It indeed does:
> > > >>>> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
> > > >>>>
> > > >>>> Note that the ia32 version is noarch, built on i586.
> > > >>>>
> > > >>>
> > > >>> I am not able to reproduce this issue using the linked firmware image
> > > >>> and a 5.6 x86_64_defconfig with efivarfs built in.
> > > >>
> > > >> Yeah, I had to use the distro config too. Not sure what the trigger is.
> > > >> Maybe some NUMA configs or something.
> > > >>
> > > >>> Could anyone share the full log, please, along with the kernel config
> > > >>> that was used?
> > > >>
> > > >> Both uploaded:
> > > >> http://decibel.fi.muni.cz/~xslaby/err/
> > > >>
> > > >
> > > > With the same config, I am still not seeing the issue.
> > > >
> > > >
> > > >> Note that I switched the for-me-necessary =m configs to =y. So that it
> > > >> is enough to build bzImage, w/o modules...
> > > >>
> > > >
> > > > Could you please try running it again with CONFIG_EFI_PGT_DUMP=y enabled?
> > >
> > > No problem:
> > > http://decibel.fi.muni.cz/~xslaby/err/dmesg2.txt
> > >
> > > > In the mean time, I will try to install Tumbleweed from scratch. Do
> > > > you have any steps I could follow to reproduce your setup?
> > >
> > > Not really, just installed TW 64-bit and used efi and grub 32 bit.
> > >
> >
> > OK, so you installed using a 64-bit EFI, and then switched to a 32-bit
> > one? Or is there a special mixed-mode capable installer?
> >
> > (The ones I found are x86_64 only)
>
> OK, I have managed to install tumbleweed into a 64-bit VM with 64-bit GRUB.
>
> Could you give any instructions how to convert to 32-bit GRUB please?

Never mind - I managed to switch. I still don't see the issue though :-(
