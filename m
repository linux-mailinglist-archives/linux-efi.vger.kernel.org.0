Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EF1219C4E
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgGIJar (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 05:30:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgGIJar (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 05:30:47 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N1PLB-1kukYx37et-012nFH; Thu, 09 Jul 2020 11:30:44 +0200
Received: by mail-qt1-f180.google.com with SMTP id o38so1141868qtf.6;
        Thu, 09 Jul 2020 02:30:44 -0700 (PDT)
X-Gm-Message-State: AOAM533iGCYVcsfLjfbLQ+hhH0hRC2iv0+NWTa+MtIg5LCFhi3og8f0O
        GbZDZSTJ4PiBa3B11XgDyLneCer+nyn226KYyyY=
X-Google-Smtp-Source: ABdhPJya8KYSjP4Vpazo2pyPOtp1xixDd/LrBpy7KWM87TVOcxWC9KZT2AhHFlbVXr6XdAAgrM3BYamH6NXqKGbmOGs=
X-Received: by 2002:ac8:4507:: with SMTP id q7mr63620552qtn.142.1594287043518;
 Thu, 09 Jul 2020 02:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com> <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net> <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
In-Reply-To: <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Jul 2020 11:30:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
Message-ID: <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gf6Do5RSBjDjAUrRhYphUARohS0MGye5iw38Wi20Q7K2qIlDRP+
 nAtuzPHSIWVTJJh+Y9XzbrQ8HUsjk0g+0VrrWwtlYKkk/u6VDC8dDz/567uerK+/GrHsinM
 nL2hlzEktiiOeAgjU/1FQUXfA4yXOpEjtYeGNUQ8lmpcPjZz+ucjQAY2G9jO5jlMrtLdyW4
 pbyg1MF8u9pLnRktzZOIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:30W8Tdkdp4U=:vv8aO2cKSp5Sm58Sw5kbJS
 epZWaWDnKpWamfcZ2cgP3VjylRAcvbfwdbiX5+12CbiA/ueKzMPMKdVTY43d6Mn5srjfqE1HQ
 x5sjcVN7uHeZ9+oMCeBW7eZlfiR66ZXJYZda2MvSCCy2RWTqRy35jDr93g4VvDYZmssAF3cbk
 uwW84mrcR+tDVIicZs8XDnM2HbLkbFNNBf5hq2qRTw2Msq78PLYeEAhkboEf6jIZGM3VLjyWc
 wxf1raheuYgMWzeKj/xZWPvMdsOGzlHKlQ0GMxW9z7wtmj2DdcGN2zPRMtRSt8fRe17MFeh0l
 ZzMRX6Bc5Q9VXPDwAtnRGTwSJH/dhEGdzuABy8NMdMVru7xjZzvESCkHWQaouov4PEe5Vt6pw
 pJxsCHIakhA36eaQOcecEUmPe7pq3kTzmo0e4k9dXKclPxcpGoNrMycZOMB4ttCXJFaKw19gS
 ADiy2dCwPcqgTyZGUTfMk0IeyBl+CkAuJoMcZbLo5H2Dg6zhQR24iStC7s4uIUHmrxX0/YsyL
 rQPFc2mqsh2G6OBLctad/PQBNLdS2KhC5ZoQf37k674BtpCouNLBH4B4nf2A7tkUyic0PqTXT
 57KqPNUWujlJoftytHO5Mkx9s8n5DdwheSUszCioek5VlkLIcGPpgdlePpKSSmmParu0sKlZE
 pDezrveeuX266eXPTJyPjaLi8d08ipeZJA9p3FGoM/4br6xXASsocEdU6VCYhmk6pZU+lz3/t
 oHiJgzntNxDd0vbfxGUn9caV9bIaA6CZziWtvpUCeLPNnZYJfwHn/+RK71HICmIaVA8yynK0X
 KtoACepfSvNWIhehmMaSwkK3OfPF8ijgybLK1CPWfhVyThvGHPybAhxrA9hxAnZ97B4t4Kp
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 8, 2020 at 8:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jul 8, 2020 at 9:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > It's perhaps yet another reason to just skip gcc-4.8 too, since
> > > apparently 4.9 works.
> > >
> > > gcc-4.9 really has a lot of advantages. It's where (I think) gcc
> > > basically supports all C11 things, including _Generic() but also
> > > __auto_type.
> >
> > +1
> >
> > Anybody for nay, or should we just do this?
>
> I'll just do it. Let's see if anybody screams with a good reason. I
> hate the whole "support old compilers", it ends up not only making for
> complex code, it tends to cause these unnecessary kinds of "guys, we
> tested this really well, but that crazy compiler had a very particular
> odd issue, and it wasn't in any test box.

Cool, thanks for changing it, this is clearly a better suited compiler
version. Aside from the added C11 features, this is also where a lot of
the optimizations changed, so code generation is more predictable
if we don't need to worry about gcc-4.8.

On the flip side, gcc-4.8 was used by old enterprise distros that
are still supported (SUSE 12, RHEL 7), whereas gcc-4.9 was only
shipped in Debian Jessie and Android releases that are both
EOL now (Android never moved beyond a buggy gcc-4.9 prerelease
but now uses clang for everything).

I don't see any technical reasons to go even further, but if
something does come up, the users of these Long-term supported
distros would be most impacted by a change:

gcc-4.9: Used in Debian 8 (Jessie), EOL June 2020
gcc-5: Used in Ubuntu 16.04 (Xenial, Mint 18, ...), EOL April 2021
gcc-6: Used in Debian 9 (Stretch), EOL 2022
gcc-7: Used in SLES 15, Ubuntu 18.04 (Bionic, Mint 19, ...)
gcc-8: Used in RHEL-8 (centos, oracle, ...), OpenWRT

The most interesting version to require in the future would be
gcc-7, which IIRC is the point at which we can just use -std=gnu99
or -std=gnu11 instead of -std=gnu89 without running into the
problem with compound literals[1].

       Arnd

[1] https://patchwork.kernel.org/patch/11195831/
