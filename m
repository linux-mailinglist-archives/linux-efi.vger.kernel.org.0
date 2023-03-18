Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419566BF886
	for <lists+linux-efi@lfdr.de>; Sat, 18 Mar 2023 08:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCRHqd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Mar 2023 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCRHqc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Mar 2023 03:46:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63322C95
        for <linux-efi@vger.kernel.org>; Sat, 18 Mar 2023 00:46:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q16so6221467wrw.2
        for <linux-efi@vger.kernel.org>; Sat, 18 Mar 2023 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679125589;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJG+HeIYp0jlCsU57nqAtVc/BpbEs4HHqnEOglHSve4=;
        b=egbedtTmTGSku15uf1eS0tR3sxiDscwdkI/hqwJ1X2ywGk5oAZO2EWuGoNzSHb3Ve3
         hM9KqxJGTVJHyqEQ+YPc9vFDVBuvA/+C4PXEX3to+iYTQ7ezgTQlsumR1XiN725LFgKW
         kEjKvaVQlFkrj8lC5aw6aaCvX9R20Yz1zkJdtSBK5xbx/Qjq2ewwfj9X0ic3vm1zgRvK
         J4GAYg3RKqtcEbJY50CpgA2ETarKFZR9DHVQtwxQhaq3Q2q3E0qHWEf6aSigAo07d6xP
         0hoa0LVFNU+CY17mVFkoJQTo9gMf2NnXTKsPRYkl7o70V4Is8VFqdDS1dKDERVWnzW8L
         s7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679125589;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJG+HeIYp0jlCsU57nqAtVc/BpbEs4HHqnEOglHSve4=;
        b=TMTOdp29UGELiY06tYQ79+EUDjaXK1G65iAxPyPPrZbU57zD0SYH6WZ0wZK+voMCQH
         w1XQ2eZ5Ol0ExfSRUVqMtLx9d8gLG5+1LuisVkybbau+wrDuj9WAwC9aF5tXc72YUS9h
         XormgO/6oRBLf/oTP7XIYTelsc/Ka0q6KL4MuGwdfp0iy1D/1p1KZbgWLrrJbOXliw3E
         oXZbWyarzvfSeyqI70BNgQ8YesEu4Tto4Ig1ZR4fBtD88ExeQt2TFFuJKTI2U9B5H/LZ
         SMqFQvpsIzxHML8FI2yUUYOA6tGuRe/2gYE8QDmHcq5xyXSbr5nWt8glC//RAGzpcxNf
         Zasg==
X-Gm-Message-State: AO0yUKW5X51Vi/BoBbsG1wv1pREW4mvc2cBe412Sx+/oVSo4XC8n3AXE
        UrYuZLjmh20TYZw9RR0RUNaWHjg+Ats=
X-Google-Smtp-Source: AK7set+Esz11LwXuMXhG8hd0Wq7sCRH63yXM2TOrV3WOH6mDFq+YPCLmhdaEm7VA3XYJ43Ag1rIsrg==
X-Received: by 2002:adf:ee91:0:b0:2ce:ae7d:f818 with SMTP id b17-20020adfee91000000b002ceae7df818mr9611082wro.23.1679125589245;
        Sat, 18 Mar 2023 00:46:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4d87000000b002c707785da4sm3673675wru.107.2023.03.18.00.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 00:46:28 -0700 (PDT)
Date:   Sat, 18 Mar 2023 10:46:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [efi:urgent 12/12]
 drivers/firmware/efi/libstub/efi-stub-helper.c:528 efi_load_initrd_lf2()
 error: uninitialized symbol 'dp'.
Message-ID: <206b582a-476f-4f43-a029-7a652d3e53f1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
head:   86237b46f2b202331c07e4c6c2633ce3d3ba7f13
commit: 86237b46f2b202331c07e4c6c2633ce3d3ba7f13 [12/12] efi: libstub: Look for initrd LoadFile2 protocol on image handle
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230318/202303180724.UexnVEeA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303180724.UexnVEeA-lkp@intel.com/

smatch warnings:
drivers/firmware/efi/libstub/efi-stub-helper.c:528 efi_load_initrd_lf2() error: uninitialized symbol 'dp'.

vim +/dp +528 drivers/firmware/efi/libstub/efi-stub-helper.c

