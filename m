Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50905591ED5
	for <lists+linux-efi@lfdr.de>; Sun, 14 Aug 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiHNHFy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Aug 2022 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHNHFx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 14 Aug 2022 03:05:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DFA638E;
        Sun, 14 Aug 2022 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660460753; x=1691996753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4tl8ZYGeFhA+U5umZeSuWeZdwow0wgZ4xqCXX2El6g=;
  b=kWvKwX7OzNs1TUZsS9yMEWQHdEB3sblq+R5Fh2Ze1GOt4AfelNr7+LmY
   6H5ejAD/h+c/FvGfxb4o5oh33Cux77Md4EoYv+8n/1j6kQjvV2ep9jgSE
   lp/oVg/3QRcC7CUpryTpBVFxqQxAhsR8VzdozcS2GfE6oPyeJVMStkccF
   L3dyiXovgMtgLpzoWxud9uG53yeMK6XB8ZhXYoxH4XOG3IgUxaQhMvE/F
   uUv212PP1sGnKWCl3bRTcnXhjDZayMxxqy1siL2D/g5og3SM3wHXrMALy
   NrYTNazXPoG52um4p+MZ3LnabiO2BkwFm2QkLiY1kjQDPXOl/gBaywyY5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292599116"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292599116"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 00:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="695675504"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2022 00:05:46 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN7gv-0002bb-1c;
        Sun, 14 Aug 2022 07:05:45 +0000
Date:   Sun, 14 Aug 2022 15:04:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
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
Message-ID: <202208141430.Ez8EkEwO-lkp@intel.com>
References: <20220806163255.10404-4-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806163255.10404-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-kismet-CONFIG_FB_EARLYCON-CONFIG_EFI_EARLYCON-0-0 (https://download.01.org/0day-ci/archive/20220814/202208141430.Ez8EkEwO-lkp@intel.com/config)
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/97dfc2aa69b065de769a191352afe2099c52fedb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-generic-framebuffer-support-to-EFI-earlycon-driver/20220807-003646
        git checkout 97dfc2aa69b065de769a191352afe2099c52fedb
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_FB_EARLYCON --selectors CONFIG_EFI_EARLYCON -a=x86_64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=x86_64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FB_EARLYCON when selected by EFI_EARLYCON
   
   WARNING: unmet direct dependencies detected for FB_EARLYCON
     Depends on [n]: VT [=y] && SERIAL_EARLYCON [=n] && !ARM && !IA64
     Selected by [y]:
     - EFI_EARLYCON [=y] && EFI [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
