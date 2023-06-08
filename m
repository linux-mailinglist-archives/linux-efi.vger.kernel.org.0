Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAA7279C0
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjFHIN2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjFHINW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 04:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256C2270F
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 01:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF641649F2
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 08:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBE1C433D2
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686212000;
        bh=CQ5VrLvy7o4xj6+YN5Ks5SbRnwn4ckTEk16dHCn9YMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dbVZA/lp3OhIqRO9KErfDIi8hghSc8W+wVA1l5P5Es+paa+u2twsxXpiGJXoPClOl
         FIFXc6gc3qrmin6Pe3gzd3oo5RZ6NBrRNx2IBVYYA+dy76apIjjFNSJq1JDRuOe41Y
         KSCJskEV5OwU+4yafpTvfkpnT6jL56sVBle5EV7BDi0AUwH9YT8u7lsEjgFPtH2lee
         T4yWGjp7s0GoBTVhas3tqurbyeYN80d3OaOw9qZshJkaA80K/sepvH3YpJPUlBgZvj
         AimyX46ik/iaXtLZwOuqeXA4liQjnVskq6AJstNnN9z9m8m4DUJCQ+PNY/v4seSLIv
         XBq1Ne9MAAFEg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso2546101fa.1
        for <linux-efi@vger.kernel.org>; Thu, 08 Jun 2023 01:13:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDw2GfiJ47QxYyK3+xCySVbQmL2bpuiIYGdeqBTFkYvsvVRYorBd
        Eui2vjqh7QW4VJ+E7ncs45rR3Ud4E5qq2KSM9YA=
X-Google-Smtp-Source: ACHHUZ4vUx+dTL8nZsEzVC4CRQW+xbM/alKYT77YIDDz7nfVdo1w6oEF9YUwTrIfPLffsmxI5McSJeOFbUQOMkkZBsQ=
X-Received: by 2002:a2e:9acf:0:b0:2b0:486c:3102 with SMTP id
 p15-20020a2e9acf000000b002b0486c3102mr3289337ljj.10.1686211998338; Thu, 08
 Jun 2023 01:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <202306081655.Z7Ghy5aC-lkp@intel.com>
In-Reply-To: <202306081655.Z7Ghy5aC-lkp@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 10:13:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE49wV0ou8jn7qZFEauioDNF2wB5hsh_se9Xsvs7MXS2w@mail.gmail.com>
Message-ID: <CAMj1kXE49wV0ou8jn7qZFEauioDNF2wB5hsh_se9Xsvs7MXS2w@mail.gmail.com>
Subject: Re: [efi:next] BUILD SUCCESS d0a1865cf7e2211d9227592ef4141f4632e33908
To:     kernel test robot <lkp@intel.com>, Philip Li <philip.li@intel.com>
Cc:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

As requested before, could we please stop testing ia64?



