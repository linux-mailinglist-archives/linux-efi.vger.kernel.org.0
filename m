Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD41A32C4
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDIKp7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 06:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgDIKp6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Apr 2020 06:45:58 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94D1021473;
        Thu,  9 Apr 2020 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586429158;
        bh=2sApeTj49jEgM0EIBBiKjWdk0CL0Z8Nfx1A+M++tSp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g3CKIqBoso44Q5ajMRvQONnNDDJBHJXGv+zjNFeBARBgPA544ypF2VkraZzIeiIc3
         D7xEZsyYLTPn+FU+r8M6l6E0ocpshCB28aUmhTLnOL0YUZW5tAXiD64Jo+uDKft2UV
         3zi5XVcds8d8appO2pbzwdK5RptaZF87/MezVJco=
Received: by mail-io1-f44.google.com with SMTP id y17so3323860iow.9;
        Thu, 09 Apr 2020 03:45:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuYhTwHuCZlh04bdRTH24SCwAJeYr6H44avzPZhiHjDfY9nIpY0b
        ztO/qIlpCzOhiDo8YjTYJiX/qIY6B4gdy6Z3zxA=
X-Google-Smtp-Source: APiQypLZXSP9OLEawh2kPzU7n5CwbnEHLFiJwNvhkkyeNMLGtRypdtoHpl9suvWk1e2Zkevx4iuWD6RTyO9WRxwTVCc=
X-Received: by 2002:a5e:8b47:: with SMTP id z7mr11130047iom.16.1586429157928;
 Thu, 09 Apr 2020 03:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200113172245.27925-1-ardb@kernel.org> <20200113172245.27925-6-ardb@kernel.org>
 <63b125a4-6c62-fcdf-de22-d3bebe2dcbf5@suse.cz> <CAMj1kXGiT_zYjc6X-msRXVozhpDAY0UesEW3_4fOgiH4FyMgDw@mail.gmail.com>
 <972b66a9-92c7-9a15-1aa1-e3236abe90df@suse.cz> <CAMj1kXFGkOM9fbqr44_TbdxqFjH1i3d8dkO64C1mQmH=AqrUSQ@mail.gmail.com>
 <20200409080626.GV5951@GaryWorkstation> <984a2b3c-a9d4-e733-6372-4abf0f99be1f@suse.cz>
 <CAMj1kXFHUusU9dDgqhU_qswDVgYWx_kpaDEroj4ZSt3hr-AFsA@mail.gmail.com>
 <d38fd829-b944-da10-58c0-180f80e8264d@suse.cz> <CAMj1kXG4F+WzJX8_FyRAxQmDwqvbQMzh3Ji1KcpH_eO3Zt3-WQ@mail.gmail.com>
 <b6006dd7-2ce0-0776-9a61-52377b8eef63@suse.cz>
In-Reply-To: <b6006dd7-2ce0-0776-9a61-52377b8eef63@suse.cz>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 9 Apr 2020 12:45:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFsaoUoWbwRVFJX_ze+gJHOKRLyTL5kEecYJRPr84wWqw@mail.gmail.com>
Message-ID: <CAMj1kXFsaoUoWbwRVFJX_ze+gJHOKRLyTL5kEecYJRPr84wWqw@mail.gmail.com>
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

On Thu, 9 Apr 2020 at 12:09, Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 09. 04. 20, 11:09, Ard Biesheuvel wrote:
> > On Thu, 9 Apr 2020 at 10:36, Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> On 09. 04. 20, 10:19, Ard Biesheuvel wrote:
> >>>>>> $ rpm -qlp ~/Downloads/ovmf-202002-1.1.i586.rpm
> >>>>>> warning: /home/ardbie01/Downloads/ovmf-202002-1.1.i586.rpm: Header V3
> >>>>>> RSA/SHA256 Signature, key ID 3dbdc284: NOKEY
> >>>>>> /usr/share/doc/packages/ovmf
> >>>>>> /usr/share/doc/packages/ovmf/README
> >>>>>
> >>>>> Hmmm, it's weird that OBS doesn't list all derived files.
> >>>>> Anyway, the ia32 ovmf is available in
> >>>>> http://download.opensuse.org/tumbleweed/repo/oss/noarch/qemu-ovmf-ia32-202002-1.1.noarch.rpm
> >>>>
> >>>> It indeed does:
> >>>> https://build.opensuse.org/package/binaries/openSUSE:Factory/ovmf/standard
> >>>>
> >>>> Note that the ia32 version is noarch, built on i586.
> >>>>
> >>>
> >>> I am not able to reproduce this issue using the linked firmware image
> >>> and a 5.6 x86_64_defconfig with efivarfs built in.
> >>
> >> Yeah, I had to use the distro config too. Not sure what the trigger is.
> >> Maybe some NUMA configs or something.
> >>
> >>> Could anyone share the full log, please, along with the kernel config
> >>> that was used?
> >>
> >> Both uploaded:
> >> http://decibel.fi.muni.cz/~xslaby/err/
> >>
> >
> > With the same config, I am still not seeing the issue.
> >
> >
> >> Note that I switched the for-me-necessary =m configs to =y. So that it
> >> is enough to build bzImage, w/o modules...
> >>
> >
> > Could you please try running it again with CONFIG_EFI_PGT_DUMP=y enabled?
>
> No problem:
> http://decibel.fi.muni.cz/~xslaby/err/dmesg2.txt
>
> > In the mean time, I will try to install Tumbleweed from scratch. Do
> > you have any steps I could follow to reproduce your setup?
>
> Not really, just installed TW 64-bit and used efi and grub 32 bit.
>

OK, so you installed using a 64-bit EFI, and then switched to a 32-bit
one? Or is there a special mixed-mode capable installer?

(The ones I found are x86_64 only)
