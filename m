Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6E685C08
	for <lists+linux-efi@lfdr.de>; Wed,  1 Feb 2023 01:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBAAQj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 19:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBAAQi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 19:16:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3344345E;
        Tue, 31 Jan 2023 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675210596; x=1706746596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGcc5GCEMxGvL5mm0PL0tfMmHHnzeThTjrhfqHsD/iI=;
  b=icNvq+hdpgt/QFwpkL6o9p2nr/2MTVQVhjxiZ5TafBAKLPvQN4E+kX4X
   Kt33AU/mQTWm5xam6xNVzzlha3BkKAJGMIbegPsEPJKBN9sW12ueVy4l0
   Ts4TvxCDMgpsFjDaSu17Jw0UlW/pOTZcHGOUPT4891h1I6aMPZU9xlP07
   /O3xJ+EW1GqGah94HygIo31qlMBDn9WzntMdiCb1TiPINrqp58QRoYV4B
   2kAqZ0oZl7XdTlVGPD6UX2CrXnLSxVFfzOrAdavdvKauTTs7bOk/n/KLK
   w+BhzC4TjdYCjYLqX0V/43CNyRnM/DwgNdmpBZQ5EtSulMed+BuX/ue/d
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="330108531"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="330108531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 16:16:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="838579710"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="838579710"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2023 16:16:32 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN0ne-0004pS-39;
        Wed, 01 Feb 2023 00:16:30 +0000
Date:   Wed, 1 Feb 2023 08:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v3 2/6] riscv: Rework kasan population functions
Message-ID: <202302010819.RAsjyv6V-lkp@intel.com>
References: <20230125082333.1577572-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125082333.1577572-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Alexandre,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc6 next-20230131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Split-early-and-final-KASAN-population-functions/20230125-163113
patch link:    https://lore.kernel.org/r/20230125082333.1577572-3-alexghiti%40rivosinc.com
patch subject: [PATCH v3 2/6] riscv: Rework kasan population functions
config: riscv-randconfig-r006-20230201 (https://download.01.org/0day-ci/archive/20230201/202302010819.RAsjyv6V-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c18726e8d14edbd59ec19854b4eb06d83fff716f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Split-early-and-final-KASAN-population-functions/20230125-163113
        git checkout c18726e8d14edbd59ec19854b4eb06d83fff716f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/kasan_init.c:442:6: warning: no previous prototype for 'create_tmp_mapping' [-Wmissing-prototypes]
     442 | void create_tmp_mapping(void)
         |      ^~~~~~~~~~~~~~~~~~


vim +/create_tmp_mapping +442 arch/riscv/mm/kasan_init.c

   441	
 > 442	void create_tmp_mapping(void)
   443	{
   444		void *ptr;
   445		p4d_t *base_p4d;
   446	
   447		/*
   448		 * We need to clean the early mapping: this is hard to achieve "in-place",
   449		 * so install a temporary mapping like arm64 and x86 do.
   450		 */
   451		memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(pgd_t) * PTRS_PER_PGD);
   452	
   453		/* Copy the last p4d since it is shared with the kernel mapping. */
   454		if (pgtable_l5_enabled) {
   455			ptr = (p4d_t *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
   456			memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
   457			set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
   458				pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
   459			base_p4d = tmp_p4d;
   460		} else {
   461			base_p4d = (p4d_t *)tmp_pg_dir;
   462		}
   463	
   464		/* Copy the last pud since it is shared with the kernel mapping. */
   465		if (pgtable_l4_enabled) {
   466			ptr = (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KASAN_SHADOW_END)));
   467			memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
   468			set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
   469				pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
   470		}
   471	}
   472	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
