Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C65227B4B
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jul 2020 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGUI5p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jul 2020 04:57:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGUI5o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jul 2020 04:57:44 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N7Qt9-1kuHVr214H-017pto; Tue, 21 Jul 2020 10:57:42 +0200
Received: by mail-qt1-f170.google.com with SMTP id s23so2436405qtq.12;
        Tue, 21 Jul 2020 01:57:42 -0700 (PDT)
X-Gm-Message-State: AOAM532tb1orIsiCr6BC4WdLdFPDw97jVaqwkB5CT/3HQlGdENXQU+iM
        MmWeYWK/uP60V8cPV3srGyp1mjsLtKslYb2lVCw=
X-Google-Smtp-Source: ABdhPJzH4+6GvIyScoWZX14qfgZTea78AfBKB9wNJLXGQJDMUWXul6IY9ixoNgyrTeiEbnBgWhMjSyrj9u9KINMqP1I=
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr27467703qtv.18.1595321861275;
 Tue, 21 Jul 2020 01:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
 <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
 <CAOnJCUKF-tfN-fHyRcjyAMnYVzQqp=_CLa2F4TQNO7jA4infoQ@mail.gmail.com>
 <CAK8P3a3iUdoOZrORz+aeXYiO35Lp8snrCkxSUPAY6Fh2EinaOw@mail.gmail.com> <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com>
In-Reply-To: <CAOnJCUL2X9mK41iHLCg1_rtj7JS4p41hqXfmd=hyxK=2t5QQog@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jul 2020 10:57:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3e3SBtTocpkCybKRjkBJG26G-8YdiroJbZLZYq9f0yfw@mail.gmail.com>
Message-ID: <CAK8P3a3e3SBtTocpkCybKRjkBJG26G-8YdiroJbZLZYq9f0yfw@mail.gmail.com>
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
X-Provags-ID: V03:K1:1ABNl54a5UCI+4ZNMYFht6ehM8yPzb33aIUKsYUtej0+aFoQUss
 9WNIuMojR1Kn3WCLrrtUQgO3vJ0FUiY1ZfDrWFsAOgePrBFxePCSuO/0nrwqAPI9zWwZi5Y
 2onlrXdxsH8kOXVH2YEgPrNxLAO5XeprxhwOla2BeRAAWo2XhhROkMmNOgQTYu3zZZC1seu
 7/d2N8Tu/BkPZxJmuoJkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:77Hf8qhTi0Q=:EWtUkseO8iC0woJ2xan+qj
 BlU3FxBFtLdEJfVGyyR9DzJvf9+OoMkkRVby8hVprxYobrm58XKR541FOjdKy2sPZGoinLoal
 3g8BF2qMRVR6+wT+VMTZKsMXgXXDrScrKvzn4zdYZhrsS8y2HURtVHWTErGbrIEMt5T8dBn6/
 J29rARuntsoBm2TDJ6UueG+SJCXnYd2O8tAB6WK+8e3sy8LB7yn3kNA0mmq0aj11rl0dFs/xr
 R5FZ3ZoGn56ZseTze0Qf+8C/x5mp+LTY5hAnWobvXFVbqY0qAnICy4y1KXEPjWSfANGyyG54K
 quyj5xgYZVuu5mOZauKpH+oRYA64cd4YiYPd5dtKZHB9UoJ9+eOerdzZix6aCssz7/0Qmi276
 FcpYYalrU3GHWI5GXNoHf+rjY4hti3KNsrIgwhotV3krtyKRcjMuZLXrutlLgocx6N7Ga7gGl
 malBTkr+4DA5raeSYOpwrKHG7TxR60oT/95fAbemdSh33ix1tibH88YsmeIee6LDka1kKeKJT
 GJfCmODBTXL7ESZf2DsvXvbSXzZbN0ZjNQLIfM2TwNl8/eMeWtGFDii400URV3BCSnR1dYLGq
 l6bYA0B3wCKB1whDPsmQ2vGJLwQ/N1AZx0CV7lbRZt734Tcu9rsiH5wbPFmnMQalnHqN+O5Rw
 NGzpEW1Nic3MOZCExIdZYWgRoFDsyG5ybKnrXk5crwEaPoM05/TICURyd133MSWEQObQBapZH
 yFLc+xv/QOcOXPT7z2Z09M9yxJs4ssNEcVjXJp1K4sXfsrcnTdsgD2HttqaNUjQA4ngM5+TFA
 awAnoxxvAdoJZ6f2U2HfgAUtFd3CJXfLlRETp87cxCUyiIjx2P66JDDqSdJ/KsxpNhDxBRi7F
 gNtR/kPEt2xmj8hOJjmkDQPZxF/9Dl8h8pu8LvivmfBdTc97KJZF0+fhx+jJE59/Fe6EPnlAy
 Zv7gUiTlj9ZnOVph+HH2VKdC+C0m8qrb5yZLaU1LShNa1RhKPNnlt
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 21, 2020 at 6:18 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Sat, Jul 18, 2020 at 2:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jul 18, 2020 at 3:05 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > That's what the original code was doing. A fixmap entry was added to
> > > map the original fdt
> > > location to a virtual so that parse_dtb can be operated on a virtual
> > > address. But we can't map
> > > both FDT & early ioremap within a single PMD region( 2MB ). That's why
> > > we removed the DT
> > > mapping from the fixmap to .bss section. The other alternate option is
> > > to increase the fixmap space to 4MB which seems more fragile.
> >
> > Could the original location just be part of the regular linear mapping of all
> > RAM?
>
> No. Because we don't map the entire RAM until setup_vm_final().
> We need to parse DT before setup_vm_final() to get the memblocks and
> reserved memory regions.

Ok, I see how you create a direct mapping for the kernel image, plus
the fixmap for the dtb in setup_vm(), and how moving the dtb into the
kernel image simplifies that.

I'm still wondering why you can't do the same kind of PGD mapping
for the dtb that you do for the vmlinux, creating linear page table
entries exactly for the location that holds the dtb, from dtb_pa to
dtb_pa+((struct fdt_header*)dtb_pa)->totalsize.

      Arnd
