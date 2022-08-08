Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CEC58BEAC
	for <lists+linux-efi@lfdr.de>; Mon,  8 Aug 2022 03:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiHHB2p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Aug 2022 21:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHHB2o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Aug 2022 21:28:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0F2AFE;
        Sun,  7 Aug 2022 18:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659922123; x=1691458123;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=st6LjRLZeNJRrMDZN58ZGP4OS0SXLS7Z3FGsNNKPEH0=;
  b=k2I10/+KMa9StfWJqKb9A3ueMcdvVV61hGVQLypgYr7lNCM/v7a38QPD
   7WMr6DN91Fs1qm4d6GdC8ZHen8OJfnMe1thQMjm7Qvga5QlAbXxdvO4AX
   xRTAuV16LxryXUZMvLoQ0WRXRt8WYPQFpFjOEuun/2thkhWBhwpv8bEts
   g1jPa26/u5gY9lSJISOl4w4+UO6CIt/C/gJplh0/Z+JEO2ga6STL+fqi3
   qdI5vumyVJLW//M3JDjrZuusTt1AyxMyj7yvpCXjx9ZQwRsIzw7tt8+9x
   v2aulUWY/Sa715jZDApPWyAL2YG7OvAYAwOwZHONg7ve/JQ53UO5544VF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290487476"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="290487476"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 18:28:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931844646"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 18:28:36 -0700