On Thu, 8 Jun 2023 at 10:11, kernel test robot <lkp@intel.com> wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> branch HEAD: d0a1865cf7e2211d9227592ef4141f4632e33908  efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
>
> elapsed time: 841m
>
> configs tested: 113
> configs skipped: 5
>
> The following configs have been built successfully.
> More configs may be tested in the coming days.
>
> tested configs:
> alpha                            allyesconfig   gcc
> alpha                               defconfig   gcc
> alpha                randconfig-r015-20230608   gcc
> arc                              allyesconfig   gcc
> arc                                 defconfig   gcc
> arc                  randconfig-r006-20230608   gcc
> arm                              allmodconfig   gcc
> arm                              allyesconfig   gcc
> arm                       aspeed_g5_defconfig   gcc
> arm                         axm55xx_defconfig   gcc
> arm                                 defconfig   gcc
> arm                      jornada720_defconfig   gcc
> arm                       multi_v4t_defconfig   gcc
> arm                         nhk8815_defconfig   gcc
> arm64                            allyesconfig   gcc
> arm64                               defconfig   gcc
> csky                                defconfig   gcc
> csky                 randconfig-r021-20230608   gcc
> hexagon              randconfig-r015-20230607   clang
> i386                             allyesconfig   gcc
> i386                              debian-10.3   gcc
> i386                                defconfig   gcc
> i386                 randconfig-i051-20230607   clang
> i386                 randconfig-i052-20230607   clang
> i386                 randconfig-i053-20230607   clang
> i386                 randconfig-i054-20230607   clang
> i386                 randconfig-i055-20230607   clang
> i386                 randconfig-i056-20230607   clang
> i386                 randconfig-i061-20230607   clang
> i386                 randconfig-i062-20230607   clang
> i386                 randconfig-i063-20230607   clang
> i386                 randconfig-i064-20230607   clang
> i386                 randconfig-i065-20230607   clang
> i386                 randconfig-i066-20230607   clang
> i386                 randconfig-r002-20230608   gcc
> ia64                            zx1_defconfig   gcc
> loongarch                        allmodconfig   gcc
> loongarch                         allnoconfig   gcc
> loongarch                           defconfig   gcc
> m68k                             allmodconfig   gcc
> m68k                             allyesconfig   gcc
> m68k                                defconfig   gcc
> m68k                           virt_defconfig   gcc
> mips                             allmodconfig   gcc
> mips                             allyesconfig   gcc
> mips                       bmips_be_defconfig   gcc
> mips                     decstation_defconfig   gcc
> nios2                               defconfig   gcc
> nios2                randconfig-r012-20230608   gcc
> nios2                randconfig-r032-20230608   gcc
> nios2                randconfig-r035-20230608   gcc
> openrisc             randconfig-r011-20230608   gcc
> openrisc             randconfig-r022-20230608   gcc
> parisc                           allyesconfig   gcc
> parisc                              defconfig   gcc
> parisc64                            defconfig   gcc
> powerpc                          allmodconfig   gcc
> powerpc                           allnoconfig   gcc
> powerpc                     rainier_defconfig   gcc
> powerpc              randconfig-r003-20230608   gcc
> powerpc                     tqm8548_defconfig   gcc
> riscv                            allmodconfig   gcc
> riscv                             allnoconfig   gcc
> riscv                            allyesconfig   gcc
> riscv                               defconfig   gcc
> riscv                          rv32_defconfig   gcc
> s390                             allmodconfig   gcc
> s390                             allyesconfig   gcc
> s390                                defconfig   gcc
> s390                 randconfig-r001-20230608   gcc
> sh                               allmodconfig   gcc
> sh                   randconfig-r026-20230608   gcc
> sh                          rsk7203_defconfig   gcc
> sh                           se7705_defconfig   gcc
> sh                   sh7724_generic_defconfig   gcc
> sh                        sh7785lcr_defconfig   gcc
> sparc                            allyesconfig   gcc
> sparc                               defconfig   gcc
> sparc                randconfig-r016-20230608   gcc
> um                             i386_defconfig   gcc
> um                           x86_64_defconfig   gcc
> x86_64                           allyesconfig   gcc
> x86_64                              defconfig   gcc
> x86_64                                  kexec   gcc
> x86_64               randconfig-a001-20230607   clang
> x86_64               randconfig-a002-20230607   clang
> x86_64               randconfig-a003-20230607   clang
> x86_64               randconfig-a004-20230607   clang
> x86_64               randconfig-a005-20230607   clang
> x86_64               randconfig-a006-20230607   clang
> x86_64               randconfig-a011-20230607   gcc
> x86_64               randconfig-a012-20230607   gcc
> x86_64               randconfig-a013-20230607   gcc
> x86_64               randconfig-a014-20230607   gcc
> x86_64               randconfig-a015-20230607   gcc
> x86_64               randconfig-a016-20230607   gcc
> x86_64               randconfig-r004-20230608   gcc
> x86_64               randconfig-x051-20230607   gcc
> x86_64               randconfig-x052-20230607   gcc
> x86_64               randconfig-x053-20230607   gcc
> x86_64               randconfig-x054-20230607   gcc
> x86_64               randconfig-x055-20230607   gcc
> x86_64               randconfig-x056-20230607   gcc
> x86_64               randconfig-x061-20230607   gcc
> x86_64               randconfig-x062-20230607   gcc
> x86_64               randconfig-x063-20230607   gcc
> x86_64               randconfig-x064-20230607   gcc
> x86_64               randconfig-x065-20230607   gcc
> x86_64               randconfig-x066-20230607   gcc
> x86_64                          rhel-8.3-rust   clang
> x86_64                               rhel-8.3   gcc
> xtensa                generic_kc705_defconfig   gcc
> xtensa               randconfig-r031-20230608   gcc
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
