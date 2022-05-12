Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CDA5254A8
	for <lists+linux-efi@lfdr.de>; Thu, 12 May 2022 20:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiELSWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 May 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357591AbiELSWu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 May 2022 14:22:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726635D64A;
        Thu, 12 May 2022 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379768; x=1683915768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lMp0wN6+3oR5lan9YwIxjQ08ZrF0e3S9TFAB75U+44=;
  b=XjYlTGeKdyr4DwnhSpNA4+ymdmhh3bU7Garrw+0unxbFMBJDwBJH7K7p
   NjEakCgAu/uOzdiuQtQ/a8vV0i6EwAarqubsRXHj6VQa8hMwwWJRoF9BX
   KmeNbJNt66mzspl2sYyrVHN6xjRh0heK03EnMLKRYWIcZ065AVeHCXshl
   mbOwYzV+KVRNgNNm1IIkTLqhwJmB86jliH5KxLmiC4MeSk4NEoHmH8N9C
   1zrABXSV+U5Q4T98xutMGY6bmks1DAHohTADJQ/YTLa3DKi3YJuB12XuA
   J7KZQv+xT1aa8E8Ffnvj7iQZ9MM8ZA+uxJWlLkMzL97Owm5WJM68hgTYR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250002591"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250002591"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="566828491"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2022 11:22:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npDSW-000Knx-80;
        Thu, 12 May 2022 18:22:44 +0000
Date:   Fri, 13 May 2022 02:22:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Tom Rini <trini@konsulko.com>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/5] block: add partition parser for U-Boot uImage.FIT
Message-ID: <202205130213.kRDmMP6B-lkp@intel.com>
References: <YnjxXASWU5Ps9ZoA@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnjxXASWU5Ps9ZoA@makrotopia.org>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on mtd/mtd/next mtd/mtd/fixes v5.18-rc6 next-20220512]
[cannot apply to rw-ubifs/next rw-ubifs/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/partition-parser-for-U-Boot-s-uImage-FIT/20220509-185349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: xtensa-buildonly-randconfig-r001-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130213.kRDmMP6B-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5a69884cfc6091e8d7c5491fbf57dd5e13cd5ee8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Golle/partition-parser-for-U-Boot-s-uImage-FIT/20220509-185349
        git checkout 5a69884cfc6091e8d7c5491fbf57dd5e13cd5ee8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x11c): undefined reference to `fdt_check_header'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x262): undefined reference to `fdt_check_header'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x124): undefined reference to `fdt_path_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x320): undefined reference to `fdt_path_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x128): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x337): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x130): undefined reference to `fdt_subnode_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x356): undefined reference to `fdt_subnode_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x138): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x382): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x13c): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x397): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x148): undefined reference to `fdt_path_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x3e3): undefined reference to `fdt_path_offset'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x150): undefined reference to `fdt_first_subnode'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x412): undefined reference to `fdt_first_subnode'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x154): undefined reference to `fdt_get_name'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x423): undefined reference to `fdt_get_name'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x158): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x43a): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x15c): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x44b): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
   fit.c:(.text+0x160): undefined reference to `fdt_getprop'
   xtensa-linux-ld: block/partitions/fit.o:fit.c:(.text+0x45f): more undefined references to `fdt_getprop' follow
   xtensa-linux-ld: block/partitions/fit.o: in function `put_page':
>> fit.c:(.text+0x184): undefined reference to `fdt_next_subnode'
   xtensa-linux-ld: block/partitions/fit.o: in function `parse_fit_partitions':
   fit.c:(.text+0x6ae): undefined reference to `fdt_next_subnode'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
