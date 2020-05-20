Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727751DBBB8
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgETRlD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgETRlD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 13:41:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587AC061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:41:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so4357078qke.13
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URcpVJ4JyI57kr8iGfQFjLThhOWvhbh5pUatdFl6RX0=;
        b=keV7XTh4eKjU5X7A4OB8uJlutr1YaW4DzruYCqDiJAHT+hlGdTCyWIR+tfp1bSHfg/
         wb5RQ3bAzBnbrN2cG5JghiUKvNDPg+NcsWzfrbJHYP8QSXF6u46aLDHbCLWpbDOU5ADy
         NF/E2x2JuElkMplS21QHAkhrlAOnw1Yz7aKS8ek6laWM5shmX07KcedVzjvch8UZN55Q
         phg3KLdELXJ0loHNGlllX9mCz3jRENl54GT6OUZkYbm2aGs/hiZbNm+QGpFqgoeBtc6/
         vHqz8hRF03ypgxQWcRvZ758mzIogDnFMbyxHHWRdXlWOkeic7OK0os1vX9UT7nX/oQYW
         zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=URcpVJ4JyI57kr8iGfQFjLThhOWvhbh5pUatdFl6RX0=;
        b=hCIC+S/4Lxp8lyN+tmy/7yKMZWztIXdJh/WdaJEN7yfzAf313+T3BtyiAORUCT1tCi
         WbF8OAUR4lw5IF1gorTtJ6OpyGtjJQ+X8VSRIfT/SrEDb8qVFCdlHGxY+zsJzcllPzy3
         2jgDUUaJeDFm/+WiMUeDnbnVt74Vi05xPsdDeNUvsYzfQzKEgr7tOC5oQgscAPWnJW5F
         /c2nyY2bPdP6f5b7+35SxNd/xbWgQ2JFcULwFw9/NWp/9TCQp9GiXlBDq2Z5AGju7VcQ
         UgJ5XWhesSf13f1D+Os9muklzUllKvRc0iP5kEGIl1+YfNNSZDUNSDhYVEiTLWZyhz60
         ot2A==
X-Gm-Message-State: AOAM5328IlPJ7bfvN5He3h2M+GKXN9aJaKEPsqLTj9p/Wnk4/nc5FxlM
        kNlfaO9elWMI1j0gpvnyuWk=
X-Google-Smtp-Source: ABdhPJxlTehEtmapECoCvCig3puREjMQ/z8NipxQnBEyp/X4jRrBCVOyD5IRRB8Bg84moopL/SM34A==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr5662348qkf.57.1589996462293;
        Wed, 20 May 2020 10:41:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 99sm2828391qte.93.2020.05.20.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:41:01 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 13:41:00 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [efi:next 22/40] ld.lld: warning:
 vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32
 against symbol ''
Message-ID: <20200520174100.GB3365034@rani.riverdale.lan>
References: <202005201012.pqmB8hA5%lkp@intel.com>
 <20200520155352.GB3184088@rani.riverdale.lan>
 <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
 <20200520173425.ovn4kvv2cvkdlrnn@google.com>
 <20200520173926.GA3365034@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520173926.GA3365034@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 01:39:26PM -0400, Arvind Sankar wrote:
> On Wed, May 20, 2020 at 10:34:25AM -0700, Fangrui Song wrote:
> > On 2020-05-20, Ard Biesheuvel wrote:
> > >On Wed, 20 May 2020 at 17:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >>
> > >> On Wed, May 20, 2020 at 10:28:13AM +0800, kbuild test robot wrote:
> > >> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > >> > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > >> > commit: ce5e3f909fc0ed67e58367b9c56a54c20a51080b [22/40] efi/printf: Add 64-bit and 8-bit integer support
> > >> > config: x86_64-defconfig (attached as .config)
> > >> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > >> > reproduce:
> > >> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >> >         chmod +x ~/bin/make.cross
> > >> >         # install x86_64 cross compiling tool for clang build
> > >> >         # apt-get install binutils-x86-64-linux-gnu
> > >> >         git checkout ce5e3f909fc0ed67e58367b9c56a54c20a51080b
> > >> >         # save the attached .config to linux build tree
> > >> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> > >> >
> > >> > If you fix the issue, kindly add following tag as appropriate
> > >> > Reported-by: kbuild test robot <lkp@intel.com>
> > >> >
> > >> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >> >
> > >> > >> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> > >> >
> > >> > ---
> > >> > 0-DAY CI Kernel Test Service, Intel Corporation
> > >> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >>
> > >> Clang folk, is anything actually wrong here? This seems to result from
> > >> use of unreachable() annotation, which generates these
> > >> .discard.unreachable sections apparently to help objtool.
> > >>
> > >
> > >This came up before, and IIRC, it has already been fixed, only this
> > >branch is based on v5.7-rc2.
> > 
> > LLD reports the diagnostic because a PC-relative relocation referencing a
> > SHF_ALLOC section from a non-SHF_ALLOC section (.discard.unreachable) cannot be
> > reasonably represented. A non-SHF_ALLOC section is not part of the memory image, thus conceptually
> > the distance between a non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at linktime.
> > This is actually a nice diagnostic which has caught a number of issues.
> > 
> > % readelf -Wr drivers/firmware/efi/libstub/vsprintf.stub.o
> > ..
> > Relocation section '.rela.discard.unreachable' at offset 0xe38 contains 1 entry:
> >      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> > 0000000000000000  0000000600000002 R_X86_64_PC32          0000000000000000 .text + ac0
> > 
> > ---
> > 
> > The linker command line is:
> > 
> > % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds arch/x86/boot/compressed/kernel_info.o arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o arch/x86/boot/compressed/cpuflags.o arch/x86/boot/compressed/early_serial_console.o arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o arch/x86/boot/compressed/mem_encrypt.o arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o drivers/firmware/efi/libstub/lib.a arch/x86/boot/compressed/efi_thunk_64.o -o arch/x86/boot/compressed/vmlinux
> > ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> > 
> > arch/x86/boot/compressed/vmlinux has an output section .discard.unreachable , which is likely desired.
> 
> You mean /not/ desired, right?
> 
> > 
> > Note that arch/x86/kernel/vmlinux.lds.S has an output section description /DISCARD/ : { ... *(.discard.*) ... },
> > but arch/x86/boot/compressed/vmlinux doesn't.
> > 
> > We can let arch/x86/boot/compressed/vmlinux reuse the /DISCARD/ to fix the issue.
> 
> Yep.

As an aside, how does one (should I) get onto kbuild-all? It keeps
bouncing me as a non-list member currently.
