Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BF26378E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIUio (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 16:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIUij (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 16:38:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0ABC061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 13:38:39 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w186so3844395qkd.1
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uNt//lBNkPwmtVjixMakSaLrRCZ9lM12RoovflxgjoE=;
        b=UNE6Mrx7AxT6LDZrht1mUWsXnrWV5a761DomqwE6QlPBwfxD5dBnwx06jAGLrHEfzZ
         g9Lz0a+NIn7yecVaL5qtbZZyJhYGMk8gMw3kkxpJ9ex9lX/3tfMfjR72mzqeg8vLc33B
         Wcj1luBz7g1heEF4eqDPieeaUzGvEjRYR0j78wfTCkOhZARhJo7tffCfpVeE8o2XK+sX
         plO79q1yZEGUV83YydgeDY318pi54Ak0Xbs4aNZmBKC1eO58UphOtdHSdKN75hb+ppVG
         RvPHW1umxMqMZokvu+LRo7vfKMqZGiNDf0r+k7OCYtKRkABVo/YIyYB8PrLfNn8CzWBc
         Y/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uNt//lBNkPwmtVjixMakSaLrRCZ9lM12RoovflxgjoE=;
        b=unjdtersRxd+ze8ekt+h60PEm6eiGEqZhwjnRpwg4ljdF+KPQNa/kHv3JRurtx4zHT
         qIN3YmF+OCDxwqhaqo7Oed0rxI/m4hDXIBfngvatf2ldnzBp6EBe1N0+m01INOZH/i7X
         wcYrz1PoMIADKmkxcLb2BdthLk8AL3IQbI2fYA5h6pqvPEKdIYtj3TLHATPCHPfJ+HjC
         VkWv14T5nctDhamDDnMJIjFJynjFELZUWWXpMLjNzDCCY8thYaFv+rC3WWS3n2wbzd9Q
         CrEXNPJDYPYI/yh5q6pS72rhBOj5VbyFvJol+UFfTNcXpfwP9i5xIVO8tMc42rKKbFOY
         PRNQ==
X-Gm-Message-State: AOAM530IujAhemvC002k6AComy+TXaw2fXrfMG/XAaxsq7W27ej2k3BO
        HbVDNZsxbaLo4BDCLPrkxts=
X-Google-Smtp-Source: ABdhPJyNquSWG3SmYpaZPF9/DEudcpHbTNyaHrL1zG6VoVYGrl/b+Fq9KSQTNbt4vdojVXRssDj0wQ==
X-Received: by 2002:a37:e401:: with SMTP id y1mr4003004qkf.150.1599683912390;
        Wed, 09 Sep 2020 13:38:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o188sm3437358qke.83.2020.09.09.13.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:38:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 9 Sep 2020 16:38:30 -0400
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, ardb@kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: EFISTUB arguments in Dell BIOS
Message-ID: <20200909203830.GA490605@rani.riverdale.lan>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
 <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan>
 <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 09, 2020 at 09:37:02PM +0200, Jacobo Pantoja wrote:
> > >
> > > Result saved as image:
> > > https://ibb.co/vcz48vC
> > >
> >
> > Thanks.
> >
> > It looks like the firmware is passing the entire contents of the
> > Boot0000 variable, rather than just the load options part: I think that
> > dump will be identical to the output of
> >
> >         od -t x2z /sys/firmware/efi/efivars/Boot0000*
> >
> 
> It is almost identical. The efivar you mentioned starts with 0x0007 0x0000,
> and after that, the dump is identical to the one displayed in the debug text
> 

Right, sorry: the first 4 bytes in the sysfs file are the attributes of
the variable (in this case indicating it is non-volatile, and accessible
both before and after ExitBootServices). The rest is the actual data.

> >
> > Ard, do you think we could quirk the conversion to check if the passed
> > in size was bigger than the parsed command line, and if so check to see
> > if the bytes 0x7f 0xff 0x0004 (End Device Path) occur somewhere, and
> > treat the stuff after that as the actual command line?
> 
> To be honest, if this is an incompliance with UEFI, Dell should fix this.
> Independently of whether we setup a quirk or not, I'll contact them, in the
> past I've already got some BIOS bugs fixed (although the process is slow).
> Obviously I can continue doing whatever testing you may wish.
> 
> Thank you very much

Ok, this is laid out in section 3.1 of the spec which defines the format
of the EFI_LOAD_OPTION descriptor. Dell's BIOS is passing the entire
descriptor instead of just the OptionalData part.

OptionalData	The remaining bytes in the load option descriptor are a
		binary data buffer that is passed to the loaded image.
		If the field is zero bytes long, a Null pointer is
		passed to the loaded image. The number of bytes in
		OptionalData can be computed by subtracting the starting
		offset of OptionalData from total size in bytes of the
		EFI_LOAD_OPTION.

https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf

Thanks.
