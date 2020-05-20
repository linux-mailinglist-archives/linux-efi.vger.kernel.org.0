Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003141DBC29
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgETSAN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgETSAL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 14:00:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435EAC061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:00:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m64so3308928qtd.4
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4U55p9iswVuppx4Qdn7q6oWVQHU+iEp1TlMOGZn5Ic=;
        b=hCQJss4d3jnP2YFd4P6zsMxjIfW5tn5OubiNktYPgOF9OwQ7x0JASI5mMCHnPin1zB
         sw/CW1AR/HjJauT6LOsQ+LG7H39JxA2nW2OXxcJAaqH76QTuN00K8IhnqMxoqTkGH97l
         sfHtEKL9Is3WWBiADly0J/jbPKoGCeReawnqRl/6kzG8R75F9K4Bt4+/MlFd7O5pfVmZ
         KOyLUjNLR5FgcucbJnSbuKFrZJfCk2y/KaJ6rhRdaNdqXd84hFxsQe7ilDBgzE6Hvejo
         iZfPPEF7jeMtjVjrKWBOsruhaZewHAdis/QV/jFEXjl3eDiXMoquyAgbcthT7ZisCOje
         LnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b4U55p9iswVuppx4Qdn7q6oWVQHU+iEp1TlMOGZn5Ic=;
        b=qLyNWahT5JFIXlZ+xrDoC3bQyJuN6ZmLWzYitTOWTw3OSgad6cLVtSk8wiVwob6JpD
         3FhSZkp2w/sTUSZWMeEF5AcEV/MxBaXb/R3B52e2yrBESnJEA9l3S5jKTx0+s4Yp26br
         vAYPXO5VXkySc3tv02e5T16g/Mh8+O0pH15te2Q6kyWM+7heL96u6sFfufdMjvVDelZU
         oQLxG6I7/yGMDy5om3i26WN4bgWd738mYLkjtCo/7L2nWzpAQ+/nAG5EHiHnviCvMSlt
         qYiYNwm694EHB2DCaMJY90BmiibAzmY+OKDWZY9QAGHEr/0O8n3MiunpozAK7Y34dWlB
         8abQ==
X-Gm-Message-State: AOAM531dx8cjZqgSulR6ZjJQynv6/QOhvqNg93TBybjJDIBUcGgVBw20
        2/OO+mysdqmYQdBDn0h8chk=
X-Google-Smtp-Source: ABdhPJyxvNJSsKrcyJv4ysEiPMYA+hzLIeSs7jkDjsyBrVCrIFq8kst7eR4jQ6MIkhdZBHDlsEw7EQ==
X-Received: by 2002:ac8:188c:: with SMTP id s12mr6677032qtj.172.1589997610454;
        Wed, 20 May 2020 11:00:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t12sm2653608qkt.77.2020.05.20.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:00:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 14:00:08 -0400
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 39/40]
 drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline()
 warn: qualifier 'l' ignored for %s specifier
Message-ID: <20200520180008.GA3428271@rani.riverdale.lan>
References: <20200520140903.GA30374@kadam>
 <20200520154308.GA3184088@rani.riverdale.lan>
 <20200520175449.GR3041@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520175449.GR3041@kadam>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 08:54:49PM +0300, Dan Carpenter wrote:
> On Wed, May 20, 2020 at 11:43:08AM -0400, Arvind Sankar wrote:
> > On Wed, May 20, 2020 at 05:09:03PM +0300, Dan Carpenter wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > > commit: 85f5afd4322d294a7eca0d304744a1646113fbd9 [39/40] efi/libstub: Use snprintf with %ls to convert the command line
> > > config: x86_64-defconfig (attached as .config)
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > New smatch warnings:
> > > drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
> > > 
> > > # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=85f5afd4322d294a7eca0d304744a1646113fbd9
> > > git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> > > git remote update efi
> > > git checkout 85f5afd4322d294a7eca0d304744a1646113fbd9
> > > vim +/l +265 drivers/firmware/efi/libstub/efi-stub-helper.c
> > > 
> > > c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  258  	options_bytes++;	/* NUL termination */
> > > 9403e462fb5ffa drivers/firmware/efi/efi-stub-helper.c         Leif Lindholm  2014-04-04  259  
> > > 1e45bf7372c48c drivers/firmware/efi/libstub/efi-stub-helper.c Ard Biesheuvel 2020-02-10  260  	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
> > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  261  	if (status != EFI_SUCCESS)
> > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  262  		return NULL;
> > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  263  
> > > 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18  264  	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
> > >                                                                                                                                                   ^
> > > The "l" doesn't make sense here?
> > 
> > The previous patches add support for wide strings to the version of
> > snprintf used here.
> 
> Ah.  Thanks.  I will update the Smatch check.
> 
> regards,
> dan carpenter
> 
Note that the main kernel's printf still doesn't support it. It's only
been added to the version in drivers/firmware/efi/libstub/vsprintf.c
(added as part of this series).
