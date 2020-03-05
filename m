Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26617A0D6
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCEIM1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:12:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:58775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEIM1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Mar 2020 03:12:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 00:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234341116"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga008.jf.intel.com with ESMTP; 05 Mar 2020 00:12:25 -0800
Subject: Re: [efi:next] BUILD REGRESSION
 0ceadd2c387c53cd26352fcd2447f310b99459d1
To:     Ard Biesheuvel <ardb@kernel.org>, kbuild test robot <lkp@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
References: <5e6092e5.VxSlbOIvDuPF6kjh%lkp@intel.com>
 <CAKv+Gu-_Yhk2Ok70QDmW6L_8C-LoACx=Bmhy1RSo5rccxoV4SA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <c51de87e-5802-14c2-4509-93fd73594840@intel.com>
Date:   Thu, 5 Mar 2020 16:12:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-_Yhk2Ok70QDmW6L_8C-LoACx=Bmhy1RSo5rccxoV4SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 3/5/20 3:22 PM, Ard Biesheuvel wrote:
> On Thu, 5 Mar 2020 at 06:50, kbuild test robot <lkp@intel.com> wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git  next
>> branch HEAD: 0ceadd2c387c53cd26352fcd2447f310b99459d1  efi/x86: preserve %ebx correctly in efi_set_virtual_address_map()
>>
>> Regressions in current branch:
>>
>> drivers/firmware/efi/libstub/file.c:81 efi_open_volume() error: potentially dereferencing uninitialized 'io'.
>> drivers/firmware/efi/libstub/x86-stub.c:187 retrieve_apple_device_properties() error: potentially dereferencing uninitialized 'p'.
>> drivers/firmware/efi/libstub/x86-stub.c:392 efi_pe_entry() error: potentially dereferencing uninitialized 'image'.
>>
> Once again, this is not a regression, afaict. Please read the code.

Hi Ard,

Thanks for the explanation, we'll take a look.

Best Regards,
Rong Chen

