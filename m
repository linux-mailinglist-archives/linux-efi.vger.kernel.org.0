Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453801DBB91
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgETRec (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRec (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 13:34:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00386C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:34:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so1626600plr.4
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ly7q46A/YW7cTJNS8aaCsg5FPCDHrwS4jRDbS+IUhyI=;
        b=q5ys3q2py7XnvXrAhfL3cWgrpewSAIug3YGUQgMZiRzPhYK+P3KZsCaOekaX+6MLZ6
         NoKLDgx/hn9+QFBy/jsdFVr6MaRWd/89ZegFO5NIvduwleNdDDNWeVN6cfzfr0WRCSRc
         2f7ys9txHm1a7kuTOOq9mOoIY2C+kxA9vEh2468ZpT4ZbplFFSliUOc0lsr47ZohS72r
         36nUryTTBCeu+iuhM/YMEWtMBgxuyghg0SEgEEX43GkVvHuV4iCojyJJAPT/G7sMMVbX
         j2cRmwSDyihnE1xQiAhuG4cgBvTIWzh1nCrLbOz9RUcxzMdT5ElpGKT47yBP1ISmzr1+
         9h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ly7q46A/YW7cTJNS8aaCsg5FPCDHrwS4jRDbS+IUhyI=;
        b=NNOaEt/3ICY049e8KWauLJ13Fx/miYlA/uwlreC4XKWWtHWLRLCE3LKb1kfP8cy3qo
         ZBK+QPcC+hrCLL7kJ3WVkLEjPreHkVXkxnk1K6cYX28Rs4YtFZol+Mcc9zb/FhoV5PUE
         QRKubtaPz3RMX0qm7hXld29KkZaBeWtcuawcjZzdXtY7VYwi7X6zl45TVgVHQmUySp7n
         MKq+z95S7uJdx7ySevvq7+immdWBkpB2dsaPO683cxV0g3lxdDPVgaxFApApVDPnzmKQ
         kiI2cyMkA5FZQHdkfY5vu6fAisWaPzPiqAetPhslEFM6gbwRR9JkBon0XzqCcI9sLmZT
         jvCg==
X-Gm-Message-State: AOAM530x6fiWtvEbSnlvYqqRU8wdrZYqHESZBfXLCZxXwdDap9cA0vBT
        /W7QL7GuN3yE+U4WFL0umq4Zbg==
X-Google-Smtp-Source: ABdhPJzQ0GgycXOXuNMWjCQTASFEUEGBZeKoSbUlPasJ+ZwOV6GARivajOOdCKypi03W1PVUqdRBcA==
X-Received: by 2002:a17:902:b217:: with SMTP id t23mr3107621plr.183.1589996071167;
        Wed, 20 May 2020 10:34:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id kx6sm2513543pjb.49.2020.05.20.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:34:30 -0700 (PDT)
Date:   Wed, 20 May 2020 10:34:25 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [efi:next 22/40] ld.lld: warning:
 vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32
 against symbol ''
Message-ID: <20200520173425.ovn4kvv2cvkdlrnn@google.com>
References: <202005201012.pqmB8hA5%lkp@intel.com>
 <20200520155352.GB3184088@rani.riverdale.lan>
 <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-05-20, Ard Biesheuvel wrote:
>On Wed, 20 May 2020 at 17:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>
>> On Wed, May 20, 2020 at 10:28:13AM +0800, kbuild test robot wrote:
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
>> > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
>> > commit: ce5e3f909fc0ed67e58367b9c56a54c20a51080b [22/40] efi/printf: Add 64-bit and 8-bit integer support
>> > config: x86_64-defconfig (attached as .config)
>> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
>> > reproduce:
>> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         # install x86_64 cross compiling tool for clang build
>> >         # apt-get install binutils-x86-64-linux-gnu
>> >         git checkout ce5e3f909fc0ed67e58367b9c56a54c20a51080b
>> >         # save the attached .config to linux build tree
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>> >
>> > If you fix the issue, kindly add following tag as appropriate
>> > Reported-by: kbuild test robot <lkp@intel.com>
>> >
>> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
>> >
>> > >> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
>> >
>> > ---
>> > 0-DAY CI Kernel Test Service, Intel Corporation
>> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>> Clang folk, is anything actually wrong here? This seems to result from
>> use of unreachable() annotation, which generates these
>> .discard.unreachable sections apparently to help objtool.
>>
>
>This came up before, and IIRC, it has already been fixed, only this
>branch is based on v5.7-rc2.

LLD reports the diagnostic because a PC-relative relocation referencing a
SHF_ALLOC section from a non-SHF_ALLOC section (.discard.unreachable) cannot be
reasonably represented. A non-SHF_ALLOC section is not part of the memory image, thus conceptually
the distance between a non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at linktime.
This is actually a nice diagnostic which has caught a number of issues.

% readelf -Wr drivers/firmware/efi/libstub/vsprintf.stub.o
..
Relocation section '.rela.discard.unreachable' at offset 0xe38 contains 1 entry:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000600000002 R_X86_64_PC32          0000000000000000 .text + ac0

---

The linker command line is:

% ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds arch/x86/boot/compressed/kernel_info.o arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o arch/x86/boot/compressed/cpuflags.o arch/x86/boot/compressed/early_serial_console.o arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o arch/x86/boot/compressed/mem_encrypt.o arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o drivers/firmware/efi/libstub/lib.a arch/x86/boot/compressed/efi_thunk_64.o -o arch/x86/boot/compressed/vmlinux
ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''

arch/x86/boot/compressed/vmlinux has an output section .discard.unreachable , which is likely desired.

Note that arch/x86/kernel/vmlinux.lds.S has an output section description /DISCARD/ : { ... *(.discard.*) ... },
but arch/x86/boot/compressed/vmlinux doesn't.

We can let arch/x86/boot/compressed/vmlinux reuse the /DISCARD/ to fix the issue.
