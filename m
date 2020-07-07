Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC42216698
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jul 2020 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGGGlk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jul 2020 02:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgGGGlk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Jul 2020 02:41:40 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B0F206F6;
        Tue,  7 Jul 2020 06:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594104099;
        bh=RJd5gU31yiOjajLt/tJJ7V/CSWnm1xiLjteER4WNP0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tONDhxf0QBJIM3f4VpihR47KunOjYPZ2jhFLTiV/wO/aflKiNmzVw6hAhqO8R/uIz
         Xlm1CiyD2g7ETZ5vfugzQD0D7Oy2DpcUXhX7bI7e6GzcAmTReWVA6Yr/NMj2N3HKdr
         VlWXtkBAG8D1E2VzGhNobzBmSCqlD2Qa9oJHvwB8=
Received: by mail-ot1-f44.google.com with SMTP id 5so31526784oty.11;
        Mon, 06 Jul 2020 23:41:39 -0700 (PDT)
X-Gm-Message-State: AOAM531Ot67Xdx01O/LKjA+Fc09UoQPCxjpQxtj8o4sMs+0wIFq0r0xF
        dwbl8Kblq/eR6oS870Bj3UlHEfm61TiAoN5Qg0w=
X-Google-Smtp-Source: ABdhPJwhDbsC77VdApD0Yu5jlF0o1Fbg6FB0JcBCaZr0l4MwXzKW782eArC4YsN/3RFShEqWA4n7wSNLntLdwVfHkGM=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr47348216otf.77.1594104098794;
 Mon, 06 Jul 2020 23:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200706172609.25965-1-atish.patra@wdc.com>
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jul 2020 09:41:27 +0300
X-Gmail-Original-Message-ID: <CAMj1kXG5OxRod_-Z5K55XLXDda2ahfezm0yaRbv=82JmrFRZxw@mail.gmail.com>
Message-ID: <CAMj1kXG5OxRod_-Z5K55XLXDda2ahfezm0yaRbv=82JmrFRZxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Add UEFI support for RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 6 Jul 2020 at 20:26, Atish Patra <atish.patra@wdc.com> wrote:
>
> This series adds UEFI support for RISC-V.
>
> Linux kernel: 5.8-rc4
> U-Boot: master
> OpenSBI: master
>
> Patch 1-6 are preparatory patches that fixes some of the geric efi and riscv issues.
>
> Patch 7-9 adds the efi stub support for RISC-V which was reviewed few months back.
> https://www.spinics.net/lists/linux-efi/msg19144.html
>
> Patch 10 just renames arm-init code so that it can be used across different
> architectures. Patch 11 adds the runtime services for RISC-V.
>
> The patches can also be found in following git repo.
> https://github.com/atishp04/linux/tree/uefi_riscv_5.9_v2
>
> The patches have been verified on Qemu using bootefi command in U-Boot for both
> RV32 and RV64.
>
> For RV32, maximum allocated memory should be 1G as RISC-V kernel can not map
> beyond 1G of physical memory for RV32.
>
> EDK2 can boot quite far into Linux with current series. Currently, we are seeing
> some traps from drivers (spi/network). At first glance, they don't seem to be
> caused by efi. I thought it is better to get some early feedback on the series
> while EDK2 issue is being debugged.
>
> That's why uefi runtime services are not actually well tested in RISC-V.
> Any suggestions to test the efi run time services are appreciated.
>
> Changes from v1->v2:
> 1. Removed patch 1 as it is already taken into efi-tree.
> 2. Fixed compilation issues with patch 9.
> 3. Moved few function prototype declaration to header file to keep kbuild happy.
>
> Changes from previous version:
> 1. Added full ioremap support.
> 2. Added efi runtime services support.
> 3. Fixes mm issues
>

Hi Atish,

This all looks reasonable to me, so I think we can merge this once you
can confirm that the runtime services actually work.

Could you explain how you are dealing with the memory map? Are memory
nodes in DT ignored entirely as they should be? What about memory
reservations?

In any case, I will take the first patch as a fix, so it should turn
up in mainline in 1~2 weeks.

Thanks,
Ard.
