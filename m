Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D1224A38
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jul 2020 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgGRJZA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jul 2020 05:25:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGRJY6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jul 2020 05:24:58 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M27ep-1jzBvV1Fv7-002XoW; Sat, 18 Jul 2020 11:24:56 +0200
Received: by mail-qv1-f51.google.com with SMTP id u8so5297215qvj.12;
        Sat, 18 Jul 2020 02:24:56 -0700 (PDT)
X-Gm-Message-State: AOAM5338zgOwqjhuChmHv5e8nSndXd38BMteQ6ZKk+ofITwvGGx8xXDu
        7gIPzRujBH6UqhMPsYZNWJPXJoR38S6MbZ754zM=
X-Google-Smtp-Source: ABdhPJylb3dPfzQat4mnZza6VESrMWsJMNd5HBuOk3P1n07BaEOYyHneqkgGN31SwLj1hOM7gXSsT32wRFFWmYUoWFQ=
X-Received: by 2002:a05:6214:1926:: with SMTP id es6mr12756912qvb.222.1595064295108;
 Sat, 18 Jul 2020 02:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com> <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Jul 2020 11:24:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
Message-ID: <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KADLZTHQdOktTZ7ae+BKf6faC9Hw0ZpX2Zv7GoiPakobjVhmtsX
 3JtolcAGSNKnzcaodszIfBkNX5TE1six4IEDfXIaGP7wpII2ovxejI1g3ZruYyWn/aqoiAk
 EyrLDBmMds5Q8Xy77wk6zJJOiUigt8hYxOHv8k/l0+qqSbX9hVStLPHtihRyXcpAWthez1p
 5nErNmU/9dXE2GDlHJgFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KnC1dKiC7g=:+bz2AX1+KtSlevAQMgK8jU
 xHI0DyeiZEIxVUev/MX2WEP2dbArtVwjolw+Ob8r0C23fb30XnbDqQRCwGkKF9SG+HGG2/cXM
 q3F8jKg5BA37j6ePfHrV0/Xd1YWauG4PT8bxBKcQS2mvsChFsSHn/Wem4ABsbSCEFYNqpVb7z
 yPsghXK6fvlfPj5kzYrmMb7JgIRFL/Ho0WGA8xyeSDPedTUixrq8zLtawL6J3lpBfX/cb0qGe
 AcVfP0sfsvWoOSJv4EcMd8WRO10zF5clrReWa7rr++VvDl84YG6RNzGK82lUfpr7EggHMN8lg
 8jpKT2QiSw0uENfakqE+wJEicaPpDP8cAcPPEss6ka0uSpMEANXa4dr5kvL/jpay/2ul8PMNA
 5dW3uUoZEumsMI5Uy06dnEw03o8nmUQMolrv01+yW0+DasqlzXvc3RAWeDtL/j/rGr4bsVVys
 tDFCJF3+UnA8NeKjR9QNHHACgHwQBlp0UXpQMiCfON1MOtWOf0+NNkR5kBNmHDjO5S5gBQVtI
 ZmK04Bf14xFQx56NRU4hzA+Vr6c4uri36Hf9P9V9xmrIaqpsM4pWIEP28ooQ426HfT27J9RU9
 4Mbr1z2VnLkMO/EEDA6zX/4jKcA0GwwlU19+EuQtxCK3tWr1PiN0oZ9fCsS9qeyejswn/dL62
 yjm2ToODkFM9QdSstCWA76rcvXmMI6+DoAxaYelb9QZsvfv8yjkxiPj2Ye78XLxHW0Mh9nfOI
 lCyvLv3jUBJSDpXb9zNpq1En8BiZ6dEuZb0x1+ZrNWln4SKlARsNQhsxXU8uT8/XigmE8t4VI
 Jyeoh7dAKpfFXPlFEIwtRCN+9EEQ4/PSxCC3hRr6KoyxwmPSnRfuq5ShAumXuiJFPqIV0QjkS
 3/2X5q+8ZWIzMG/IEziFfFrZpY5yw2bJ95+7XgzHo2yENRUZ0LFF96BxCgg/EiYWc75oszov8
 R5Fx/0HGvwRaLpW5frhNGfvL6+reapS+KEj0caQREdhlPeoD4eRpg
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Thu, Jul 16, 2020 at 11:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Jul 17, 2020 at 1:41 AM Atish Patra <atish.patra@wdc.com> wrote:
> > > +#define DTB_EARLY_SIZE         SZ_1M
> > > +static char early_dtb[DTB_EARLY_SIZE] __initdata;
> >
> > Hardcoding the size in .bss seems slightly problematic both for
> > small and for big systems. On machines with very little memory,
> > this can lead to running out of free pages before .initdata gets freed,
> > and it increases the size of the uncompressed vmlinux file by quite
> > a bit.
> >
> > On some systems, the 1MB limit may get too small. While most dtbs
> > would fall into the range between 10KB and 100KB, it can also be
> > much larger than that, e.g. when there are DT properties that include
> > blobs like device firmware that gets loaded into hardware by a kernel
> > driver.
> >
> I was not aware that we can do such things. Is there a current example of that ?

I worked on a product in the distant past where the host firmware
included the ethernet controller firmware as a DT property[1] to get around
restrictions on redistributing the blob in the linux-firmware package.

For the .dts files we distribute with the kernel, that would not make
sense, and I don't know of any current machines that do this in their
system firmware.

> > Is there anything stopping you from parsing the FDT in its original
> > location without the extra copy before it gets unflattened?
>
> That's what the original code was doing. A fixmap entry was added to
> map the original fdt
> location to a virtual so that parse_dtb can be operated on a virtual
> address. But we can't map
> both FDT & early ioremap within a single PMD region( 2MB ). That's why
> we removed the DT
> mapping from the fixmap to .bss section. The other alternate option is
> to increase the fixmap space to 4MB which seems more fragile.

Could the original location just be part of the regular linear mapping of all
RAM? I'm not too familiar with the early mapping code myself, so it may not
be possible, but that would be the most logical place where I'd put it.

        Arnd

[1] drivers/net/ethernet/toshiba/spider_net.c
