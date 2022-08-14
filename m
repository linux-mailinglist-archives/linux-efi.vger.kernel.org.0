Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD0591D31
	for <lists+linux-efi@lfdr.de>; Sun, 14 Aug 2022 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiHNABn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 13 Aug 2022 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNABm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 13 Aug 2022 20:01:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CA518B03;
        Sat, 13 Aug 2022 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660435300; x=1691971300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ki15VuR/ZcrHb6KOsI4Hb28mSfS0dHDolz9tJFyhME=;
  b=Np4Z0EnSBaSouKZRCiG3j10gJ8VaArpWHEqS6HVtjliIeBL905Ej61ba
   tJmeN+nsgAkTynBHLA2bsi8N0jgn+npKpEv4o0bn2vp7/1+E1ZrQOhyPx
   6MKdYy/h34uTgWtT0mkP8nY9GeEjkHUkzLTWKLmBrz041HcMsED/friEl
   bjS4CacaUrkLtW4Vwzpu4/BXy1SadvI467OVoYcgrf3fQduwS4SZWASev
   zX4YwZ+iL/L7u+SLCY/WZ+q/oieB8BaJMyivAjclRaeSEQMYk++7nnVey
   0RFbf7Ln50WdObKU1TDe3OoHOM8qlmBDJlM8DxNiebNQM4JBi+wK3n9Re
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274839294"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274839294"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 17:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="851912119"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2022 17:01:34 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN14P-0002Cw-1K;
        Sun, 14 Aug 2022 00:01:33 +0000
Date:   Sun, 14 Aug 2022 08:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] efi: earlycon: Add support for generic
 framebuffers and move to console subsystem
Message-ID: <202208140705.bU9i1c1t-lkp@intel.com>
References: <20220806163255.10404-4-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806163255.10404-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Markuss,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on efi/next staging/staging-testing usb/usb-testing linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: loongarch-randconfig-s031-20220807 (https://download.01.org/0day-ci/archive/20220814/202208140705.bU9i1c1t-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/97dfc2aa69b065de769a191352afe2099c52fedb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
        git checkout 97dfc2aa69b065de769a191352afe2099c52fedb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/video/console/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/console/earlycon.c:43:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *static [toplevel] virt_base @@     got void * @@
   drivers/video/console/earlycon.c:43:24: sparse:     expected void [noderef] __iomem *static [toplevel] virt_base
   drivers/video/console/earlycon.c:43:24: sparse:     got void *
>> drivers/video/console/earlycon.c:53:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *static [toplevel] virt_base @@
   drivers/video/console/earlycon.c:53:30: sparse:     expected void *addr
   drivers/video/console/earlycon.c:53:30: sparse:     got void [noderef] __iomem *static [toplevel] virt_base
>> drivers/video/console/earlycon.c:63:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/video/console/earlycon.c:63:39: sparse:     expected void *
   drivers/video/console/earlycon.c:63:39: sparse:     got void [noderef] __iomem *
>> drivers/video/console/earlycon.c:74:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *addr @@
   drivers/video/console/earlycon.c:74:24: sparse:     expected void [noderef] __iomem *addr
   drivers/video/console/earlycon.c:74:24: sparse:     got void *addr

vim +43 drivers/video/console/earlycon.c

    29	
    30	static int __init simplefb_earlycon_remap_fb(void)
    31	{
    32		unsigned long mapping;
    33		/* bail if there is no bootconsole or it has been disabled already */
    34		if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
    35			return 0;
    36	
    37		if (region_intersects(info.phys_base, info.size,
    38				      IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE) == REGION_INTERSECTS)		
    39			mapping = MEMREMAP_WB;
    40		else
    41			mapping = MEMREMAP_WC;
    42	
  > 43		info.virt_base = memremap(info.phys_base, info.size, mapping);
    44	
    45		return info.virt_base ? 0 : -ENOMEM;
    46	}
    47	early_initcall(simplefb_earlycon_remap_fb);
    48	
    49	static int __init simplefb_earlycon_unmap_fb(void)
    50	{
    51		/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
    52		if (info.virt_base && !(earlycon_console->flags & CON_ENABLED))
  > 53			memunmap(info.virt_base);
    54		return 0;
    55	}
    56	late_initcall(simplefb_earlycon_unmap_fb);
    57	
    58	static __ref void *simplefb_earlycon_map(unsigned long start, unsigned long len)
    59	{
    60		pgprot_t fb_prot;
    61	
    62		if (info.virt_base)
  > 63			return info.virt_base + start;
    64	
    65		fb_prot = PAGE_KERNEL;
    66		return early_memremap_prot(info.phys_base + start, len, pgprot_val(fb_prot));
    67	}
    68	
    69	static __ref void simplefb_earlycon_unmap(void *addr, unsigned long len)
    70	{
    71		if (info.virt_base)
    72			return;
    73	
  > 74		early_memunmap(addr, len);
    75	}
    76	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
