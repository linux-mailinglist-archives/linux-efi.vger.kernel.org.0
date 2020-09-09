Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1319426365A
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIITAp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITAm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 15:00:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FFEC061573
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 12:00:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so3500911qkj.7
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAoIKiwXi6phenhWsqlKW55AbXovegeH302mDh8ivC8=;
        b=qFwEhxTM8S/EN5lYUD436Fq3HmIo/cBq4hxCWUrdbHjJm0jjZEhCONPatYlbcUi77N
         w/uusOsOiqYhZD5W3bjJOL3rwimgdgDSa/Oq9qQA2IDOTLt4J/lbuzaVIVgOxkNBfXUZ
         ugNUgMCTgV766m1pVTiwdgZM1zI01ue0EGU/wIDrlLAWcJhTuuaCruJ1HohXwN5adDqa
         9LTQX8QhF7FNOx4nHjYZFjak8va5XKtfXNjax0ZiotrjTX9CMzDL4Etq89fKw6d8kaA2
         ViDiehQe04k8mgrYP+P207fm4rzrOg2PtSqj+tKKKK9YktE78t/x9gogqHVtiMJgdAB4
         NjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qAoIKiwXi6phenhWsqlKW55AbXovegeH302mDh8ivC8=;
        b=kW5yvBA8daXKkqfPT9+3F7KWt7lDK+Ipor85qHWbEYKBWmchvfSsH/0d1BewjauDKx
         Yq2dwj+N0mvok6ePxlgV84id8+pfZK/2RfLbiab7sOrWb9XGzi4fMLluOdvl93dDohNc
         5ZzYWzBRBhEhYNx2yPdKTRjV/mdZm5XhdMwOVCG6QRrjjF/i1dhDXQ2nlHFceY255wu+
         TyBBHnWB6mUFsxPzH+EG2JIJiOkTXBOot8mAY9kW4ijfv6gVjQgLfgn2baKXnM3BFJJc
         nn/Y7RxQSwPYB/IWPfltI6qNnEpJuIJZvdkchsLZ3+yGDMwcl+vH8kRm3WgcC5CNkF6l
         QoOw==
X-Gm-Message-State: AOAM531Lvn2PyPuuAcMoXsdyuSi2Nq7/8HnUy5pGt16efUxg63Y0clme
        E2uhqGxvg7lz8K8VeSxLgaU=
X-Google-Smtp-Source: ABdhPJyzb2vFUf5tsHJLX94BAOMT0ZT3Iom+Kq8i6NpD2gpii3bSwSBEDU10zgMfdlKOQhb7Ln5X6w==
X-Received: by 2002:a37:b806:: with SMTP id i6mr4719826qkf.333.1599678041662;
        Wed, 09 Sep 2020 12:00:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p63sm3521537qkc.4.2020.09.09.12.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:00:40 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 9 Sep 2020 15:00:38 -0400
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, ardb@kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: EFISTUB arguments in Dell BIOS
Message-ID: <20200909190038.GA474185@rani.riverdale.lan>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
 <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 09, 2020 at 07:34:59PM +0200, Jacobo Pantoja wrote:
> On Wed, 9 Sep 2020 at 00:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Sep 09, 2020 at 12:12:35AM +0200, Jacobo Pantoja wrote:
> > > >
> > > > Just to check, are you directly booting from firmware into the EFI stub,
> > > > or do you have something (grub2/systemd-boot/refind etc) in between?
> > > > Which kernel version are you using, and are you able to compile your own
> > > > kernel with patches for testing? If so, we should be able to add in some
> > > > debug statements in the EFI stub itself to see what the firmware passed
> > > > it as the command line, and if it's getting truncated or something.
> > > >
> > > Yes I'm booting directly from firmware into EFI stub, no
> > > grub2/systemd-boot/refind
> > > involved. My current kernel is 5.8.5.
> > > I'm able to compile kernel with patches, no problem.
> > > As a side note, the exact same kernel with the exact same efibootmgr command
> > > is booting in other machines (different models).
> >
> > Great. Can you test the patch below? It should dump the options passed
> > to the EFI stub, before/after converting from UTF-16 to UTF-8, and then
> > wait for a key. If you can take a picture of the screen it should show
> > what's going on, hopefully.
> 
> Result saved as image:
> https://ibb.co/vcz48vC
> 

Thanks.

It looks like the firmware is passing the entire contents of the
Boot0000 variable, rather than just the load options part: I think that
dump will be identical to the output of

	od -t x2z /sys/firmware/efi/efivars/Boot0000*

The start of it is structured data with some attributes, the label, and
the path to the linux image, and all this is then followed by the actual
load options. The EFI stub conversion routine assumes only the load
options will get passed to it (that's what the UEFI spec states), and so
treats the first two words (0x0001 0x0000) as forming a complete string
for the command line when converting. The initrd= processing on the
other hand is pretty rudimentary and just scans the entire load options
for initrd=, and so happens to work.

Ard, do you think we could quirk the conversion to check if the passed
in size was bigger than the parsed command line, and if so check to see
if the bytes 0x7f 0xff 0x0004 (End Device Path) occur somewhere, and
treat the stuff after that as the actual command line?
