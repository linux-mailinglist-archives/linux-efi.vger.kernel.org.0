Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18268612007
	for <lists+linux-efi@lfdr.de>; Sat, 29 Oct 2022 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ2E0F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Oct 2022 00:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2E0E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Oct 2022 00:26:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F037E033
        for <linux-efi@vger.kernel.org>; Fri, 28 Oct 2022 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667017563; x=1698553563;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=POkQVgdP8udKg00VHiagVl8w0GexznPECGZ0Up+az7Q=;
  b=PndquCiZyQwdj4aikDaNYbqRYsQlAZ2r7vQopA7giDm0TDkOJy+T6vgG
   snakA5h2AhzJwiARMCgRyiChEXeHH/gGACa9zFsz9QDgqkTp7C270UMOA
   E14vz2Qvo2I9sI5YxASUQLnp0NqIJyyfuRtl2ahHmtjYwMpEBy5N1EtW7
   NzzHIseLUbLtUgSpya3zsZYDFtsqFl3Pbq5oLV9iwKbPFlmRi2Y8WMbCh
   +O0WYaWxQiVAuoJjsaMAVGCQn7e0USLT2n/ZziLrX8T2mzrKeXN2Ev5TH
   Fud7fuMyYGmO75oCv16Lshp71GipF9+2cw249/Rp2tQI4bcLUkxv3L2Tl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="307363279"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="307363279"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 21:26:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="722279319"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="722279319"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2022 21:26:02 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oodQ2-000Aa7-0X;
        Sat, 29 Oct 2022 04:26:02 +0000
Date:   Sat, 29 Oct 2022 12:25:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:next] BUILD SUCCESS 53ec9ccd138f6504fd5227a73dd8c6ab7a91f80f
Message-ID: <635cab1f.dUpGaip4n6Q/2cQx%lkp@intel.com>
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
branch HEAD: 53ec9ccd138f6504fd5227a73dd8c6ab7a91f80f  MAINTAINERS: adjust entry after arm64 efi-entry.S file movement

elapsed time: 722m

configs tested: 58
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
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
arc                  randconfig-r043-20221029
i386                          randconfig-a001
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
riscv                randconfig-r042-20221029
hexagon              randconfig-r041-20221029
hexagon              randconfig-r045-20221029
i386                          randconfig-a002
s390                 randconfig-r044-20221029
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