>
>> Error ids grouped by kconfigs:
>>
>> recent_errors
>> `-- x86_64-defconfig
>>      |-- drivers-firmware-efi-libstub-file.c-efi_open_volume()-error:potentially-dereferencing-uninitialized-io-.
>>      |-- drivers-firmware-efi-libstub-x86-stub.c-efi_pe_entry()-error:potentially-dereferencing-uninitialized-image-.
>>      `-- drivers-firmware-efi-libstub-x86-stub.c-retrieve_apple_device_properties()-error:potentially-dereferencing-uninitialized-p-.
>>
>> elapsed time: 648m
>>
>> configs tested: 199
>> configs skipped: 0
>>
>> arm                              allmodconfig
>> arm                               allnoconfig
>> arm                              allyesconfig
>> arm64                            allmodconfig
>> arm64                             allnoconfig
>> arm64                            allyesconfig
>> arm                         at91_dt_defconfig
>> arm                           efm32_defconfig
>> arm                          exynos_defconfig
>> arm                        multi_v5_defconfig
>> arm                        multi_v7_defconfig
>> arm                        shmobile_defconfig
>> arm                           sunxi_defconfig
>> arm64                               defconfig
>> sparc                            allyesconfig
>> ia64                              allnoconfig
>> s390                              allnoconfig
>> csky                                defconfig
>> powerpc                             defconfig
>> s390                          debug_defconfig
>> m68k                           sun3_defconfig
>> sparc64                          allmodconfig
>> sh                  sh7785lcr_32bit_defconfig
>> sh                          rsk7269_defconfig
>> i386                              allnoconfig
>> i386                             allyesconfig
>> i386                             alldefconfig
>> i386                                defconfig
>> ia64                             allmodconfig
>> ia64                                defconfig
>> ia64                             allyesconfig
>> ia64                             alldefconfig
>> c6x                              allyesconfig
>> c6x                        evmc6678_defconfig
>> nios2                         10m50_defconfig
>> nios2                         3c120_defconfig
>> openrisc                    or1ksim_defconfig
>> openrisc                 simple_smp_defconfig
>> xtensa                       common_defconfig
>> xtensa                          iss_defconfig
>> alpha                               defconfig
>> nds32                             allnoconfig
>> nds32                               defconfig
>> h8300                     edosk2674_defconfig
>> h8300                    h8300h-sim_defconfig
>> h8300                       h8s-sim_defconfig
>> m68k                             allmodconfig
>> m68k                       m5475evb_defconfig
>> m68k                          multi_defconfig
>> arc                              allyesconfig
>> arc                                 defconfig
>> microblaze                      mmu_defconfig
>> microblaze                    nommu_defconfig
>> powerpc                           allnoconfig
>> powerpc                       ppc64_defconfig
>> powerpc                          rhel-kconfig
>> mips                           32r2_defconfig
>> mips                         64r6el_defconfig
>> mips                             allmodconfig
>> mips                              allnoconfig
>> mips                             allyesconfig
>> mips                      fuloong2e_defconfig
>> mips                      malta_kvm_defconfig
>> parisc                            allnoconfig
>> parisc                           allyesconfig
>> parisc                generic-32bit_defconfig
>> parisc                generic-64bit_defconfig
>> x86_64               randconfig-a001-20200305
>> x86_64               randconfig-a002-20200305
>> x86_64               randconfig-a003-20200305
>> i386                 randconfig-a001-20200305
>> i386                 randconfig-a002-20200305
>> i386                 randconfig-a003-20200305
>> x86_64               randconfig-a001-20200304
>> x86_64               randconfig-a002-20200304
>> x86_64               randconfig-a003-20200304
>> i386                 randconfig-a001-20200304
>> i386                 randconfig-a002-20200304
>> i386                 randconfig-a003-20200304
>> alpha                randconfig-a001-20200304
>> m68k                 randconfig-a001-20200304
>> mips                 randconfig-a001-20200304
>> nds32                randconfig-a001-20200304
>> parisc               randconfig-a001-20200304
>> riscv                randconfig-a001-20200304
>> c6x                  randconfig-a001-20200304
>> h8300                randconfig-a001-20200304
>> microblaze           randconfig-a001-20200304
>> nios2                randconfig-a001-20200304
>> sparc64              randconfig-a001-20200304
>> sh                   randconfig-a001-20200304
>> openrisc             randconfig-a001-20200304
>> csky                 randconfig-a001-20200304
>> s390                 randconfig-a001-20200304
>> xtensa               randconfig-a001-20200304
>> x86_64               randconfig-b001-20200304
>> x86_64               randconfig-b002-20200304
>> x86_64               randconfig-b003-20200304
>> i386                 randconfig-b001-20200304
>> i386                 randconfig-b002-20200304
>> i386                 randconfig-b003-20200304
>> x86_64               randconfig-b001-20200305
>> x86_64               randconfig-b002-20200305
>> x86_64               randconfig-b003-20200305
>> i386                 randconfig-b001-20200305
>> i386                 randconfig-b002-20200305
>> i386                 randconfig-b003-20200305
>> x86_64               randconfig-c001-20200305
>> x86_64               randconfig-c002-20200305
>> x86_64               randconfig-c003-20200305
>> i386                 randconfig-c001-20200305
>> i386                 randconfig-c002-20200305
>> i386                 randconfig-c003-20200305
>> x86_64               randconfig-c001-20200304
>> x86_64               randconfig-c002-20200304
>> x86_64               randconfig-c003-20200304
>> i386                 randconfig-c001-20200304
>> i386                 randconfig-c002-20200304
>> i386                 randconfig-c003-20200304
>> x86_64               randconfig-d001-20200304
>> x86_64               randconfig-d002-20200304
>> x86_64               randconfig-d003-20200304
>> i386                 randconfig-d001-20200304
>> i386                 randconfig-d002-20200304
>> i386                 randconfig-d003-20200304
>> x86_64               randconfig-e001-20200305
>> x86_64               randconfig-e002-20200305
>> x86_64               randconfig-e003-20200305
>> i386                 randconfig-e001-20200305
>> i386                 randconfig-e002-20200305
>> i386                 randconfig-e003-20200305
>> x86_64               randconfig-e001-20200304
>> x86_64               randconfig-e002-20200304
>> x86_64               randconfig-e003-20200304
>> i386                 randconfig-e001-20200304
>> i386                 randconfig-e002-20200304
>> i386                 randconfig-e003-20200304
>> x86_64               randconfig-f001-20200304
>> x86_64               randconfig-f002-20200304
>> x86_64               randconfig-f003-20200304
>> i386                 randconfig-f001-20200304
>> i386                 randconfig-f002-20200304
>> i386                 randconfig-f003-20200304
>> x86_64               randconfig-g001-20200304
>> x86_64               randconfig-g002-20200304
>> x86_64               randconfig-g003-20200304
>> i386                 randconfig-g001-20200304
>> i386                 randconfig-g002-20200304
>> i386                 randconfig-g003-20200304
>> x86_64               randconfig-h001-20200305
>> x86_64               randconfig-h002-20200305
>> x86_64               randconfig-h003-20200305
>> i386                 randconfig-h001-20200305
>> i386                 randconfig-h002-20200305
>> i386                 randconfig-h003-20200305
>> x86_64               randconfig-h001-20200304
>> x86_64               randconfig-h002-20200304
>> x86_64               randconfig-h003-20200304
>> i386                 randconfig-h001-20200304
>> i386                 randconfig-h002-20200304
>> i386                 randconfig-h003-20200304
>> arc                  randconfig-a001-20200305
>> ia64                 randconfig-a001-20200305
>> sparc                randconfig-a001-20200305
>> arm                  randconfig-a001-20200305
>> arm64                randconfig-a001-20200305
>> arc                  randconfig-a001-20200304
>> arm                  randconfig-a001-20200304
>> arm64                randconfig-a001-20200304
>> ia64                 randconfig-a001-20200304
>> powerpc              randconfig-a001-20200304
>> sparc                randconfig-a001-20200304
>> riscv                            allmodconfig
>> riscv                             allnoconfig
>> riscv                            allyesconfig
>> riscv                               defconfig
>> riscv                    nommu_virt_defconfig
>> riscv                          rv32_defconfig
>> s390                             alldefconfig
>> s390                             allmodconfig
>> s390                             allyesconfig
>> s390                                defconfig
>> s390                       zfcpdump_defconfig
>> sh                               allmodconfig
>> sh                                allnoconfig
>> sh                            titan_defconfig
>> sparc                               defconfig
>> sparc64                           allnoconfig
>> sparc64                          allyesconfig
>> sparc64                             defconfig
>> um                           x86_64_defconfig
>> um                             i386_defconfig
>> um                                  defconfig
>> x86_64                              fedora-25
>> x86_64                                  kexec
>> x86_64                                    lkp
>> x86_64                                   rhel
>> x86_64                         rhel-7.2-clear
>> x86_64                               rhel-7.6
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

