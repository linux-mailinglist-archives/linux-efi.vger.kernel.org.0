Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA8569C400
	for <lists+linux-efi@lfdr.de>; Mon, 20 Feb 2023 02:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBTBq5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 19 Feb 2023 20:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBTBq4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 19 Feb 2023 20:46:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628DC155
        for <linux-efi@vger.kernel.org>; Sun, 19 Feb 2023 17:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676857615; x=1708393615;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6+V66ibJse8Rrko9Cj4281E3HKjQzJBKMFFuGB1M09M=;
  b=iJqmZH/d38uxhcz/OHruxV9OEF9GIeF/gU1dBpX4zNVQSM+OxTRthlNB
   pkcp0+cVfBOduv07u+tvzJCMhINwH5UqoOpD2CFVI9c3XzX0Y8CdULGkE
   q/IR7nMJPtfh3851Fej6brNVajCpU8pgnAzcfYFtR+kMOhUfh1f8HLGcx
   /Rxn6cYkhWoJCUq8SRClNvTQ2ZLOETG2hP880FIJEruXwujQvxlYzgyC2
   NHK2AloNCSJWU6uiionjqk2gZXo7OfGrzZG1tPG9EHTWf07i+kszC0SFe
   zNIlD7KskO/bLAVrm4AF8aZS9/pWJKCRufLTjEwXSdFF5NLYZp32IdXJg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="334506338"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="334506338"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 17:46:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="620987970"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="620987970"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2023 17:46:53 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTvGW-000DXx-2Q;
        Mon, 20 Feb 2023 01:46:52 +0000
Date:   Mon, 20 Feb 2023 09:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS e1d447157f232c650e6f32c9fb89ff3d0207c69a
Message-ID: <63f2d0e7.KK7v5BDkDCok9RF2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
branch HEAD: e1d447157f232c650e6f32c9fb89ff3d0207c69a  firmware/efi sysfb_efi: Add quirk for Lenovo IdeaPad Duet 3

elapsed time: 722m

configs tested: 84
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230219
arc                        vdk_hs38_defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                      footbridge_defconfig
arm                            zeus_defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
ia64                                defconfig
ia64                      gensparse_defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                     asp8347_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                randconfig-r042-20230219
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
s390                 randconfig-r044-20230219
sh                               allmodconfig
sh                         apsh4a3a_defconfig
sh                          rsk7203_defconfig
sparc                               defconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3

clang tested configs:
arm                  randconfig-r046-20230219
hexagon              randconfig-r041-20230219
hexagon              randconfig-r045-20230219
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                        maltaup_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
