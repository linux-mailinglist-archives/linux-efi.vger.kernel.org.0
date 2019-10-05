Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD3CC889
	for <lists+linux-efi@lfdr.de>; Sat,  5 Oct 2019 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfJEHOZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Oct 2019 03:14:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:43172 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEHOZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 5 Oct 2019 03:14:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 00:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,259,1566889200"; 
   d="gz'50?scan'50,208,50";a="199061132"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2019 00:14:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGeGe-0000xD-Ts; Sat, 05 Oct 2019 15:14:16 +0800
Date:   Sat, 5 Oct 2019 15:13:43 +0800
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
        linux-input@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 7/8] platform/x86: touchscreen_dmi: Add EFI embedded
 firmware info support
Message-ID: <201910051508.UGYJAuMc%lkp@intel.com>
References: <20191004145056.43267-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="b6izvrxsd6cxpbvx"
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-8-hdegoede@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--b6izvrxsd6cxpbvx
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
config: x86_64-randconfig-a004-201939 (attached as .config)
compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/firmware/efi/embedded-firmware.c: In function 'efi_check_md_for_embedded_firmware':
>> drivers/firmware/efi/embedded-firmware.c:64:3: error: implicit declaration of function 'sha256_init' [-Werror=implicit-function-declaration]
      sha256_init(&sctx);
      ^
>> drivers/firmware/efi/embedded-firmware.c:65:3: error: implicit declaration of function 'sha256_update' [-Werror=implicit-function-declaration]
      sha256_update(&sctx, map + i, desc->length);
      ^
   drivers/firmware/efi/embedded-firmware.c:66:3: error: implicit declaration of function 'sha256_final' [-Werror=implicit-function-declaration]
      sha256_final(&sctx, sha256);
      ^
   cc1: some warnings being treated as errors

vim +/sha256_init +64 drivers/firmware/efi/embedded-firmware.c

