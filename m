Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18892CE7DB
	for <lists+linux-efi@lfdr.de>; Fri,  4 Dec 2020 06:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgLDF4o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Dec 2020 00:56:44 -0500
Received: from condef-08.nifty.com ([202.248.20.73]:64071 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDF4n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Dec 2020 00:56:43 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2020 00:56:42 EST
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-08.nifty.com with ESMTP id 0B45jJwI002208;
        Fri, 4 Dec 2020 14:45:19 +0900
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0B45iOHK014725;
        Fri, 4 Dec 2020 14:44:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0B45iOHK014725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1607060664;
        bh=GxQOUZTbjpTLY9LjOb5fkHKriTuvaD4ieHcqMtD0zU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R/YJZpM2TUDt4msXhrrmCenmQFK0SPqfC9vbu3g9nS1uDiYEMIty1jmuSbtOd2vYq
         oEYaisN/8FFUyC5kXvxyzAADam3yAGSM8Jv4U9iTASPKnyjhyopf5Q+b39tIHTGSCU
         KZ7J4dN8tnT06VbKOQ2ZprJsDd8Cv5pswud7Nh/uWxRgxXts+naYIWjIADLIcO7s5K
         Ej8G5+pa9LOo7URiBg4yREvuAij+MGPvFS5oXHYYGpclLh27KCxc8ZZUlGKiQWf522
         EHVl1iaoIuUMext3AHN9LGrV0uf0SPa8lD1TjlonnkYekjiibvR+J9arhCRKRvkC19
         33escYa1CP/5Q==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id x24so2944563pfn.6;
        Thu, 03 Dec 2020 21:44:24 -0800 (PST)
X-Gm-Message-State: AOAM532j3L5ujb0DxJ0+eDemsbIyiqWVmXq3grIzkhgMm+7hust/FdBR
        Zxjv1Ss0sQDVJMP8aFNMHg6/6SKLcPDAcHvCZq4=
X-Google-Smtp-Source: ABdhPJwSYF2cWdLfL5qZiKxAtQSsH8nHXtNTwO15tGB6CNOA8wl/q/O5NzJ1suMu/FAzPoErqTxsjO3rMshMsV8gl/4=
X-Received: by 2002:a62:e519:0:b029:197:bcec:7c0c with SMTP id
 n25-20020a62e5190000b0290197bcec7c0cmr2396899pff.63.1607060663618; Thu, 03
 Dec 2020 21:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20200829051524.706585-1-masahiroy@kernel.org>
In-Reply-To: <20200829051524.706585-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 4 Dec 2020 14:43:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL88XGMuNSxAVKsTw+s74PY2GCU+QNJCh02ZKG5s9TNw@mail.gmail.com>
Message-ID: <CAK7LNARL88XGMuNSxAVKsTw+s74PY2GCU+QNJCh02ZKG5s9TNw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ia64: clean-up header dependency and build process,
 fix build warning
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi, IA64 maintainers,

Could you check this series, please?
The build warning is still remaining.



On Sat, Aug 29, 2020 at 2:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> Randy Dunlap reports the following warning with CONFIG_IA64_PALINFO=m:
>
> ../scripts/Makefile.build:68: 'arch/ia64/kernel/palinfo.ko' will not be built even though obj-m is specified.
> ../scripts/Makefile.build:69: You cannot use subdir-y/m to visit a module Makefile. Use obj-y/m instead.
>
> This comes from the fact Kbuild descends into arch/ia64/kernel/ twice.
>
> First, to generate <generated/nr-irqs.h>,
> Second, to build kernel and module objects.
>
> The warning is emitted in the first descend because it is not the
> intended usage.
>
> I looked into the code closely, and noticed arch/ia64/kernel/nr-irqs.c
> was not needed in the first place.
>
> It was separated out of arch/ia64/kernel/asm-offsets.c just because
> <asm/mca.h> was including too many bogus headers.
>
> IA64 is not actively maintained, and there exists unneeded obsolete code.
>
> The first two patches are the outcome when I played with ARCH=ia64 builds,
> but not prerequisites for 3/3. Anyway I believe they are nice cleanups
> and folded in this patch set.
>
> 3/3 is the important one to fix the false positive warning,
> and it is a nice cleanup too.
>
>
>
> Masahiro Yamada (3):
>   ia64: do not typedef struct pal_min_state_area_s
>   ia64: remove unneeded header includes from <asm/mca.h>
>   ia64: remove generated/nr-irqs.h generation to fix build warning
>
>  arch/ia64/Makefile             |  6 ------
>  arch/ia64/include/asm/irq.h    |  4 +++-
>  arch/ia64/include/asm/mca.h    | 11 ++++-------
>  arch/ia64/include/asm/pal.h    |  4 ++--
>  arch/ia64/include/asm/sal.h    |  2 +-
>  arch/ia64/kernel/Makefile      |  5 -----
>  arch/ia64/kernel/asm-offsets.c | 18 +++++++++---------
>  arch/ia64/kernel/efi.c         |  1 +
>  arch/ia64/kernel/mca.c         |  5 +++--
>  arch/ia64/kernel/mca_drv.c     |  2 +-
>  arch/ia64/kernel/nr-irqs.c     | 22 ----------------------
>  11 files changed, 24 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/ia64/kernel/nr-irqs.c
>
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
