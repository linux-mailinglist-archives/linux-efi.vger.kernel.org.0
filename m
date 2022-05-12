Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E80524E32
	for <lists+linux-efi@lfdr.de>; Thu, 12 May 2022 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354359AbiELN0b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 May 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354375AbiELN0a (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 May 2022 09:26:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB146B28;
        Thu, 12 May 2022 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652361988; x=1683897988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmzpAUepC/h4DSRzwWmTctz9hR098r96ImBi8/FHZiw=;
  b=IlZkuaTXYHleWKY8K2RwgJMNQkhTPGgMn3AZTfaGovR/GhSK9tt4i+OA
   9FG4e3RzAULvWibk26J3jp4RTH30KG4JoJRgTSM2BoYKKn1MWUVzPcjIr
   SRG7MJ55yr+/ZOCt20DMATUI35BBxSmdhGmRwbzTLnlSLVlXpGTlhwWo9
   UFuC4XUYE9lgqG8rv5TaMcvaCjtKQ6trdyrrZcfTzwTbvJ+jWzvlYA1uJ
   gpy7TPqpezi6BeyciX//rph4oBkgL9+ezUpg9ukcy6honwApQ7qWVWhNF
   DJlbPbGpVm4FcQoN1+PIli2LwID31LlxVip7T+gFM2Szou9YsVuAxLfZY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="252051495"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="252051495"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 06:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="739691520"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2022 06:26:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np8pj-000KTU-9w;
        Thu, 12 May 2022 13:26:23 +0000
Date:   Thu, 12 May 2022 21:25:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>, linux-block@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Tom Rini <trini@konsulko.com>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/5] block: add partition parser for U-Boot uImage.FIT
Message-ID: <202205122136.1KUX4NOx-lkp@intel.com>
References: <YnjxXASWU5Ps9ZoA@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnjxXASWU5Ps9ZoA@makrotopia.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on mtd/mtd/next mtd/mtd/fixes v5.18-rc6 next-20220512]
[cannot apply to rw-ubifs/next rw-ubifs/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/partition-parser-for-U-Boot-s-uImage-FIT/20220509-185349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205122136.1KUX4NOx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5a69884cfc6091e8d7c5491fbf57dd5e13cd5ee8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Golle/partition-parser-for-U-Boot-s-uImage-FIT/20220509-185349
        git checkout 5a69884cfc6091e8d7c5491fbf57dd5e13cd5ee8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash block/partitions/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
>> block/partitions/fit.c:243:29: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:248:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32
   block/partitions/fit.c:250:37: sparse: sparse: cast to restricted __be32

vim +243 block/partitions/fit.c

    69	
    70	/**
    71	 * parse_fit_partitions - map uImage.FIT filesystem sub-images into sub-partitions
    72	 * @state: pointer to partition parser state
    73	 * @fit_start_sector: start sector of the FIT structure on disk
    74	 * @sectors: number of sectors of the uImage.FIT partition or 0 if whole device
    75	 * @slot: pointer to the current partition slot number
    76	 * @add_remain: map unused sectors into additional partition
    77	 *
    78	 * To be called by other partition parsers on physical block devices or using
    79	 * wrapper function int fit_partition(struct parsed_partitions *state) for the
    80	 * whole disk, relevant typically for ubiblock or mtdblock devices.
    81	 */
    82	int parse_fit_partitions(struct parsed_partitions *state, u64 fit_start_sector,
    83				 u64 sectors, int *slot, int max_slot, bool add_remain)
    84	{
    85		struct block_device *bdev = state->disk->part0;
    86		struct address_space *mapping = bdev->bd_inode->i_mapping;
    87		struct page *page;
    88		void *fit, *init_fit;
    89		struct partition_meta_info *info;
    90		char tmp[sizeof(info->volname)];
    91		u64 dsize, dsectors, imgmaxsect = 0;
    92		u32 size, image_pos, image_len;
    93		const u32 *image_offset_be, *image_len_be, *image_pos_be;
    94		int ret = 1, node, images, config;
    95		const char *image_name, *image_type, *image_description,
    96			*config_default, *config_description, *config_loadables;
    97		int image_name_len, image_type_len, image_description_len,
    98			config_default_len, config_description_len,
    99			config_loadables_len;
   100		sector_t start_sect, nr_sects;
   101		size_t label_min;
   102		struct device_node *np = NULL;
   103		const char *bootconf;
   104		const char *loadable;
   105		bool found;
   106		int loadables_rem_len, loadable_len;
   107		u16 loadcnt;
   108	
   109		/* uImage.FIT should be aligned to page boundaries */
   110		if (fit_start_sector % (1 << (PAGE_SHIFT - SECTOR_SHIFT)))
   111			return 0;
   112	
   113		/* map first page */
   114		page = read_mapping_page(
   115			mapping, fit_start_sector >> (PAGE_SHIFT - SECTOR_SHIFT), NULL);
   116	
   117		if (IS_ERR(page))
   118			return -EFAULT;
   119	
   120		if (PageError(page))
   121			return -EFAULT;
   122	
   123		init_fit = page_address(page);
   124	
   125		if (!init_fit) {
   126			put_page(page);
   127			return -EFAULT;
   128		}
   129	
   130		/* uImage.FIT is based on flattened device tree structure */
   131		if (fdt_check_header(init_fit)) {
   132			put_page(page);
   133			return 0;
   134		}
   135	
   136		/* acquire disk or partition size */
   137		dsectors = get_capacity(bdev->bd_disk);
   138		if (sectors)
   139			dsectors = min_t(u64, sectors, dsectors);
   140	
   141		dsize = dsectors << SECTOR_SHIFT;
   142		size = fdt_totalsize(init_fit);
   143	
   144		/* silently skip non-external-data legacy uImage.FIT */
   145		if (size > PAGE_SIZE) {
   146			put_page(page);
   147			return 0;
   148		}
   149	
   150		/* abort if FIT structure is larger than disk or partition size */
   151		if (size >= dsize) {
   152			state->access_beyond_eod = 1;
   153			put_page(page);
   154			return -EFBIG;
   155		}
   156	
   157		/*
   158		 * copy FIT structure for further processing
   159		 * this is necessary for libfdt to work
   160		 */
   161		fit = kmemdup(init_fit, size, GFP_KERNEL);
   162		put_page(page);
   163		if (!fit)
   164			return -ENOMEM;
   165	
   166		/* set boot config node name U-Boot may have added to the device tree */
   167		np = of_find_node_by_path("/chosen");
   168		if (np)
   169			bootconf = of_get_property(np, "u-boot,bootconf", NULL);
   170		else
   171			bootconf = NULL;
   172	
   173		/* find configuration path in uImage.FIT */
   174		config = fdt_path_offset(fit, FIT_CONFS_PATH);
   175		if (config < 0) {
   176			pr_err("FIT: Cannot find %s node: %d\n",
   177			       FIT_CONFS_PATH, config);
   178			ret = -ENOENT;
   179			goto ret_out;
   180		}
   181	
   182		/* get default configuration node name */
   183		config_default =
   184			fdt_getprop(fit, config, FIT_DEFAULT_PROP, &config_default_len);
   185	
   186		/* make sure we got either default or selected boot config node name */
   187		if (!config_default && !bootconf) {
   188			pr_err("FIT: Cannot find default configuration\n");
   189			ret = -ENOENT;
   190			goto ret_out;
   191		}
   192	
   193		/* find selected boot config node, fallback on default config node */
   194		node = fdt_subnode_offset(fit, config, bootconf ?: config_default);
   195		if (node < 0) {
   196			pr_err("FIT: Cannot find %s node: %d\n",
   197			       bootconf ?: config_default, node);
   198			ret = -ENOENT;
   199			goto ret_out;
   200		}
   201	
   202		/* get selected configuration data */
   203		config_description =
   204			fdt_getprop(fit, node, FIT_DESC_PROP, &config_description_len);
   205		config_loadables = fdt_getprop(fit, node, FIT_LOADABLE_PROP,
   206					       &config_loadables_len);
   207	
   208		pr_info("FIT: %s configuration: \"%s\"%s%s%s\n",
   209			bootconf ? "Selected" : "Default", bootconf ?: config_default,
   210			config_description ? " (" : "", config_description ?: "",
   211			config_description ? ")" : "");
   212	
   213		if (!config_loadables || !config_loadables_len) {
   214			pr_err("FIT: No loadables configured in \"%s\"\n",
   215			       bootconf ?: config_default);
   216			ret = -ENOENT;
   217			goto ret_out;
   218		}
   219	
   220		/* get images path in uImage.FIT */
   221		images = fdt_path_offset(fit, FIT_IMAGES_PATH);
   222		if (images < 0) {
   223			pr_err("FIT: Cannot find %s node: %d\n", FIT_IMAGES_PATH, images);
   224			ret = -EINVAL;
   225			goto ret_out;
   226		}
   227	
   228		/* allocate one slot for mapping remaing space */
   229		if (add_remain)
   230			--max_slot;
   231	
   232		/* iterate over images in uImage.FIT */
   233		fdt_for_each_subnode(node, fit, images) {
   234			image_name = fdt_get_name(fit, node, &image_name_len);
   235			image_type = fdt_getprop(fit, node, FIT_TYPE_PROP, &image_type_len);
   236			image_offset_be = fdt_getprop(fit, node, FIT_DATA_OFFSET_PROP, NULL);
   237			image_pos_be = fdt_getprop(fit, node, FIT_DATA_POSITION_PROP, NULL);
   238			image_len_be = fdt_getprop(fit, node, FIT_DATA_SIZE_PROP, NULL);
   239	
   240			if (!image_name || !image_type || !image_len_be)
   241				continue;
   242	
 > 243			image_len = be32_to_cpu(*image_len_be);
   244			if (!image_len)
   245				continue;
   246	
   247			if (image_offset_be)
   248				image_pos = be32_to_cpu(*image_offset_be) + size;
   249			else if (image_pos_be)
   250				image_pos = be32_to_cpu(*image_pos_be);
   251			else
   252				continue;
   253	
   254			image_description = fdt_getprop(fit, node, FIT_DESC_PROP,
   255							&image_description_len);
   256	
   257			pr_info("FIT: %16s sub-image 0x%08x..0x%08x \"%s\" %s%s%s\n",
   258				image_type, image_pos, image_pos + image_len - 1,
   259				image_name, image_description ? "(" : "",
   260				image_description ?: "", image_description ? ") " : "");
   261	
   262			/* only 'filesystem' images should be mapped as partitions */
   263			if (strcmp(image_type, FIT_FILESYSTEM_PROP))
   264				continue;
   265	
   266			/* check if sub-image is part of configured loadables */
   267			found = false;
   268			loadable = config_loadables;
   269			loadables_rem_len = config_loadables_len;
   270			for (loadcnt = 0; loadables_rem_len > 1 &&
   271					  loadcnt < MAX_FIT_LOADABLES; ++loadcnt) {
   272				loadable_len =
   273					strnlen(loadable, loadables_rem_len - 1) + 1;
   274				loadables_rem_len -= loadable_len;
   275				if (!strncmp(image_name, loadable, loadable_len)) {
   276					found = true;
   277					break;
   278				}
   279				loadable += loadable_len;
   280			}
   281			if (!found)
   282				continue;
   283	
   284			if (image_pos % (1 << PAGE_SHIFT)) {
   285				pr_err("FIT: image %s start not aligned to page boundaries, skipping\n",
   286				       image_name);
   287				continue;
   288			}
   289	
   290			if (image_len % (1 << PAGE_SHIFT)) {
   291				pr_err("FIT: sub-image %s end not aligned to page boundaries, skipping\n",
   292				       image_name);
   293				continue;
   294			}
   295	
   296			start_sect = image_pos >> SECTOR_SHIFT;
   297			nr_sects = image_len >> SECTOR_SHIFT;
   298			imgmaxsect = (imgmaxsect < (start_sect + nr_sects)) ?
   299					     (start_sect + nr_sects) :
   300						   imgmaxsect;
   301	
   302			if (start_sect + nr_sects > dsectors) {
   303				state->access_beyond_eod = 1;
   304				continue;
   305			}
   306	
   307			put_partition(state, *slot, fit_start_sector + start_sect,
   308				      nr_sects);
   309			state->parts[*slot].flags = ADDPART_FLAG_READONLY;
   310			state->parts[*slot].has_info = true;
   311			info = &state->parts[*slot].info;
   312	
   313			label_min = min_t(int, sizeof(info->volname) - 1, image_name_len);
   314			strncpy(info->volname, image_name, label_min);
   315			info->volname[label_min] = '\0';
   316	
   317			snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
   318			strlcat(state->pp_buf, tmp, PAGE_SIZE);
   319	
   320			if (++(*slot) > max_slot)
   321				break;
   322		}
   323	
   324		/* in case uImage.FIT is stored in a partition, map the remaining space */
   325		if (add_remain && (imgmaxsect + MIN_FREE_SECT) < dsectors) {
   326			put_partition(state, *slot, fit_start_sector + imgmaxsect,
   327				      dsectors - imgmaxsect);
   328			state->parts[*slot].flags = 0;
   329			info = &state->parts[*slot].info;
   330			strcpy(info->volname, REMAIN_VOLNAME);
   331			snprintf(tmp, sizeof(tmp), "(%s)", REMAIN_VOLNAME);
   332			strlcat(state->pp_buf, tmp, PAGE_SIZE);
   333			++(*slot);
   334		}
   335	ret_out:
   336		kfree(fit);
   337		return ret;
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
