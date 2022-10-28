Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B60610924
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 06:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ1ECH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ1ECF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 00:02:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C08D8F53
        for <linux-efi@vger.kernel.org>; Thu, 27 Oct 2022 21:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666929725; x=1698465725;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/uqAAXMcKbk8mrzTd4SUkwJJHu8XcskoeaRUyUd2Jgw=;
  b=HHsPeuzyLxRlcElA8lNYNOnQWTNiuj5bdB4ehhB5uI8gw5lYZp3Z6YUC
   M/1IJXGIqALU9mzcDG5y34KHDVD3ek9ScPb+LgFlw7ugioD0d9BD2haO9
   BlIwZ5y015fDnMBL5mJjp6zJY6IZeDP02TyDuFFcs7dpXtRpj3qgOQoxJ
   SpxZ0Fb9g44qOS0KTlEXr/JfEzstFtX1lEu/RANYzn5CEB1Oms/EH9jnK
   gGq0EIEhJn0dJ/gsx1dDX/eeFD+TCV0H1uXikoH1JLspqP8Io0YoVb7Yi
   VJFisGWdpSmC+QAxuCNx+JYoeLihQ8bTe361/2X229PtLv8cUT/0z6/fc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288799773"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288799773"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 21:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="583790809"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="583790809"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 21:02:03 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooGZH-0009TM-0I;
        Fri, 28 Oct 2022 04:02:03 +0000
Date:   Fri, 28 Oct 2022 12:02:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 7f8342cdfdfc644a58a10db13d1cfb9f159f8f43
Message-ID: <635b5439.J/mWw21354ax6H5f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: 7f8342cdfdfc644a58a10db13d1cfb9f159f8f43  efi: libstub: Enable efi_printk() in zboot decompressor

elapsed time: 725m

configs tested: 38
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
s390                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
m68k                             allmodconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                        keystone_defconfig
powerpc                mpc7448_hpc2_defconfig
x86_64                           alldefconfig

clang tested configs:
arm                       mainstone_defconfig
arm                        multi_v5_defconfig
mips                  cavium_octeon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