Date:   Mon, 8 Aug 2022 09:28:34 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
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
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] drivers: serial: earlycon: Correct argument name
Message-ID: <YvBmwgtARNuKTIgB@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220806163255.10404-2-markuss.broks@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Markuss,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on efi/next staging/staging-testing usb/usb-testing linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220807/202208071111.oWn8uZfx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dedd7c138e9492439eeda05fa75a18bf19883a08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
        git checkout dedd7c138e9492439eeda05fa75a18bf19883a08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/earlycon.c:246:12: error: conflicting types for 'of_setup_earlycon'
   int __init of_setup_earlycon(const struct earlycon_id *match,
              ^
   include/linux/serial_core.h:708:12: note: previous declaration is here
   extern int of_setup_earlycon(const struct earlycon_id *match,
              ^
   1 error generated.


vim +/of_setup_earlycon +246 drivers/tty/serial/earlycon.c

8477614d9f7c5c Peter Hurley       2016-01-16  245  
c90fe9c0394b06 Peter Hurley       2016-01-16 @246  int __init of_setup_earlycon(const struct earlycon_id *match,
dedd7c138e9492 Markuss Broks      2022-08-06  247  			     int offset,
4d118c9a866590 Peter Hurley       2016-01-16  248  			     const char *options)
b0b6abd34c1b50 Rob Herring        2014-03-27  249  {
b0b6abd34c1b50 Rob Herring        2014-03-27  250  	int err;
b0b6abd34c1b50 Rob Herring        2014-03-27  251  	struct uart_port *port = &early_console_dev.port;
088da2a17619cf Peter Hurley       2016-01-16  252  	const __be32 *val;
088da2a17619cf Peter Hurley       2016-01-16  253  	bool big_endian;
c90fe9c0394b06 Peter Hurley       2016-01-16  254  	u64 addr;
b0b6abd34c1b50 Rob Herring        2014-03-27  255  
65e20e8cbbccaf Michael Walle      2022-06-28  256  	if (early_con.flags & CON_ENABLED)
65e20e8cbbccaf Michael Walle      2022-06-28  257  		return -EALREADY;
65e20e8cbbccaf Michael Walle      2022-06-28  258  
e1dd3bef6d03c9 Geert Uytterhoeven 2015-11-27  259  	spin_lock_init(&port->lock);
b0b6abd34c1b50 Rob Herring        2014-03-27  260  	port->iotype = UPIO_MEM;
dedd7c138e9492 Markuss Broks      2022-08-06  261  	addr = of_flat_dt_translate_address(offset);
c90fe9c0394b06 Peter Hurley       2016-01-16  262  	if (addr == OF_BAD_ADDR) {
c90fe9c0394b06 Peter Hurley       2016-01-16  263  		pr_warn("[%s] bad address\n", match->name);
c90fe9c0394b06 Peter Hurley       2016-01-16  264  		return -ENXIO;
c90fe9c0394b06 Peter Hurley       2016-01-16  265  	}
b0b6abd34c1b50 Rob Herring        2014-03-27  266  	port->mapbase = addr;
b0b6abd34c1b50 Rob Herring        2014-03-27  267  
dedd7c138e9492 Markuss Broks      2022-08-06  268  	val = of_get_flat_dt_prop(offset, "reg-offset", NULL);
088da2a17619cf Peter Hurley       2016-01-16  269  	if (val)
088da2a17619cf Peter Hurley       2016-01-16  270  		port->mapbase += be32_to_cpu(*val);
1f66dd36bb1843 Greentime Hu       2018-02-13  271  	port->membase = earlycon_map(port->mapbase, SZ_4K);
1f66dd36bb1843 Greentime Hu       2018-02-13  272  
dedd7c138e9492 Markuss Broks      2022-08-06  273  	val = of_get_flat_dt_prop(offset, "reg-shift", NULL);
088da2a17619cf Peter Hurley       2016-01-16  274  	if (val)
088da2a17619cf Peter Hurley       2016-01-16  275  		port->regshift = be32_to_cpu(*val);
dedd7c138e9492 Markuss Broks      2022-08-06  276  	big_endian = of_get_flat_dt_prop(offset, "big-endian", NULL) != NULL ||
088da2a17619cf Peter Hurley       2016-01-16  277  		(IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
dedd7c138e9492 Markuss Broks      2022-08-06  278  		 of_get_flat_dt_prop(offset, "native-endian", NULL) != NULL);
dedd7c138e9492 Markuss Broks      2022-08-06  279  	val = of_get_flat_dt_prop(offset, "reg-io-width", NULL);
088da2a17619cf Peter Hurley       2016-01-16  280  	if (val) {
088da2a17619cf Peter Hurley       2016-01-16  281  		switch (be32_to_cpu(*val)) {
088da2a17619cf Peter Hurley       2016-01-16  282  		case 1:
088da2a17619cf Peter Hurley       2016-01-16  283  			port->iotype = UPIO_MEM;
088da2a17619cf Peter Hurley       2016-01-16  284  			break;
088da2a17619cf Peter Hurley       2016-01-16  285  		case 2:
088da2a17619cf Peter Hurley       2016-01-16  286  			port->iotype = UPIO_MEM16;
088da2a17619cf Peter Hurley       2016-01-16  287  			break;
088da2a17619cf Peter Hurley       2016-01-16  288  		case 4:
088da2a17619cf Peter Hurley       2016-01-16  289  			port->iotype = (big_endian) ? UPIO_MEM32BE : UPIO_MEM32;
088da2a17619cf Peter Hurley       2016-01-16  290  			break;
088da2a17619cf Peter Hurley       2016-01-16  291  		default:
088da2a17619cf Peter Hurley       2016-01-16  292  			pr_warn("[%s] unsupported reg-io-width\n", match->name);
088da2a17619cf Peter Hurley       2016-01-16  293  			return -EINVAL;
088da2a17619cf Peter Hurley       2016-01-16  294  		}
088da2a17619cf Peter Hurley       2016-01-16  295  	}
088da2a17619cf Peter Hurley       2016-01-16  296  
dedd7c138e9492 Markuss Broks      2022-08-06  297  	val = of_get_flat_dt_prop(offset, "current-speed", NULL);
31cb9a8575ca04 Eugeniy Paltsev    2017-08-21  298  	if (val)
31cb9a8575ca04 Eugeniy Paltsev    2017-08-21  299  		early_console_dev.baud = be32_to_cpu(*val);
31cb9a8575ca04 Eugeniy Paltsev    2017-08-21  300  
dedd7c138e9492 Markuss Broks      2022-08-06  301  	val = of_get_flat_dt_prop(offset, "clock-frequency", NULL);
814453adea7d08 Michal Simek       2018-04-10  302  	if (val)
814453adea7d08 Michal Simek       2018-04-10  303  		port->uartclk = be32_to_cpu(*val);
814453adea7d08 Michal Simek       2018-04-10  304  
4d118c9a866590 Peter Hurley       2016-01-16  305  	if (options) {
31cb9a8575ca04 Eugeniy Paltsev    2017-08-21  306  		early_console_dev.baud = simple_strtoul(options, NULL, 0);
4d118c9a866590 Peter Hurley       2016-01-16  307  		strlcpy(early_console_dev.options, options,
4d118c9a866590 Peter Hurley       2016-01-16  308  			sizeof(early_console_dev.options));
4d118c9a866590 Peter Hurley       2016-01-16  309  	}
05d961320ba624 Peter Hurley       2016-01-16  310  	earlycon_init(&early_console_dev, match->name);
4d118c9a866590 Peter Hurley       2016-01-16  311  	err = match->setup(&early_console_dev, options);
f28295cc8ce14b Hsin-Yi Wang       2020-09-15  312  	earlycon_print_info(&early_console_dev);
b0b6abd34c1b50 Rob Herring        2014-03-27  313  	if (err < 0)
b0b6abd34c1b50 Rob Herring        2014-03-27  314  		return err;
b0b6abd34c1b50 Rob Herring        2014-03-27  315  	if (!early_console_dev.con->write)
b0b6abd34c1b50 Rob Herring        2014-03-27  316  		return -ENODEV;
b0b6abd34c1b50 Rob Herring        2014-03-27  317  
b0b6abd34c1b50 Rob Herring        2014-03-27  318  
b0b6abd34c1b50 Rob Herring        2014-03-27  319  	register_console(early_console_dev.con);
b0b6abd34c1b50 Rob Herring        2014-03-27  320  	return 0;
b0b6abd34c1b50 Rob Herring        2014-03-27  321  }
8477614d9f7c5c Peter Hurley       2016-01-16  322  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

