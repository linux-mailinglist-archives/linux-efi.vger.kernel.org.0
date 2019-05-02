Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0588211380
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 08:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfEBGps (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 02:45:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39582 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfEBGps (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 02:45:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so1071498wmk.4;
        Wed, 01 May 2019 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5TbwoEekfcdWv0mvvbYsS+6EAW/pbX53UiDfesuTQE=;
        b=NkDrQqdzsz7vqv7J7Z+qWoH4I7sKeTclvlPsys8BOFZ/pGQEYnXZiqU468Xukcb5ej
         EaTL3lS7Ua692kp9CFF3u5r8eLdUc9fAq9fA2aMWDK22JbzSO6AvHTTUOTiUcg5mb8hv
         n7afcTWrB5ZVtZLFViHCYbdHOwFb2ujoIWMc23aM9q3zlVlfdqYktm8mshhlYmhvtA/u
         n4D2ltETl+EXDtC2UY+W71va/YDbalvSMIpcC4oidwuT0LzdvKhS62Xkc6PklohFVSjl
         b9H9uGD+Ao4lz/rzP/fvn2hWFSaH7iawNpgUJsrD5NcEyDRVqpmovOAQiU8NViCtYGx/
         uoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5TbwoEekfcdWv0mvvbYsS+6EAW/pbX53UiDfesuTQE=;
        b=g8IAIl0WWRn+WHDcxtHYRiAGtj5/IfR0TXZS0ryOrD49gyhe6wRgdrs0M6+14/jUZJ
         8fH7pxpPIU9b9vazSVZd65lPqhykTKUl/oCdSCVBcoJiXaGAQyr/eI1rnPNKUYeCFrEA
         bUYkncPPafA1dnwnNNUTe32Z0CAGZx29t1no782TC3HEffv4vOqKSVLHpJA9MRCPObr4
         1mdWl1wtthTFlc7sZZ2QPwW6r056PTMgMhjrCwzoWL2NMFxCdtFHSVzDmt89D0uAi2pT
         KXMh6SzJFaoY6BkYUW3KbPrY/rnSZ7NPvY1GvK5iw7mp9pGT/sKhDTJHUa8Pz9lJ6Wf0
         BMSg==
X-Gm-Message-State: APjAAAX3HU9T9aAYouzmyaGIeeRR4+7EOCb5grskSa9eoJJ1apiYav/x
        4On8jp/NVkeJ2KIbrN87srDFNVjwxhOCE7bSC/k=
X-Google-Smtp-Source: APXvYqxacmpdifyZqaQ70wlBxsip7duNZrsQz8yyYGYo8OFOM9BWyr7LJEEvIFkHeyZpTzKAL1znrY1h3nxxfQ8EWdM=
X-Received: by 2002:a1c:f719:: with SMTP id v25mr1087705wmh.90.1556779545217;
 Wed, 01 May 2019 23:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com> <CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com>
In-Reply-To: <CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com>
From:   Bartosz Szczepanek <barteks7r@gmail.com>
Date:   Thu, 2 May 2019 08:45:34 +0200
Message-ID: <CAJzaN5ofshg4KseGhOL2LSLDQNoAHC6Ve25gpgWU69bEfBq1fw@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Second patch tries to unmap "mapping" which is not declared. I'm on
top of jjs/master and your TPM_MEMREMAP patches are already there, so
the first patch applied cleanly. Using it, kernel still panicked on
boot:

EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable, no randomness supplied
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x420f5162]
[    0.000000] Linux version 5.1.0-rc2+ (root@localhost.localdomain)
(gcc version 7.3.1 20180712 (Red Hat 7.3.1-6) (GCC)) #78 SMP Wed May 1
01:05:38 EDT 2019
[    0.000000] earlycon: pl11 at MMIO 0x0000000402020000 (options '115200n8')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by Cavium Inc.
TX2-FW-Release-7.2-build_08-0-g14f8c5bf8a Apr 15 2019 18:51:41
[    0.000000] efi:  TPMFinalLog=0xed5f0000  SMBIOS=0xfad90000  SMBIOS
3.0=0xed530000  ACPI 2.0=0xeda90000  ESRT=0xfafdb218
MEMATTR=0xf8489018  TPMEventLog=0xedaa9018  MEMRESERVE=0xedaa8018
[    0.000000] Unhandled fault at 0xffff7dfffe77a018
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000003
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000003
[    0.000000]   CM = 0, WnR = 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
[    0.000000] [ffff7dfffe77a018] pgd=0000000081b12003
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/arm64/mm/fault.c:189!
[    0.000000] Internal error: Oops - BUG: 0 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc2+ #78
[    0.000000] pstate: 60400089 (nZCv daIf +PAN -UAO)
[    0.000000] pc : show_pte+0x1d0/0x1f0
[    0.000000] lr : show_pte+0x88/0x1f0
[    0.000000] sp : ffff000011533b30
[    0.000000] x29: ffff000011533b30 x28: ffff0000115473c0
[    0.000000] x27: ffff000011542500 x26: ffff7dfffe73a010
[    0.000000] x25: 0000000000000018 x24: 0000000000000025
[    0.000000] x23: 00000000000000fb x22: ffff0000117fc000
[    0.000000] x21: ffff000010f32000 x20: ffffffffffffffff
[    0.000000] x19: ffff7dfffe77a018 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffff00001153d708 x14: ffff00001172f420
[    0.000000] x13: ffff00001172f069 x12: ffff000011568000
[    0.000000] x11: ffff000011533800 x10: ffff000011533800
[    0.000000] x9 : ffff00001153ef58 x8 : 303030303030303d
[    0.000000] x7 : 646770205d383130 x6 : ffff00001172e7ff
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
[    0.000000] x1 : 0000000081b12000 x0 : 0000000000000ff8
[    0.000000] Process swapper (pid: 0, stack limit = 0x(____ptrval____))
[    0.000000] Call trace:
[    0.000000]  show_pte+0x1d0/0x1f0
[    0.000000]  do_mem_abort+0xa8/0xb0
[    0.000000]  el1_da+0x20/0xc4
[    0.000000]  efi_tpm_eventlog_init+0xe8/0x268
[    0.000000]  efi_config_parse_tables+0x180/0x29c
[    0.000000]  uefi_init+0x1d0/0x22c
[    0.000000]  efi_init+0x90/0x180
[    0.000000]  setup_arch+0x1f4/0x5fc
[    0.000000]  start_kernel+0x90/0x51c
[    0.000000] Code: 910d6000 94030b20 17ffffe6 d503201f (d4210000)
[    0.000000] random: get_random_bytes called from
print_oops_end_marker+0x54/0x70 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---