f61900fd0ebf6c Arvind Sankar       2020-04-30  498  static
86237b46f2b202 Ard Biesheuvel      2023-03-10  499  efi_status_t efi_load_initrd_lf2(efi_handle_t image_handle,
86237b46f2b202 Ard Biesheuvel      2023-03-10  500  				 struct linux_efi_initrd *initrd,
ec93fc371f014a Ard Biesheuvel      2020-02-03  501  				 unsigned long max)
ec93fc371f014a Ard Biesheuvel      2020-02-03  502  {
ec93fc371f014a Ard Biesheuvel      2020-02-03  503  	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
86237b46f2b202 Ard Biesheuvel      2023-03-10  504  	efi_guid_t initrd_lf2_proto_guid = LINUX_EFI_INITRD_LF2_PROTOCOL_GUID;
ec93fc371f014a Ard Biesheuvel      2020-02-03  505  	efi_device_path_protocol_t *dp;
ec93fc371f014a Ard Biesheuvel      2020-02-03  506  	efi_load_file2_protocol_t *lf2;
ec93fc371f014a Ard Biesheuvel      2020-02-03  507  	efi_handle_t handle;
ec93fc371f014a Ard Biesheuvel      2020-02-03  508  	efi_status_t status;
ec93fc371f014a Ard Biesheuvel      2020-02-03  509  
86237b46f2b202 Ard Biesheuvel      2023-03-10  510  	/* first look for a initrd loading protocol specific to this image */
86237b46f2b202 Ard Biesheuvel      2023-03-10  511  	status = efi_bs_call(handle_protocol, image_handle, &initrd_lf2_proto_guid,
86237b46f2b202 Ard Biesheuvel      2023-03-10  512  			     (void **)&lf2);
86237b46f2b202 Ard Biesheuvel      2023-03-10  513  	if (status != EFI_SUCCESS) {
86237b46f2b202 Ard Biesheuvel      2023-03-10  514  		/* look for the global singleton initrd loading protocol */
ec93fc371f014a Ard Biesheuvel      2020-02-03  515  		dp = (efi_device_path_protocol_t *)&initrd_dev_path;
86237b46f2b202 Ard Biesheuvel      2023-03-10  516  		status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp,
86237b46f2b202 Ard Biesheuvel      2023-03-10  517  				     &handle);
ec93fc371f014a Ard Biesheuvel      2020-02-03  518  		if (status != EFI_SUCCESS)
ec93fc371f014a Ard Biesheuvel      2020-02-03  519  			return status;
ec93fc371f014a Ard Biesheuvel      2020-02-03  520  
ec93fc371f014a Ard Biesheuvel      2020-02-03  521  		status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
ec93fc371f014a Ard Biesheuvel      2020-02-03  522  				     (void **)&lf2);
ec93fc371f014a Ard Biesheuvel      2020-02-03  523  		if (status != EFI_SUCCESS)
ec93fc371f014a Ard Biesheuvel      2020-02-03  524  			return status;
86237b46f2b202 Ard Biesheuvel      2023-03-10  525  	}

dp not initialized on else path.

ec93fc371f014a Ard Biesheuvel      2020-02-03  526  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  527  	initrd->size = 0;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16 @528  	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
                                                                                                ^^
Uninitialized.

ec93fc371f014a Ard Biesheuvel      2020-02-03  529  	if (status != EFI_BUFFER_TOO_SMALL)
ec93fc371f014a Ard Biesheuvel      2020-02-03  530  		return EFI_LOAD_ERROR;
ec93fc371f014a Ard Biesheuvel      2020-02-03  531  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  532  	status = efi_allocate_pages(initrd->size, &initrd->base, max);
ec93fc371f014a Ard Biesheuvel      2020-02-03  533  	if (status != EFI_SUCCESS)
ec93fc371f014a Ard Biesheuvel      2020-02-03  534  		return status;
ec93fc371f014a Ard Biesheuvel      2020-02-03  535  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  536  	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size,
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  537  				(void *)initrd->base);
ec93fc371f014a Ard Biesheuvel      2020-02-03  538  	if (status != EFI_SUCCESS) {
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  539  		efi_free(initrd->size, initrd->base);
ec93fc371f014a Ard Biesheuvel      2020-02-03  540  		return EFI_LOAD_ERROR;
ec93fc371f014a Ard Biesheuvel      2020-02-03  541  	}
ec93fc371f014a Ard Biesheuvel      2020-02-03  542  	return EFI_SUCCESS;
ec93fc371f014a Ard Biesheuvel      2020-02-03  543  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

