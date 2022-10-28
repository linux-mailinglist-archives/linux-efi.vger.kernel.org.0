Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3972610925
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 06:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJ1ECH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ1ECG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 00:02:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCEDB55D
        for <linux-efi@vger.kernel.org>; Thu, 27 Oct 2022 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666929724; x=1698465724;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=71kV4kntg8+hxP3zWilx5eO7bK0luagYfaLRVFo7ycY=;
  b=c6WrbrwfVMAdKpo0dxbokMcFxXSuYtltUUSx5x9grstYMF/qRjOJC2la
   UC1hrA79v2XA3+S9h+rXCYsIhrevqoBN+zaY2jIaw/IziQrxjGzZaCudI
   u/CEvkTIiGKNzyG1frFE330zZTwVJX8194WQKrjEFdVF1GUKITHW5ck4n
   KXhWPEFKiF07X7LmxKWo4Q5h17haJ17b50W/DEozcW9ORwUnotDs3PR0f
   FQz7WqeXM1VsLQtCPnATXMtzpOKpdAqWGJc5nTbwpn48hdyuyi1vNLY05
   DWr+bj78wMo0po0XwsD0I/atHwfxord17LC0bFzs8EDAXrGYigvkO9xgc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="335042353"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="335042353"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 21:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="775236746"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="775236746"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2022 21:02:03 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooGZH-0009TP-0M;
        Fri, 28 Oct 2022 04:02:03 +0000
Date:   Fri, 28 Oct 2022 12:01:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [efi:urgent] BUILD SUCCESS
 4f50f041554c78aaa821585ce583946ecdae91b3
Message-ID: <635b5431.C3KEUasXFSIP4ZCY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
branch HEAD: 4f50f041554c78aaa821585ce583946ecdae91b3  efi: efivars: Fix variable writes with unsupported query_variable_store()

elapsed time: 724m

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
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
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
