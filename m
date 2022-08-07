Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331F858BAF7
	for <lists+linux-efi@lfdr.de>; Sun,  7 Aug 2022 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiHGNRp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Aug 2022 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiHGNRn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Aug 2022 09:17:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFE6577;
        Sun,  7 Aug 2022 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659878260; x=1691414260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cBxHBx3Qi0IAdNsBY4fZkCLfNUBPQ+PwsaBkaNTmSX8=;
  b=AceiR5CYq4EkSuYjUoLDreqEJUOzbCi3778Q+yIUZqiCKrnHlHISFcU2
   46vtPsoHp/XK79pBBv5sKbCvWv0KcZgiYf3Mn96mhsX1ZzLn45SZaj4PE
   h8sJUG+6bUemwDVXIRJthiMEJ9bQybuRCC4lphSGVKRTBqJv3C59WZOW6
   wxIBkh2uuapZgOOratztTNpnZjd1MXsQecGjuqkg5UtEfiOKF9Uz6LfR5
   SCnHppwZ/O3XWULaUO6oWCLNyzt0A1fRa/qzZrbDO45KzcGvoOxAxICEy
   jnSHjmpOxvBW6Imd4Pd+w6kxjijvGiS0jOTEYX8OFPkx6hUgqNau8wH7S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="354436929"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="354436929"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 06:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="707129955"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2022 06:17:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKg9s-000LJq-2a;
        Sun, 07 Aug 2022 13:17:32 +0000
Date:   Sun, 7 Aug 2022 21:16:40 +0800
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
Message-ID: <202208072145.yWoGkrW1-lkp@intel.com>
References: <20220806163255.10404-4-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806163255.10404-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220807/202208072145.yWoGkrW1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/97dfc2aa69b065de769a191352afe2099c52fedb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
        git checkout 97dfc2aa69b065de769a191352afe2099c52fedb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/console/earlycon.c:7:10: fatal error: asm/early_ioremap.h: No such file or directory
       7 | #include <asm/early_ioremap.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +7 drivers/video/console/earlycon.c

   > 7	#include <asm/early_ioremap.h>
     8	#include <linux/console.h>
     9	#include <linux/efi.h>
    10	#include <linux/font.h>
    11	#include <linux/io.h>
    12	#include <linux/kernel.h>
    13	#include <linux/mm.h>
    14	#include <linux/of.h>
    15	#include <linux/of_fdt.h>
    16	#include <linux/serial_core.h>
    17	#include <linux/screen_info.h>
    18	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
