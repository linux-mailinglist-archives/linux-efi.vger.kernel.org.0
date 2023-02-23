Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E66A046E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Feb 2023 10:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjBWJFA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Feb 2023 04:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjBWJE7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Feb 2023 04:04:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2A1EFF2;
        Thu, 23 Feb 2023 01:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677143097; x=1708679097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aMyQiWvbMl65ylmtjMOe+6sCCSBD4Sp3BmO5j1inQiA=;
  b=b5tYqOY7+pZ8CWaJBfZBerHl4jmJbVmWM2tZSIUfNjY8SFhXN7Gfqnut
   Moy9dOrikEtUL/dOr71Xc0aQH3pfbRu1sN7lTvPIQqXHhp9lAvQgA5dFl
   JZ5GJtEGG08GCcYrZbchRPqc0UBKClY/YniIJMwOslJddBagetUs7CDyc
   3361CWFcmyRF+YjS0WXSq/nZ3FD8zX3Sp0I05PptFTTg05qNg/3EzGDb7
   qEKNxbj/yZHGeL7DVruizvY3/jAKyAYF8KJDvhqkuu6jmcBRxuKJQ5hT+
   ZKV0PNy5GGSNqC44XjnkDkoHp8q7pSkoO/i4Z9WW7Rt0VYN1P2fod3Nv2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335362535"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="335362535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 01:04:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="622259210"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="622259210"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2023 01:04:55 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV7X4-0001Cb-07;
        Thu, 23 Feb 2023 09:04:54 +0000
Date:   Thu, 23 Feb 2023 17:03:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
Message-ID: <202302231642.tyrVwZMY-lkp@intel.com>
References: <20230126112129.4602-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126112129.4602-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20230223/202302231642.tyrVwZMY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/da57163cc9d947884520240ec71c2806f48b8a64
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johan-Hovold/efivarfs-fix-NULL-deref-on-mount-when-no-efivars/20230128-094525
        git checkout da57163cc9d947884520240ec71c2806f48b8a64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302231642.tyrVwZMY-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/efivarfs/super.c: In function 'efivarfs_kill_sb':
>> fs/efivarfs/super.c:246:14: error: implicit declaration of function 'efivar_is_available'; did you mean 'slab_is_available'? [-Werror=implicit-function-declaration]
     246 |         if (!efivar_is_available())
         |              ^~~~~~~~~~~~~~~~~~~
         |              slab_is_available
   cc1: some warnings being treated as errors


vim +246 fs/efivarfs/super.c

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