3977d46d946ae2 Hans de Goede 2019-10-04  32  
3977d46d946ae2 Hans de Goede 2019-10-04  33  /*
3977d46d946ae2 Hans de Goede 2019-10-04  34   * Note the efi_check_for_embedded_firmwares() code currently makes the
3977d46d946ae2 Hans de Goede 2019-10-04  35   * following 2 assumptions. This may needs to be revisited if embedded firmware
3977d46d946ae2 Hans de Goede 2019-10-04  36   * is found where this is not true:
3977d46d946ae2 Hans de Goede 2019-10-04  37   * 1) The firmware is only found in EFI_BOOT_SERVICES_CODE memory segments
3977d46d946ae2 Hans de Goede 2019-10-04  38   * 2) The firmware always starts at an offset which is a multiple of 8 bytes
3977d46d946ae2 Hans de Goede 2019-10-04  39   */
3977d46d946ae2 Hans de Goede 2019-10-04  40  static int __init efi_check_md_for_embedded_firmware(
3977d46d946ae2 Hans de Goede 2019-10-04  41  	efi_memory_desc_t *md, const struct efi_embedded_fw_desc *desc)
3977d46d946ae2 Hans de Goede 2019-10-04  42  {
3977d46d946ae2 Hans de Goede 2019-10-04  43  	const u64 prefix = *((u64 *)desc->prefix);
3977d46d946ae2 Hans de Goede 2019-10-04  44  	struct sha256_state sctx;
3977d46d946ae2 Hans de Goede 2019-10-04  45  	struct embedded_fw *fw;
3977d46d946ae2 Hans de Goede 2019-10-04  46  	u8 sha256[32];
3977d46d946ae2 Hans de Goede 2019-10-04  47  	u64 i, size;
3977d46d946ae2 Hans de Goede 2019-10-04  48  	void *map;
3977d46d946ae2 Hans de Goede 2019-10-04  49  
3977d46d946ae2 Hans de Goede 2019-10-04  50  	size = md->num_pages << EFI_PAGE_SHIFT;
3977d46d946ae2 Hans de Goede 2019-10-04  51  	map = memremap(md->phys_addr, size, MEMREMAP_WB);
3977d46d946ae2 Hans de Goede 2019-10-04  52  	if (!map) {
3977d46d946ae2 Hans de Goede 2019-10-04  53  		pr_err("Error mapping EFI mem at %#llx\n", md->phys_addr);
3977d46d946ae2 Hans de Goede 2019-10-04  54  		return -ENOMEM;
3977d46d946ae2 Hans de Goede 2019-10-04  55  	}
3977d46d946ae2 Hans de Goede 2019-10-04  56  
3977d46d946ae2 Hans de Goede 2019-10-04  57  	size -= desc->length;
3977d46d946ae2 Hans de Goede 2019-10-04  58  	for (i = 0; i < size; i += 8) {
3977d46d946ae2 Hans de Goede 2019-10-04  59  		u64 *mem = map + i;
3977d46d946ae2 Hans de Goede 2019-10-04  60  
3977d46d946ae2 Hans de Goede 2019-10-04  61  		if (*mem != prefix)
3977d46d946ae2 Hans de Goede 2019-10-04  62  			continue;
3977d46d946ae2 Hans de Goede 2019-10-04  63  
3977d46d946ae2 Hans de Goede 2019-10-04 @64  		sha256_init(&sctx);
3977d46d946ae2 Hans de Goede 2019-10-04 @65  		sha256_update(&sctx, map + i, desc->length);
3977d46d946ae2 Hans de Goede 2019-10-04  66  		sha256_final(&sctx, sha256);
3977d46d946ae2 Hans de Goede 2019-10-04  67  		if (memcmp(sha256, desc->sha256, 32) == 0)
3977d46d946ae2 Hans de Goede 2019-10-04  68  			break;
3977d46d946ae2 Hans de Goede 2019-10-04  69  	}
3977d46d946ae2 Hans de Goede 2019-10-04  70  	if (i >= size) {
3977d46d946ae2 Hans de Goede 2019-10-04  71  		memunmap(map);
3977d46d946ae2 Hans de Goede 2019-10-04  72  		return -ENOENT;
3977d46d946ae2 Hans de Goede 2019-10-04  73  	}
3977d46d946ae2 Hans de Goede 2019-10-04  74  
3977d46d946ae2 Hans de Goede 2019-10-04  75  	pr_info("Found EFI embedded fw '%s'\n", desc->name);
3977d46d946ae2 Hans de Goede 2019-10-04  76  
3977d46d946ae2 Hans de Goede 2019-10-04  77  	fw = kmalloc(sizeof(*fw), GFP_KERNEL);
3977d46d946ae2 Hans de Goede 2019-10-04  78  	if (!fw) {
3977d46d946ae2 Hans de Goede 2019-10-04  79  		memunmap(map);
3977d46d946ae2 Hans de Goede 2019-10-04  80  		return -ENOMEM;
3977d46d946ae2 Hans de Goede 2019-10-04  81  	}
3977d46d946ae2 Hans de Goede 2019-10-04  82  
3977d46d946ae2 Hans de Goede 2019-10-04  83  	fw->data = kmemdup(map + i, desc->length, GFP_KERNEL);
3977d46d946ae2 Hans de Goede 2019-10-04  84  	memunmap(map);
3977d46d946ae2 Hans de Goede 2019-10-04  85  	if (!fw->data) {
3977d46d946ae2 Hans de Goede 2019-10-04  86  		kfree(fw);
3977d46d946ae2 Hans de Goede 2019-10-04  87  		return -ENOMEM;
3977d46d946ae2 Hans de Goede 2019-10-04  88  	}
3977d46d946ae2 Hans de Goede 2019-10-04  89  
3977d46d946ae2 Hans de Goede 2019-10-04  90  	fw->name = desc->name;
3977d46d946ae2 Hans de Goede 2019-10-04  91  	fw->length = desc->length;
3977d46d946ae2 Hans de Goede 2019-10-04  92  	list_add(&fw->list, &found_fw_list);
3977d46d946ae2 Hans de Goede 2019-10-04  93  
3977d46d946ae2 Hans de Goede 2019-10-04  94  	return 0;
3977d46d946ae2 Hans de Goede 2019-10-04  95  }
3977d46d946ae2 Hans de Goede 2019-10-04  96  

:::::: The code at line 64 was first introduced by commit
:::::: 3977d46d946ae2699ac2c8196d52fb9b303909c9 efi: Add embedded peripheral firmware support

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--b6izvrxsd6cxpbvx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--b6izvrxsd6cxpbvx--
