Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192B1B72AE
	for <lists+linux-efi@lfdr.de>; Fri, 24 Apr 2020 13:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDXLIq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Apr 2020 07:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgDXLIq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 24 Apr 2020 07:08:46 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A9020736
        for <linux-efi@vger.kernel.org>; Fri, 24 Apr 2020 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587726525;
        bh=MnUmGYZCMAXrwd9Wl8Sg0pLyPh749CA1ljHIriACt2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jnj5SANoBUUeCorqverdDXBjg8t7ipcS+zXEo3s1XcduJGjFq+j2TTNd7Apqwivbc
         btfinDDDCWuikp/WDLyZnC6TvgyJCrKDpqtVMRmwcZxM24IdU88/kdfCIYQ3jcz2Rh
         pq5wWGZOyJiQXLZB9+58rSy9T5zm27Nfiermab9o=
Received: by mail-io1-f51.google.com with SMTP id w4so9894514ioc.6
        for <linux-efi@vger.kernel.org>; Fri, 24 Apr 2020 04:08:45 -0700 (PDT)
X-Gm-Message-State: AGi0PuY6airAoTdomz0tfp008WTi+HP7Wu/+sgh2+xm4NBKifu2Po4ru
        RsUGGZUxVWQyoSJpLafh7f3GuK89LpIWx/tSqW4=
X-Google-Smtp-Source: APiQypIUnt7TFxeHpKI1zpEX8iuyWx566eOngxlXKi72BOdbKYjwid5POj/g92SUU/MXl+TlKDzTYjGpWkLDD8VP3TA=
X-Received: by 2002:a02:969a:: with SMTP id w26mr7461115jai.71.1587726524678;
 Fri, 24 Apr 2020 04:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200422172414.6662-1-ardb@kernel.org> <mhng-f9b51803-74ca-494c-8433-59911c657b2f@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-f9b51803-74ca-494c-8433-59911c657b2f@palmerdabbelt-glaptop1>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Apr 2020 13:08:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFSKoK8CqzKkruGsne0Ht9xz1cfdyWGY6vu7Z1w7JcB=A@mail.gmail.com>
Message-ID: <CAMj1kXFSKoK8CqzKkruGsne0Ht9xz1cfdyWGY6vu7Z1w7JcB=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add UEFI support for RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 24 Apr 2020 at 00:43, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 22 Apr 2020 10:24:07 PDT (-0700), ardb@kernel.org wrote:
> > This is a rework of Atish's series [0] to add EFI stub loader support
> > to the RISC-V port. The purpose is to split the code in a way that makes
> > it amenable to being merged via different trees during the same cycle.
> > While at it, I added a patch to disable initrd= loading for new ports,
> > given that it is deprecated and replaced with a method based on a
> > special UEFI device path.
> >
> > My changes are logged in the individual patches.
> >
> > I propose to take the first four patches via the EFI tree, and expose
> > them via a stable tag so that the RISC-V maintainers can merge it before
> > applying the remaining patches. That will ensure that both trees remain
> > in a buildable state, with working EFI stub support on the riscv branch.
>
> Works for me.  Thanks!
>

OK. I'll resend the final versions of the remaining patches (with the
ISA_C tweak added) to be taken into the RISC-V tree once the first few
patches have landed in tip/efi/core
