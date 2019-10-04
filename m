Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705EECC465
	for <lists+linux-efi@lfdr.de>; Fri,  4 Oct 2019 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfJDUpq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 16:45:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:19143 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfJDUpq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Oct 2019 16:45:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 13:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="gz'50?scan'50,208,50";a="367495432"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2019 13:45:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGUSJ-0000rT-4j; Sat, 05 Oct 2019 04:45:39 +0800
Date:   Sat, 5 Oct 2019 04:45:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@01.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
Message-ID: <201910050403.4uYM2RUW%lkp@intel.com>
References: <20191004145056.43267-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7n4ar6jw5vlgwqx6"
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-5-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--7n4ar6jw5vlgwqx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

I love your patch! Yet something to improve:

[auto build test ERROR on efi/next]
[cannot apply to v5.4-rc1 next-20191004]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/efi-firmware-platform-x86-Add-EFI-embedded-fw-support/20191005-021239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/firmware_loader/fallback_platform.o:(.opd+0x0): multiple definition of `fw_grow_paged_buf'
   drivers/base/firmware_loader/main.o:(.opd+0x1e0): first defined here
   drivers/base/firmware_loader/fallback_platform.o: In function `.fw_grow_paged_buf':
   fallback_platform.c:(.text+0x0): multiple definition of `.fw_grow_paged_buf'
   drivers/base/firmware_loader/main.o:main.c:(.text+0x10e0): first defined here
>> drivers/base/firmware_loader/fallback_platform.o:(.opd+0x18): multiple definition of `fw_map_paged_buf'
   drivers/base/firmware_loader/main.o:(.opd+0x1f8): first defined here
   drivers/base/firmware_loader/fallback_platform.o: In function `.fw_map_paged_buf':
   fallback_platform.c:(.text+0x30): multiple definition of `.fw_map_paged_buf'
   drivers/base/firmware_loader/main.o:main.c:(.text+0x1110): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--7n4ar6jw5vlgwqx6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
VBFUnQEA

--7n4ar6jw5vlgwqx6--
