Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A017A07B
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEHWO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 02:22:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEHWO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Mar 2020 02:22:14 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35332073B
        for <linux-efi@vger.kernel.org>; Thu,  5 Mar 2020 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583392933;
        bh=elIjqlzEwP3hd2Vbf8TbmPkPsdhJCd/+i+gpAVztUE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z32GpPJPz2p/jDH24lJ3vPFNPZhB1TyffwdfevqE3IqcvacWjPSPCrm/o7fSKl65W
         Pz16YNYilmCcHRr8CcPDvv831XdDTlZsQFkdjxwluUINUmxgtf4fC7CaBIU7t8UPdd
         sUY66H/RYz4+k9Zhclo9by7Pwju1t11LAR21Lnts=
Received: by mail-wr1-f47.google.com with SMTP id y17so5661721wrn.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 23:22:12 -0800 (PST)
X-Gm-Message-State: ANhLgQ0C6n0ytFqaTHqtsCBbg+PxVbg/akqM/6qCxQmmpFAuSNdLUQXh
        99b0/nR9dpogF3/0xGq6s9HK+VktjbSvd4IWKAJa2w==
X-Google-Smtp-Source: ADFU+vs9kcUIQANThaixIxUXE271TSeV0gnvRzWVoySJjQW1fP3o0n5eMcGU4wc5/68gO50nSJo7nijgrN3nagHAOpI=
X-Received: by 2002:adf:f84a:: with SMTP id d10mr8770528wrq.208.1583392931245;
 Wed, 04 Mar 2020 23:22:11 -0800 (PST)
MIME-Version: 1.0
References: <5e6092e5.VxSlbOIvDuPF6kjh%lkp@intel.com>
In-Reply-To: <5e6092e5.VxSlbOIvDuPF6kjh%lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 08:22:00 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-_Yhk2Ok70QDmW6L_8C-LoACx=Bmhy1RSo5rccxoV4SA@mail.gmail.com>
Message-ID: <CAKv+Gu-_Yhk2Ok70QDmW6L_8C-LoACx=Bmhy1RSo5rccxoV4SA@mail.gmail.com>
Subject: Re: [efi:next] BUILD REGRESSION 0ceadd2c387c53cd26352fcd2447f310b99459d1
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Mar 2020 at 06:50, kbuild test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
> branch HEAD: 0ceadd2c387c53cd26352fcd2447f310b99459d1  efi/x86: preserve %ebx correctly in efi_set_virtual_address_map()
>
> Regressions in current branch:
>
> drivers/firmware/efi/libstub/file.c:81 efi_open_volume() error: potentially dereferencing uninitialized 'io'.
> drivers/firmware/efi/libstub/x86-stub.c:187 retrieve_apple_device_properties() error: potentially dereferencing uninitialized 'p'.
> drivers/firmware/efi/libstub/x86-stub.c:392 efi_pe_entry() error: potentially dereferencing uninitialized 'image'.
>

Once again, this is not a regression, afaict. Please read the code.

