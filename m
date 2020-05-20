Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0971DBCC8
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETS0n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETS0m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 14:26:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92447C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:26:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e11so1018747pfn.3
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gmTRxn2yiC/GCHZxivAn5VqkLhuGYHAhN/MaTk/EAtQ=;
        b=hY+MhIABNbFtjOvRSURKv9aTCOaTzPBi+q7MKX+2jtUKwJi9zeG038plpHjs9sO3Wz
         vR/bf/tCLJr7HZzsUtB64HXGiDZltyL3/N5kyyf5pUXGGInJMDh0T7M0u1IyFWlsyTK5
         2GZmT1cULbFkh8MzadiHZ730Gt66FwzUR3PGr0lucCOMBgEYzzGFQjQvsgg/S/vByfdE
         w4wzpPDPt8vsJwf4bNEjD3TZmNPGXFZBU1TTtn6Lp+C5xPTJWDn7r0kJwo1AuIux7he/
         657UGkaBnHEN5HG+w+6cQ7taGk1pGUh+tILblyZAYmk//khGQNmdqUHRJmpGec8v1YDE
         +SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmTRxn2yiC/GCHZxivAn5VqkLhuGYHAhN/MaTk/EAtQ=;
        b=Jr+vodwuNrx201iqBPJX1J0cs0SkBk3lqRtUkBYrBlhOe9wvjQrMCiG/wc24YmUEEa
         h+ldwqPqeUNlNyuBsdQhzj5WLnTqG7jNac5b9BmrFPycN+3Zu+4jgaMoF8u4jR72MCEV
         YrvUJ4GFGoite66ogwRBSGd0Bzfs+jMQmKjzp5/6PPqm2P2GcKA0MJzmkqmree3CTHq9
         3H8/1emHgq0GvI/9et9IJZ3auPDwVZ2VuHUnc7VsIQ3dRafFhazs+sOI2JBLD8d8Q0Ax
         2NSKt3rXCpbCzIFpw6YCvVk1bE1com+jY/pW0LHq2o87D4QjHJaQAAdRJlNVK78Ybsq2
         J6vA==
X-Gm-Message-State: AOAM532Ig3a7YxuROESgCN/dxyNtiZ/xHvXrARx77XHmZw8dc/sUGH61
        Sn7xNTjMjeGYCcJVBQd4dKIwdQ==
X-Google-Smtp-Source: ABdhPJzV/lFTeAvSu3ItnWLiX+w+V3FI1cGS8zND/o8HKb/z1UHL0HcpjD2gc0O1k+eycdOw9ptn5w==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr5641145pfp.265.1589999201799;
        Wed, 20 May 2020 11:26:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id m43sm2702285pje.16.2020.05.20.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:26:41 -0700 (PDT)
Date:   Wed, 20 May 2020 11:26:36 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [efi:next 22/40] ld.lld: warning:
 vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32
 against symbol ''
Message-ID: <20200520182636.jnnobtrcwmksb3tf@google.com>
References: <202005201012.pqmB8hA5%lkp@intel.com>
 <20200520155352.GB3184088@rani.riverdale.lan>
 <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
 <20200520173425.ovn4kvv2cvkdlrnn@google.com>
 <20200520173926.GA3365034@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520173926.GA3365034@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2020-05-20, Arvind Sankar wrote:
>On Wed, May 20, 2020 at 10:34:25AM -0700, Fangrui Song wrote:
>> On 2020-05-20, Ard Biesheuvel wrote:
>> >On Wed, 20 May 2020 at 17:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> >>
>> >> On Wed, May 20, 2020 at 10:28:13AM +0800, kbuild test robot wrote:
>> >> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
>> >> > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
>> >> > commit: ce5e3f909fc0ed67e58367b9c56a54c20a51080b [22/40] efi/printf: Add 64-bit and 8-bit integer support
>> >> > config: x86_64-defconfig (attached as .config)
>> >> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
>> >> > reproduce:
>> >> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >> >         chmod +x ~/bin/make.cross
>> >> >         # install x86_64 cross compiling tool for clang build
>> >> >         # apt-get install binutils-x86-64-linux-gnu
>> >> >         git checkout ce5e3f909fc0ed67e58367b9c56a54c20a51080b
>> >> >         # save the attached .config to linux build tree
>> >> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>> >> >
>> >> > If you fix the issue, kindly add following tag as appropriate
>> >> > Reported-by: kbuild test robot <lkp@intel.com>
>> >> >
>> >> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
>> >> >
>> >> > >> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
>> >> >
>> >> > ---
>> >> > 0-DAY CI Kernel Test Service, Intel Corporation
>> >> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> >>
>> >> Clang folk, is anything actually wrong here? This seems to result from
>> >> use of unreachable() annotation, which generates these
>> >> .discard.unreachable sections apparently to help objtool.
>> >>
>> >
>> >This came up before, and IIRC, it has already been fixed, only this
>> >branch is based on v5.7-rc2.
>>
>> LLD reports the diagnostic because a PC-relative relocation referencing a
>> SHF_ALLOC section from a non-SHF_ALLOC section (.discard.unreachable) cannot be
>> reasonably represented. A non-SHF_ALLOC section is not part of the memory image, thus conceptually
>> the distance between a non-SHF_ALLOC and a SHF_ALLOC is not a constant which can be resolved at linktime.
>> This is actually a nice diagnostic which has caught a number of issues.
>>
>> % readelf -Wr drivers/firmware/efi/libstub/vsprintf.stub.o
>> ..
>> Relocation section '.rela.discard.unreachable' at offset 0xe38 contains 1 entry:
>>      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
>> 0000000000000000  0000000600000002 R_X86_64_PC32          0000000000000000 .text + ac0
>>
>> ---
>>
>> The linker command line is:
>>
>> % ld.lld -m elf_x86_64 -T arch/x86/boot/compressed/vmlinux.lds arch/x86/boot/compressed/kernel_info.o arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o arch/x86/boot/compressed/cpuflags.o arch/x86/boot/compressed/early_serial_console.o arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o arch/x86/boot/compressed/mem_encrypt.o arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o drivers/firmware/efi/libstub/lib.a arch/x86/boot/compressed/efi_thunk_64.o -o arch/x86/boot/compressed/vmlinux
>> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
>>
>> arch/x86/boot/compressed/vmlinux has an output section .discard.unreachable , which is likely desired.
>
>You mean /not/ desired, right?

You are right:) I meant "undesired"

>
>>
>> Note that arch/x86/kernel/vmlinux.lds.S has an output section description /DISCARD/ : { ... *(.discard.*) ... },
>> but arch/x86/boot/compressed/vmlinux doesn't.
>>
>> We can let arch/x86/boot/compressed/vmlinux reuse the /DISCARD/ to fix the issue.
>
>Yep.

git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git HEAD
does not have the warning.
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git HEAD has the
warning.

Sent http://lore.kernel.org/r/20200520182010.242489-1-maskray@google.com
"[PATCH] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux"
which should fix the problem.

I am still a kernel newbie. I set To: to you and both x86@kernel.org and
linux-efi@vger.kernel.org
Hope that is correct.
