Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07713D7AE1
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhG0Q0Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 12:26:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:58614 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhG0Q0Y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 27 Jul 2021 12:26:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="273559672"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="gz'50?scan'50,208,50";a="273559672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="gz'50?scan'50,208,50";a="437374769"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2021 09:26:18 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m8PuM-00070G-7T; Tue, 27 Jul 2021 16:26:18 +0000
Date:   Wed, 28 Jul 2021 00:25:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
Message-ID: <202107280030.4S0gMul2-lkp@intel.com>
References: <20210727050447.7339-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Randy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20210726]
[cannot apply to efi/next linux/master linus/master v5.14-rc3 v5.14-rc2 v5.14-rc1 v5.14-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Randy-Dunlap/efi-sysfb_efi-fix-build-when-EFI-is-not-set/20210727-130620
base:    2265c5286967c58db9a99ed1b74105977507e690
config: x86_64-randconfig-a006-20210727 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c658b472f3e61e1818e1909bf02f3d65470018a5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://github.com/0day-ci/linux/commit/1b739039e35b622cdf14dcfdc9d24862aeb4a711
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Randy-Dunlap/efi-sysfb_efi-fix-build-when-EFI-is-not-set/20210727-130620
        git checkout 1b739039e35b622cdf14dcfdc9d24862aeb4a711
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous prototype for function 'efifb_setup_from_dmi' [-Wmissing-prototypes]
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
        ^
   drivers/firmware/efi/sysfb_efi.c:72:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
   ^
   static 
>> drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable 'efifb_dmi_system_table' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:240:35: warning: unused variable 'efifb_dmi_swap_width_height' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:331:39: warning: unused variable 'efifb_fwnode_ops' [-Wunused-const-variable]
   static const struct fwnode_operations efifb_fwnode_ops = {
                                         ^
   4 warnings generated.


vim +/efifb_dmi_system_table +190 drivers/firmware/efi/sysfb_efi.c

2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  178  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  179  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  180  	{							\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  181  		efifb_set_system,				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  182  		name,						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  183  		{						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  184  			DMI_MATCH(DMI_BIOS_VENDOR, vendor),	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  185  			DMI_MATCH(DMI_PRODUCT_NAME, name)	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  186  		},						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  187  		&efifb_dmi_list[enumid]				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  188  	}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  189  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02 @190  static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  191  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  192  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  193  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  194  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  195  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  196  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  197  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  198  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac7,1", M_I20_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  199  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac8,1", M_I24_8_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  200  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac10,1", M_I24_10_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  201  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac11,1", M_I27_11_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  202  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "Macmini1,1", M_MINI),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  203  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini3,1", M_MINI_3_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  204  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini4,1", M_MINI_4_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  205  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook1,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  206  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  207  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  208  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  209  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  210  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  211  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  212  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook4,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  213  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook5,1", M_MB_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  214  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook6,1", M_MB_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  215  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook7,1", M_MB_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  216  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir1,1", M_MBA),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  217  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir3,1", M_MBA_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  218  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro1,1", M_MBP),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  219  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  220  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,2", M_MBP_2_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  221  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  222  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  223  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  224  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro4,1", M_MBP_4),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  225  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,1", M_MBP_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  226  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,2", M_MBP_5_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  227  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,3", M_MBP_5_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  228  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,1", M_MBP_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  229  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,2", M_MBP_6_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  230  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro7,1", M_MBP_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  231  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro8,2", M_MBP_8_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  232  	{},
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  233  };
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  234  
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  235  /*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  236   * Some devices have a portrait LCD but advertise a landscape resolution (and
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  237   * pitch). We simply swap width and height for these devices so that we can
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  238   * correctly deal with some of them coming with multiple resolutions.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  239   */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21 @240  static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  241  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  242  		/*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  243  		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  244  		 * 800x1280 portrait screen. Luckily the portrait version has
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  245  		 * its own BIOS version, so we match on that.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  246  		 */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  247  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  248  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  249  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  250  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  251  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  252  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  253  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  254  		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  255  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  256  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  257  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  258  					"Lenovo MIIX 320-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  259  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  260  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  261  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  262  		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  263  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  264  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  265  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  266  					"Lenovo ideapad D330-10IGM"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  267  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  268  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  269  	{},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  270  };
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  271  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  272  static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  273  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  274  	u64 fb_base = screen_info.lfb_base;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  275  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  276  	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  277  		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  278  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  279  	return fb_base >= range->cpu_addr &&
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  280  	       fb_base < (range->cpu_addr + range->size);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  281  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  282  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  283  static struct device_node *find_pci_overlap_node(void)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  284  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  285  	struct device_node *np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  286  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  287  	for_each_node_by_type(np, "pci") {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  288  		struct of_pci_range_parser parser;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  289  		struct of_pci_range range;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  290  		int err;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  291  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  292  		err = of_pci_range_parser_init(&parser, np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  293  		if (err) {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  294  			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  295  			continue;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  296  		}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  297  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  298  		for_each_of_pci_range(&parser, &range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  299  			if (efifb_overlaps_pci_range(&range))
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  300  				return np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  301  	}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  302  	return NULL;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  303  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  304  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  305  /*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  306   * If the efifb framebuffer is backed by a PCI graphics controller, we have
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  307   * to ensure that this relation is expressed using a device link when
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  308   * running in DT mode, or the probe order may be reversed, resulting in a
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  309   * resource reservation conflict on the memory window that the efifb
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  310   * framebuffer steals from the PCIe host bridge.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  311   */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  312  static int efifb_add_links(struct fwnode_handle *fwnode)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  313  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  314  	struct device_node *sup_np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  315  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  316  	sup_np = find_pci_overlap_node();
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  317  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  318  	/*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  319  	 * If there's no PCI graphics controller backing the efifb, we are
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  320  	 * done here.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  321  	 */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  322  	if (!sup_np)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  323  		return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  324  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  325  	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  326  	of_node_put(sup_np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  327  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  328  	return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  329  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  330  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25 @331  static const struct fwnode_operations efifb_fwnode_ops = {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  332  	.add_links = efifb_add_links,
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  333  };
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  334  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
mO/OuiWvPIrExuX/B0iAnBWNcgIA

--82I3+IH0IqGh5yIs--
