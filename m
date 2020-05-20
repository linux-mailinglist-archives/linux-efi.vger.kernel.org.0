Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748251DB90F
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgETQOn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 12:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETQOn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 20 May 2020 12:14:43 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE30D20671
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589991282;
        bh=JY2EtIk88lnOLJ3hjR0GYe2lPplk+dAapCXpmihC9Fo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NDdTXOCdjbxruMmABqHqLB2uvHKm+n06CQIiM8dp+SmkccRBCC9xQT6T5M3oZW9WW
         3L9UOxTfQhFOcfU5tRit0iKHT65iM0ryi871lbe7SeeudvRHitvjtzkTD1m6r4hcBv
         Xbvm/BdN15J2xyFzQpngyT76aB0tcvW07CoRm6jQ=
Received: by mail-io1-f43.google.com with SMTP id t15so3756124ios.4
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 09:14:42 -0700 (PDT)
X-Gm-Message-State: AOAM533ujpnDI+MtNI3xtxKP6ERiKg9xLoCwcQ1VY8s/EifOFVMtelYz
        aLRZBSB/4eBo+y/+74fOIw6cWUfBLWDc3WKDGMo=
X-Google-Smtp-Source: ABdhPJx1apY20xojS7S7IJGuceC/SO/iYbQvTXIwI5UVj8GTTCA0KuKKrQT992BMYvCyqCICWfO4fl3Y7oYdQF05YZg=
X-Received: by 2002:a02:c48b:: with SMTP id t11mr4854694jam.71.1589991282210;
 Wed, 20 May 2020 09:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <202005201012.pqmB8hA5%lkp@intel.com> <20200520155352.GB3184088@rani.riverdale.lan>
In-Reply-To: <20200520155352.GB3184088@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 May 2020 18:14:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
Message-ID: <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
Subject: Re: [efi:next 22/40] ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0):
 has non-ABS relocation R_X86_64_PC32 against symbol ''
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 20 May 2020 at 17:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, May 20, 2020 at 10:28:13AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > commit: ce5e3f909fc0ed67e58367b9c56a54c20a51080b [22/40] efi/printf: Add 64-bit and 8-bit integer support
> > config: x86_64-defconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         git checkout ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> Clang folk, is anything actually wrong here? This seems to result from
> use of unreachable() annotation, which generates these
> .discard.unreachable sections apparently to help objtool.
>

This came up before, and IIRC, it has already been fixed, only this
branch is based on v5.7-rc2.
