Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06711DB897
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETPnO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETPnN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 11:43:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578DCC061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 08:43:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i14so3949069qka.10
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ko4vYLQgTTGk3mdhgoh0tvFF8+MXEIVmNnKahvO7o9A=;
        b=DsVFSjrpTOz09Ztq7KLTfUdoGzDLfQgFG0ghwRFXE1ketX6FCIBGWYCfRtIOBqTfqI
         wXqnj/xUU8J/v6/kz4HzoMUxyZOJqIk8eT5eC5sAo+U6PwM0GAHvT3rabVQ5LyzpkvHA
         knzDfSGHQn1haxRhNYxbGrjTEtzpyDHjHjZhakSHE3w4aNWxvH7yHT4sk4jreI5NAOcX
         i0mgN+moFWfeqi0bNgrDFfGsA5dglKNpHBmnommVlphRURRJI+gZGLbWKGeRIjR9QFgv
         At8A0azg6peM/nWKq1yQIm3DBojbpNqzce6QD6oM5kOAmE9aZY531AvSCqLwVctRAcq8
         l44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ko4vYLQgTTGk3mdhgoh0tvFF8+MXEIVmNnKahvO7o9A=;
        b=Rn0Q+RYzvrxwq1gCWspRRsBbu8o+3P+hI3gZhPdYAWYO/aq+olojiyJda1zY4TOtIH
         fGb2QaR8uH5zDLoC5anpB80Ho1vDKzQcXw+hz2Y1/wcH/IDemfm2qeiXLGCgL9OisYNV
         jqaSzANXxQEA4xHsJ59zVBjt1fkSPsnJOF/ZSWn9wXq0mO+6G98R9iGwcaWHIXMNJ/VQ
         6ClPljYs252K0vvqIhN6d190vpe5RENyMS7cxjtMtwPK/HWsk/+13QtF2NbHKy/MoSkC
         e4cBZTOZ3Lqphqt1znbhATV1CgaL+Idt2ZSLH9jk/jZb4DhsTMHM8zWsEG9EniCTSgcK
         AXZQ==
X-Gm-Message-State: AOAM531EIi+SoFC7a7gJy+YS3Jg781R5x0zE4hYccKsmE7FROxNXCiIJ
        q+IGW0wV/gT6BRfYM988VTg=
X-Google-Smtp-Source: ABdhPJwt6yZ58qky5tssa+yVSXrWjZJrAGJwFnSTWTMLgRoAC73/P8KUENE3jRFu1sAZXSWnjgy+kQ==
X-Received: by 2002:a05:620a:31c:: with SMTP id s28mr5226072qkm.239.1589989391073;
        Wed, 20 May 2020 08:43:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d74sm2515044qke.100.2020.05.20.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:43:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 11:43:08 -0400
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Arvind Sankar <nivedita@alum.mit.edu>,
        lkp@intel.com, kbuild-all@lists.01.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 39/40]
 drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline()
 warn: qualifier 'l' ignored for %s specifier
Message-ID: <20200520154308.GA3184088@rani.riverdale.lan>
References: <20200520140903.GA30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520140903.GA30374@kadam>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 05:09:03PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> commit: 85f5afd4322d294a7eca0d304744a1646113fbd9 [39/40] efi/libstub: Use snprintf with %ls to convert the command line
> config: x86_64-defconfig (attached as .config)
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=85f5afd4322d294a7eca0d304744a1646113fbd9
> git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> git remote update efi
> git checkout 85f5afd4322d294a7eca0d304744a1646113fbd9
> vim +/l +265 drivers/firmware/efi/libstub/efi-stub-helper.c
> 
> c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  258  	options_bytes++;	/* NUL termination */
> 9403e462fb5ffa drivers/firmware/efi/efi-stub-helper.c         Leif Lindholm  2014-04-04  259  
> 1e45bf7372c48c drivers/firmware/efi/libstub/efi-stub-helper.c Ard Biesheuvel 2020-02-10  260  	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  261  	if (status != EFI_SUCCESS)
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  262  		return NULL;
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  263  
> 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18  264  	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
>                                                                                                                                                   ^
> The "l" doesn't make sense here?

The previous patches add support for wide strings to the version of
snprintf used here.

> 
> 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18 @265  		 options_bytes - 1, options);
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  266  
> c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  267  	*cmd_line_len = options_bytes;
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  268  	return (char *)cmdline_addr;
> 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  269  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


