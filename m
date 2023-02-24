Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110816A17A5
	for <lists+linux-efi@lfdr.de>; Fri, 24 Feb 2023 09:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBXIC3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Feb 2023 03:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBXIC2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Feb 2023 03:02:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946CB4ECC5;
        Fri, 24 Feb 2023 00:02:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A7161852;
        Fri, 24 Feb 2023 08:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C213C433D2;
        Fri, 24 Feb 2023 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677225746;
        bh=Bo2E+OcPRtsyfOuNhBqdfQ6dza6KHxFnMmteR7AUNU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HcAwzD00WtKrDzbXvL/AtI520oUZ7DFlj1fqK3mxnh9hp04Bzi1lnNn5y5X9MuDAU
         Tt3izELcuYdesXK65rkggGz9ZXowzapyLOS421afFfvlgZqMKcfXQeqMy8wttpLhMR
         ff7US44o6Rnifd/lHeapwDf4zAmWwlWl7jhd0nb9LN3kFx4tZwrV9bgLw8zyDW/7JV
         eKLe8lYj4mfFZ50YHCUAb6XVxSFmETQPxDWQRia5T5BQW/Ow/6h5yUgU/Nv928gyxG
         Iuun5/JCiuH/Z7jz98uUUtu8p2NPx2Y+PizbaW+0kI2e5YaXhnNy4HPqipUE4h7B2X
         d0m/CMiejFXRw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pVT2L-0003DH-Ca; Fri, 24 Feb 2023 09:02:37 +0100
Date:   Fri, 24 Feb 2023 09:02:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        oe-kbuild-all@lists.linux.dev, Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
Message-ID: <Y/hvHY9Mot84VC+x@hovoldconsulting.com>
References: <20230126112129.4602-1-johan+linaro@kernel.org>
 <202302231642.tyrVwZMY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302231642.tyrVwZMY-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 23, 2023 at 05:03:54PM +0800, kernel test robot wrote:
> Hi Johan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on v6.2-rc5]
> [also build test ERROR on linus/master]
> [cannot apply to efi/next next-20230223]

I have no idea what your robot is trying to do here, but this patch has
been folded into 301de9a20553 ("efivarfs: always register filesystem")
and is already in linux-next building just fine.

> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Johan-Hovold/efivarfs-fix-NULL-deref-on-mount-when-no-efivars/20230128-094525
> patch link:    https://lore.kernel.org/r/20230126112129.4602-1-johan%2Blinaro%40kernel.org
> patch subject: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
> config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20230223/202302231642.tyrVwZMY-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/da57163cc9d947884520240ec71c2806f48b8a64
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Johan-Hovold/efivarfs-fix-NULL-deref-on-mount-when-no-efivars/20230128-094525
>         git checkout da57163cc9d947884520240ec71c2806f48b8a64
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 olddefconfig
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302231642.tyrVwZMY-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    fs/efivarfs/super.c: In function 'efivarfs_kill_sb':
> >> fs/efivarfs/super.c:246:14: error: implicit declaration of function 'efivar_is_available'; did you mean 'slab_is_available'? [-Werror=implicit-function-declaration]
>      246 |         if (!efivar_is_available())
>          |              ^~~~~~~~~~~~~~~~~~~
>          |              slab_is_available
>    cc1: some warnings being treated as errors
> 
> 
> vim +246 fs/efivarfs/super.c
> 
>    241	
>    242	static void efivarfs_kill_sb(struct super_block *sb)
>    243	{
>    244		kill_litter_super(sb);
>    245	
>  > 246		if (!efivar_is_available())
>    247			return;
>    248	
>    249		/* Remove all entries and destroy */
>    250		efivar_entry_iter(efivarfs_destroy, &efivarfs_list, NULL);
>    251	}
>    252	

Johan
