Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789F7B60BD
	for <lists+linux-efi@lfdr.de>; Tue,  3 Oct 2023 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJCG0y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Oct 2023 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjJCG0x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Oct 2023 02:26:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B146B8;
        Mon,  2 Oct 2023 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696314409; x=1727850409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEQY+v+Ij8ADUmJrIg7SKb1xUBWafpNeo9oPU2Mazic=;
  b=W34v7KfGW4q9tCWEnBWSPeRqspGdpcgyRtuQJALmP41VxAlKRJspnd7H
   Iz0t3tT5+0CVzNwmfJQSXNJSPDaEhp2gaJq5YSMIgUHjQGsv/qPC7YPdB
   GGSWLtd9IdfZG79tCSe5oE2mjaFMaKabh9TLczmIHoew0oVVd012YdEh1
   Z346zJn7xdsaykOngSqaGwS6HUSE2l9O2lc4GcM51RWmG6JBaPP17UkvO
   SPDl1KfAm/IwaOf6m0fVUEpOXm8+l4umw4gSemllvxniK+p4UrgvzDcXr
   1rpB3DWhmaGi3I3pMHubBFcpSCGdiYV1pabmluM9kX6rnTKgxXOhhrRV1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="373145751"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="373145751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="924530368"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="924530368"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Oct 2023 23:26:43 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnYrh-0006qP-2N;
        Tue, 03 Oct 2023 06:26:41 +0000
Date:   Tue, 3 Oct 2023 14:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 2/5] mm: Introduce pudp/p4dp/pgdp_get() functions
Message-ID: <202310031431.NkMgiRBL-lkp@intel.com>
References: <20231002151031.110551-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002151031.110551-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc4 next-20231003]
[cannot apply to efi/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Use-WRITE_ONCE-when-setting-page-table-entries/20231002-231725
base:   linus/master
patch link:    https://lore.kernel.org/r/20231002151031.110551-3-alexghiti%40rivosinc.com
patch subject: [PATCH 2/5] mm: Introduce pudp/p4dp/pgdp_get() functions
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310031431.NkMgiRBL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310031431.NkMgiRBL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310031431.NkMgiRBL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm.h:29,
                    from arch/arm/kernel/asm-offsets.c:12:
>> include/linux/pgtable.h:310:21: error: 'pgdp_get' declared as function returning an array
     310 | static inline pgd_t pgdp_get(pgd_t *pgdp)
         |                     ^~~~~~~~
   In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:246,
                    from arch/arm/kernel/asm-offsets.c:10:
   include/linux/pgtable.h: In function 'pgdp_get':
>> include/asm-generic/rwonce.h:48:2: warning: returning 'const volatile pmdval_t *' {aka 'const volatile unsigned int *'} from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
      48 | ({                                                                      \
         | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |         __READ_ONCE(x);                                                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      51 | })
         | ~~
   include/linux/pgtable.h:312:16: note: in expansion of macro 'READ_ONCE'
     312 |         return READ_ONCE(*pgdp);
         |                ^~~~~~~~~
   make[3]: *** [scripts/Makefile.build:116: arch/arm/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1202: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/pgdp_get +310 include/linux/pgtable.h

   308	
   309	#ifndef pgdp_get
 > 310	static inline pgd_t pgdp_get(pgd_t *pgdp)
   311	{
   312		return READ_ONCE(*pgdp);
   313	}
   314	#endif
   315	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
