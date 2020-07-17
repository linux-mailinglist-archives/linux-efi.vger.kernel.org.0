Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1609222349B
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQGcc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jul 2020 02:32:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQGcc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jul 2020 02:32:32 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mj8a5-1kS5lL2xyn-00f99n; Fri, 17 Jul 2020 08:32:30 +0200
Received: by mail-qt1-f175.google.com with SMTP id w27so6864166qtb.7;
        Thu, 16 Jul 2020 23:32:30 -0700 (PDT)
X-Gm-Message-State: AOAM533kYu3TQTcO99/jOt/vc99YNFqP3UcqU1clYoefE8ct1nHVd3R5
        wnruFfPcm6T+SbD1wNfFMfOuaRN8ioV+2plEJho=
X-Google-Smtp-Source: ABdhPJyIrO2tNL5pNeYwr+F4lkpDFfuG2l4JzP4UiWOMuiMb/Y+pJ5JATQyrKH/OqOT80hdzcJy8yYsZ1YnAf3q0N6k=
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr8943304qtb.204.1594967549456;
 Thu, 16 Jul 2020 23:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200716234104.29049-1-atish.patra@wdc.com> <20200716234104.29049-2-atish.patra@wdc.com>
In-Reply-To: <20200716234104.29049-2-atish.patra@wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jul 2020 08:32:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
Message-ID: <CAK8P3a2EesjQAs-YGrCO=cYfUVWFQ3CbJfVXJx3qZjCS_XW+wA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 1/9] RISC-V: Move DT mapping outof fixmap
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zFGPvMwMNJCI4UkgWmgHsAIxbEItY1XE/2RYkSx0Rf/nPVgkQet
 PeslIu0TxUVBt74msw23dSdmv3cOcXn482BDY94bkLjlrRspnqn8vAhbacKi0v+OwuNQA1I
 Ixdb2qygAWDIvo6csTkBLGHr0E3GQeH9UZHEIDkckRiFTffIV2lOcK8yx1qb/WYLprDL8en
 z2oD17NUmH2peQMRIyvdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2eRsSsrUiqA=:GoMH2Ql4SXI4vdiUJFU+4X
 TygvyZRIsmtveC50n1k9ScS4gcursFRukhJQ/uZrCo+S5RdcKNuSyMvV6hw5Rtn8VrA2rONz5
 1rem5XofWtf0VBH945R2g6VRJOvfUTaG+tmKGGvDW+lPpPjzFIGqPwV01n5xwr+ZFihPVuqWD
 VRT3gJV1RiQqoOqOyxLQciTauNek+hy/YAX3BL23VfMuNB6NuPR69BJrcD0aMuiCHkufBwMKw
 fqZSkuGmye4cj9BqtMd95RQRycnVdW+2mX6nyR6VVLbQylKiit8VengOHECajdui1ln4TBZp3
 MH4as4a2AjYc2y8P3XabygOp+K0EhQjQB/WQaoSNBKsaMz8/g4nZtYrdgPxLqc0RJHncY1dqW
 Rwj0XcVnzpPnn3OBMxSK9j0XXp6HfVhC+mwAVZBhgGHQUIKZNO4Py258o4/mcMpUAdVhKeC5y
 /+YIQph654/QPfhF7aIFN0f34BDhJVTb1HtEuUNrfDi04yFkS4ZbXfS58UDWMGi2hQgOQm1Lp
 SmfaOALZyOo1SKVLDVJ/msyjJAFfWSJQJwDwK8MjYZrytJXhc1VyY4d08Lhb3LSd5OmKhiEbH
 fpGs6+fluaRxCy8k6/GLmelM+2ivJgafyi+lL35ZD9Ga7l2EiHUJm0BEj/MggBwf+G6DPoTw7
 L8UHMR4xUqec9Vvj8QKSIE52yzgA2cOtHPM/NKhBcFK08Nl0KyPWg1EwWMRTCh8OujNASQxaQ
 W1JWLNo4QkmVDUiC8qn4XSF2g5xTd+VbqYH/h+mUQ2xNaj4gwn3lRO9w2GuuV77YfOPVpvgmR
 8EG3gWRzbN8kATDthJ2voSQzofRWKET3YYCAYgq9tNyUUCkhD3NzgMAry0HnM+iPMhvykE3
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 17, 2020 at 1:41 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
> it maps only single PMD (2MB) space for fixmap which leaves only < 1MB space
> left for other kernel features such as early ioremap which requires fixmap
> as well. The fixmap size can be increased by another 2MB but it brings
> additional complexity and changes the virtual memory layout as well.
> If we require some additional feature requiring fixmap again, it has to be
> moved again.
>
> Technically, DT doesn't need a fixmap as the memory occupied by the DT is
> only used during boot. Thus, init memory section can be used for the same
> purpose as well. This simplifies fixmap implementation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

The patch seems fine for the moment, but I have one concern for the
long run:

> +#define DTB_EARLY_SIZE         SZ_1M
> +static char early_dtb[DTB_EARLY_SIZE] __initdata;

Hardcoding the size in .bss seems slightly problematic both for
small and for big systems. On machines with very little memory,
this can lead to running out of free pages before .initdata gets freed,
and it increases the size of the uncompressed vmlinux file by quite
a bit.

On some systems, the 1MB limit may get too small. While most dtbs
would fall into the range between 10KB and 100KB, it can also be
much larger than that, e.g. when there are DT properties that include
blobs like device firmware that gets loaded into hardware by a kernel
driver.

Is there anything stopping you from parsing the FDT in its original
location without the extra copy before it gets unflattened?

       Arnd
