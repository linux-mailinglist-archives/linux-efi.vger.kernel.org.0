Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50E46911D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Dec 2021 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhLFICn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Dec 2021 03:02:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:51625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238855AbhLFICb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Dec 2021 03:02:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="298066051"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="298066051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 23:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="562577924"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Dec 2021 23:59:00 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu8tn-000L09-LR; Mon, 06 Dec 2021 07:58:59 +0000
Date:   Mon, 6 Dec 2021 15:58:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Dov Murik <dovmurik@linux.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 3/5] virt: Add efi_secret module to expose
 confidential computing secrets
Message-ID: <202112061528.k1C2Xe9d-lkp@intel.com>
References: <20211129114251.3741721-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129114251.3741721-4-dovmurik@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 42eb8fdac2fc5d62392dcfcf0253753e821a97b0]

url:    https://github.com/0day-ci/linux/commits/Dov-Murik/Allow-guest-access-to-EFI-confidential-computing-secret-area/20211129-194749
base:   42eb8fdac2fc5d62392dcfcf0253753e821a97b0
config: x86_64-randconfig-s032-20211206 (https://download.01.org/0day-ci/archive/20211206/202112061528.k1C2Xe9d-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/ebf498903d5371698bd13ed4005b4d61702f8223
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dov-Murik/Allow-guest-access-to-EFI-confidential-computing-secret-area/20211129-194749
        git checkout ebf498903d5371698bd13ed4005b4d61702f8223
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virt/coco/efi_secret/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/virt/coco/efi_secret/efi_secret.c:242:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *ptr @@     got void [noderef] __iomem *secret_data @@
   drivers/virt/coco/efi_secret/efi_secret.c:242:13: sparse:     expected unsigned char *ptr
   drivers/virt/coco/efi_secret/efi_secret.c:242:13: sparse:     got void [noderef] __iomem *secret_data

vim +242 drivers/virt/coco/efi_secret/efi_secret.c

   211	
   212	static int efi_secret_securityfs_setup(void)
   213	{
   214		struct efi_secret *s = efi_secret_get();
   215		int ret = 0, i = 0, bytes_left;
   216		unsigned char *ptr;
   217		struct secret_header *h;
   218		struct secret_entry *e;
   219		struct dentry *dent;
   220		char guid_str[EFI_VARIABLE_GUID_LEN + 1];
   221	
   222		s->coco_dir = NULL;
   223		s->fs_dir = NULL;
   224		memset(s->fs_files, 0, sizeof(s->fs_files));
   225	
   226		dent = securityfs_create_dir("coco", NULL);
   227		if (IS_ERR(dent)) {
   228			pr_err("Error creating coco securityfs directory entry err=%ld\n", PTR_ERR(dent));
   229			return PTR_ERR(dent);
   230		}
   231		s->coco_dir = dent;
   232	
   233		dent = securityfs_create_dir("efi_secret", s->coco_dir);
   234		if (IS_ERR(dent)) {
   235			pr_err("Error creating efi_secret securityfs directory entry err=%ld\n",
   236			       PTR_ERR(dent));
   237			return PTR_ERR(dent);
   238		}
   239		d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
   240		s->fs_dir = dent;
   241	
 > 242		ptr = s->secret_data;
   243		h = (struct secret_header *)ptr;
   244		if (efi_guidcmp(h->guid, EFI_SECRET_TABLE_HEADER_GUID)) {
   245			pr_err("EFI secret area does not start with correct GUID\n");
   246			ret = -EINVAL;
   247			goto err_cleanup;
   248		}
   249		if (h->len < sizeof(*h)) {
   250			pr_err("EFI secret area reported length is too small\n");
   251			ret = -EINVAL;
   252			goto err_cleanup;
   253		}
   254		if (h->len > s->secret_data_len) {
   255			pr_err("EFI secret area reported length is too big\n");
   256			ret = -EINVAL;
   257			goto err_cleanup;
   258		}
   259	
   260		bytes_left = h->len - sizeof(*h);
   261		ptr += sizeof(*h);
   262		while (bytes_left >= (int)sizeof(*e) && i < EFI_SECRET_NUM_FILES) {
   263			e = (struct secret_entry *)ptr;
   264			if (e->len < sizeof(*e) || e->len > (unsigned int)bytes_left) {
   265				pr_err("EFI secret area is corrupted\n");
   266				ret = -EINVAL;
   267				goto err_cleanup;
   268			}
   269	
   270			/* Skip deleted entries (which will have NULL_GUID) */
   271			if (efi_guidcmp(e->guid, NULL_GUID)) {
   272				efi_guid_to_str(&e->guid, guid_str);
   273	
   274				dent = securityfs_create_file(guid_str, 0440, s->fs_dir, (void *)e,
   275							      &efi_secret_bin_file_fops);
   276				if (IS_ERR(dent)) {
   277					pr_err("Error creating efi_secret securityfs entry\n");
   278					ret = PTR_ERR(dent);
   279					goto err_cleanup;
   280				}
   281	
   282				s->fs_files[i++] = dent;
   283			}
   284			ptr += e->len;
   285			bytes_left -= e->len;
   286		}
   287	
   288		pr_debug("Created %d entries in efi_secret securityfs\n", i);
   289		return 0;
   290	
   291	err_cleanup:
   292		efi_secret_securityfs_teardown();
   293		return ret;
   294	}
   295	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
