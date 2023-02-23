Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CC6A0598
	for <lists+linux-efi@lfdr.de>; Thu, 23 Feb 2023 11:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjBWKGX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Feb 2023 05:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWKGS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Feb 2023 05:06:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5010D38033;
        Thu, 23 Feb 2023 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677146777; x=1708682777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G1eyd6plZRhl7C9gSgBC4jqgdrPdoVIj9daKdi61y44=;
  b=bST57cjvPhZ/OYofPSybTP7Zt9b8UcycIVHC68repCVQpb2zRviMBVv9
   vjiFLkSZdRzx42jr+Ke5qrRfcW6xGq61XvBb7Znjuz+rB9+CNdmH++yWN
   738HOYMcaZFi8/n6LHzN5n8GgClQJmq6JrCR3EQM+KGDdapSSxfgXKYfh
   4DLVRmMYkKit7hPht3LeoRVH3PgqMWCNeB7SI5ytK8YNUheDGHszc4woC
   KnWFVT65yS0nOG1B0dpLzF8axIj8BzID962mXxasNP8aIFi+oHBXHru9Q
   +UbRmFsKMl4nJDYXW26C/ltQekV2NjAXe0Rt5aebmQuV8fT9Ndg5bAq1b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="312797173"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="312797173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="736302469"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="736302469"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2023 02:05:56 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV8U7-0001Ev-1P;
        Thu, 23 Feb 2023 10:05:55 +0000
Date:   Thu, 23 Feb 2023 18:05:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
Message-ID: <202302231733.iymwHTPf-lkp@intel.com>
References: <20230126112129.4602-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126112129.4602-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Johan,

I love your patch! Yet something to improve:

[auto build test ERROR on v6.2-rc5]
[also build test ERROR on linus/master]
[cannot apply to efi/next next-20230223]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/efivarfs-fix-NULL-deref-on-mount-when-no-efivars/20230128-094525
patch link:    https://lore.kernel.org/r/20230126112129.4602-1-johan%2Blinaro%40kernel.org
patch subject: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20230223/202302231733.iymwHTPf-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/da57163cc9d947884520240ec71c2806f48b8a64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johan-Hovold/efivarfs-fix-NULL-deref-on-mount-when-no-efivars/20230128-094525
        git checkout da57163cc9d947884520240ec71c2806f48b8a64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231733.iymwHTPf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/efivarfs/super.c:246:7: error: implicit declaration of function 'efivar_is_available' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (!efivar_is_available())
                ^
   fs/efivarfs/super.c:246:7: note: did you mean 'slab_is_available'?
   include/linux/slab.h:171:6: note: 'slab_is_available' declared here
   bool slab_is_available(void);
        ^
   1 error generated.


vim +/efivar_is_available +246 fs/efivarfs/super.c

   241	
   242	static void efivarfs_kill_sb(struct super_block *sb)
   243	{
   244		kill_litter_super(sb);
   245	
 > 246		if (!efivar_is_available())
   247			return;
   248	
   249		/* Remove all entries and destroy */
   250		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
   251	}
   252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