> Error ids grouped by kconfigs:
>
> recent_errors
> `-- x86_64-defconfig
>     |-- drivers-firmware-efi-libstub-file.c-efi_open_volume()-error:potentially-dereferencing-uninitialized-io-.
>     |-- drivers-firmware-efi-libstub-x86-stub.c-efi_pe_entry()-error:potentially-dereferencing-uninitialized-image-.
>     `-- drivers-firmware-efi-libstub-x86-stub.c-retrieve_apple_device_properties()-error:potentially-dereferencing-uninitialized-p-.
>
> elapsed time: 648m
>
> configs tested: 199
> configs skipped: 0
>
> arm                              allmodconfig
> arm                               allnoconfig
> arm                              allyesconfig
> arm64                            allmodconfig
> arm64                             allnoconfig
> arm64                            allyesconfig
> arm                         at91_dt_defconfig
> arm                           efm32_defconfig
> arm                          exynos_defconfig
> arm                        multi_v5_defconfig
> arm                        multi_v7_defconfig
> arm                        shmobile_defconfig
> arm                           sunxi_defconfig
> arm64                               defconfig
> sparc                            allyesconfig
> ia64                              allnoconfig
> s390                              allnoconfig
> csky                                defconfig
> powerpc                             defconfig
> s390                          debug_defconfig
> m68k                           sun3_defconfig
> sparc64                          allmodconfig
> sh                  sh7785lcr_32bit_defconfig
> sh                          rsk7269_defconfig
> i386                              allnoconfig
> i386                             allyesconfig
> i386                             alldefconfig
> i386                                defconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> ia64                             alldefconfig
> c6x                              allyesconfig
> c6x                        evmc6678_defconfig
> nios2                         10m50_defconfig
> nios2                         3c120_defconfig
> openrisc                    or1ksim_defconfig
> openrisc                 simple_smp_defconfig
> xtensa                       common_defconfig
> xtensa                          iss_defconfig
> alpha                               defconfig
> nds32                             allnoconfig
> nds32                               defconfig
> h8300                     edosk2674_defconfig
> h8300                    h8300h-sim_defconfig
> h8300                       h8s-sim_defconfig
> m68k                             allmodconfig
> m68k                       m5475evb_defconfig
> m68k                          multi_defconfig
> arc                              allyesconfig
> arc                                 defconfig
> microblaze                      mmu_defconfig
> microblaze                    nommu_defconfig
> powerpc                           allnoconfig
> powerpc                       ppc64_defconfig
> powerpc                          rhel-kconfig
> mips                           32r2_defconfig
> mips                         64r6el_defconfig
> mips                             allmodconfig
> mips                              allnoconfig
> mips                             allyesconfig
> mips                      fuloong2e_defconfig
> mips                      malta_kvm_defconfig
> parisc                            allnoconfig
> parisc                           allyesconfig
> parisc                generic-32bit_defconfig
> parisc                generic-64bit_defconfig
> x86_64               randconfig-a001-20200305
> x86_64               randconfig-a002-20200305
> x86_64               randconfig-a003-20200305
> i386                 randconfig-a001-20200305
> i386                 randconfig-a002-20200305
> i386                 randconfig-a003-20200305
> x86_64               randconfig-a001-20200304
> x86_64               randconfig-a002-20200304
> x86_64               randconfig-a003-20200304
> i386                 randconfig-a001-20200304
> i386                 randconfig-a002-20200304
> i386                 randconfig-a003-20200304
> alpha                randconfig-a001-20200304
> m68k                 randconfig-a001-20200304
> mips                 randconfig-a001-20200304
> nds32                randconfig-a001-20200304
> parisc               randconfig-a001-20200304
> riscv                randconfig-a001-20200304
> c6x                  randconfig-a001-20200304
> h8300                randconfig-a001-20200304
> microblaze           randconfig-a001-20200304
> nios2                randconfig-a001-20200304
> sparc64              randconfig-a001-20200304
> sh                   randconfig-a001-20200304
> openrisc             randconfig-a001-20200304
> csky                 randconfig-a001-20200304
> s390                 randconfig-a001-20200304
> xtensa               randconfig-a001-20200304
> x86_64               randconfig-b001-20200304
> x86_64               randconfig-b002-20200304
> x86_64               randconfig-b003-20200304
> i386                 randconfig-b001-20200304
> i386                 randconfig-b002-20200304
> i386                 randconfig-b003-20200304
> x86_64               randconfig-b001-20200305
> x86_64               randconfig-b002-20200305
> x86_64               randconfig-b003-20200305
> i386                 randconfig-b001-20200305
> i386                 randconfig-b002-20200305
> i386                 randconfig-b003-20200305
> x86_64               randconfig-c001-20200305
> x86_64               randconfig-c002-20200305
> x86_64               randconfig-c003-20200305
> i386                 randconfig-c001-20200305
> i386                 randconfig-c002-20200305
> i386                 randconfig-c003-20200305
> x86_64               randconfig-c001-20200304
> x86_64               randconfig-c002-20200304
> x86_64               randconfig-c003-20200304
> i386                 randconfig-c001-20200304
> i386                 randconfig-c002-20200304
> i386                 randconfig-c003-20200304
> x86_64               randconfig-d001-20200304
> x86_64               randconfig-d002-20200304
> x86_64               randconfig-d003-20200304
> i386                 randconfig-d001-20200304
> i386                 randconfig-d002-20200304
> i386                 randconfig-d003-20200304
> x86_64               randconfig-e001-20200305
> x86_64               randconfig-e002-20200305
> x86_64               randconfig-e003-20200305
> i386                 randconfig-e001-20200305
> i386                 randconfig-e002-20200305
> i386                 randconfig-e003-20200305
> x86_64               randconfig-e001-20200304
> x86_64               randconfig-e002-20200304
> x86_64               randconfig-e003-20200304
> i386                 randconfig-e001-20200304
> i386                 randconfig-e002-20200304
> i386                 randconfig-e003-20200304
> x86_64               randconfig-f001-20200304
> x86_64               randconfig-f002-20200304
> x86_64               randconfig-f003-20200304
> i386                 randconfig-f001-20200304
> i386                 randconfig-f002-20200304
> i386                 randconfig-f003-20200304
> x86_64               randconfig-g001-20200304
> x86_64               randconfig-g002-20200304
> x86_64               randconfig-g003-20200304
> i386                 randconfig-g001-20200304
> i386                 randconfig-g002-20200304
> i386                 randconfig-g003-20200304
> x86_64               randconfig-h001-20200305
> x86_64               randconfig-h002-20200305
> x86_64               randconfig-h003-20200305
> i386                 randconfig-h001-20200305
> i386                 randconfig-h002-20200305
> i386                 randconfig-h003-20200305
> x86_64               randconfig-h001-20200304
> x86_64               randconfig-h002-20200304
> x86_64               randconfig-h003-20200304
> i386                 randconfig-h001-20200304
> i386                 randconfig-h002-20200304
> i386                 randconfig-h003-20200304
> arc                  randconfig-a001-20200305
> ia64                 randconfig-a001-20200305
> sparc                randconfig-a001-20200305
> arm                  randconfig-a001-20200305
> arm64                randconfig-a001-20200305
> arc                  randconfig-a001-20200304
> arm                  randconfig-a001-20200304
> arm64                randconfig-a001-20200304
> ia64                 randconfig-a001-20200304
> powerpc              randconfig-a001-20200304
> sparc                randconfig-a001-20200304
> riscv                            allmodconfig
> riscv                             allnoconfig
> riscv                            allyesconfig
> riscv                               defconfig
> riscv                    nommu_virt_defconfig
> riscv                          rv32_defconfig
> s390                             alldefconfig
> s390                             allmodconfig
> s390                             allyesconfig
> s390                                defconfig
> s390                       zfcpdump_defconfig
> sh                               allmodconfig
> sh                                allnoconfig
> sh                            titan_defconfig
> sparc                               defconfig
> sparc64                           allnoconfig
> sparc64                          allyesconfig
> sparc64                             defconfig
> um                           x86_64_defconfig
> um                             i386_defconfig
> um                                  defconfig
> x86_64                              fedora-25
> x86_64                                  kexec
> x86_64                                    lkp
> x86_64                                   rhel
> x86_64                         rhel-7.2-clear
> x86_64                               rhel-7.6
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
