Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ED82655ED
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 02:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgIKAEF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Sep 2020 20:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKAEE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Sep 2020 20:04:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7DAC061573
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 17:04:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so6402985qtw.5
        for <linux-efi@vger.kernel.org>; Thu, 10 Sep 2020 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PvNAjNmHdVVXqFIxYqmjr4aBWkmKdAK9eGFKuaOsuEw=;
        b=KRLEhh58NtugpKD9BO5Fb/NeP/HHHfQFPZraLuTGTMTLFfA8h63xl5zK/YlRdIK+MR
         1MZ9U4rIKl7Ff50+poxHeB47uGvGXt8aCqJv+BXEA/DP7Xoacr3euWdhR2LZjfw2U9ZS
         WJkk634pU3KxzhioPfHhPdm1omL1w5gGfHeabmLT5tA2mOBCPKR+yovV0pN0WAhs5vSH
         BbGeN7zdHQDUxcr83E2RatEulWiHPc/5tgAsEDKlSSa/BJtfoC9nJ2DIjHBWUVWcFMOu
         Kx8QjQUpgx1PTT6WVediUPmtsP6c14XlcQ4L8VoWDKKaAy6kE8p/CZYz3ChjpMzvBYxt
         UMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=PvNAjNmHdVVXqFIxYqmjr4aBWkmKdAK9eGFKuaOsuEw=;
        b=qub7HTjshtf2Emtw2/2OIwnaFq05Bx7OBsIfyH6x+pA4yw6+F+zt867ZdDzCJSQbfd
         b5FiWH1mgF8wxXpntLkA6tPK3XNV5SjT8Xj25Ye1EtF1GCqO4sz0pwml+6qjK8E2ES4G
         7ZrWPLn5QFbNJHmzeb4gFBecoGnt+zCZewhZzTesfS/SGm5NahaW4uJUIPewk+xuSlJk
         ndXZtHVzr07EU8/mACCHOeoxQ7rniIIbN9rnlCXzwvOW1e9fNW4Hq4TbL08//U0o0VZC
         fuITpU3wCFBVn0LeKRJhjUo3v+BIKHT/weMy16GhJ+vri1z68hqxHpD6WeCiQGXK5lSL
         Udfw==
X-Gm-Message-State: AOAM53373Qmduu1/JunLpH0sHwL5LNSZ/dU8oH7M1MQsQjoavPPKkvZm
        3rNIOLsvbQSJjt0L/8/Fn2c=
X-Google-Smtp-Source: ABdhPJyY0gyre3aw1jKAfg/b3tLl+ofnNC6pICj9MYC6qSjDcRDa7K6u6kS+Kfr1W0L64llyWLN3Aw==
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr10746262qta.146.1599782642995;
        Thu, 10 Sep 2020 17:04:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l5sm437385qtc.28.2020.09.10.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 17:04:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 10 Sep 2020 20:04:01 -0400
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Jones <pjones@redhat.com>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: EFISTUB arguments in Dell BIOS
Message-ID: <20200911000401.GA877093@rani.riverdale.lan>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
 <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
 <20200909190038.GA474185@rani.riverdale.lan>
 <CAO18KQjGdcZD8bts36GuicJO8_iprbryXdh5vM+-GfAbcKV==Q@mail.gmail.com>
 <20200909203830.GA490605@rani.riverdale.lan>
 <CAMj1kXEAkR9_tN_o0m30e+HY_F_xf3wY_uSDUiWYOkaugcvoNw@mail.gmail.com>
 <DM6PR19MB2636BAC48CDC12B08BF611D3FA270@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR19MB2636BAC48CDC12B08BF611D3FA270@DM6PR19MB2636.namprd19.prod.outlook.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 10, 2020 at 08:40:06PM +0000, Limonciello, Mario wrote:
> > >
> > > Ok, this is laid out in section 3.1 of the spec which defines the format
> > > of the EFI_LOAD_OPTION descriptor. Dell's BIOS is passing the entire
> > > descriptor instead of just the OptionalData part.
> > >
> > > OptionalData    The remaining bytes in the load option descriptor are a
> > >                 binary data buffer that is passed to the loaded image.
> > >                 If the field is zero bytes long, a Null pointer is
> > >                 passed to the loaded image. The number of bytes in
> > >                 OptionalData can be computed by subtracting the starting
> > >                 offset of OptionalData from total size in bytes of the
> > >                 EFI_LOAD_OPTION.
> > >
> > > https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf
> > >
> > 
> > This vaguely rings a bell so I have cc'ed some folks who may have run
> > into this in the past. Complete thread can be found at [0]
> > 
> 
> Thanks for sharing the context.  This rings a bell for me with the last time
> I recall worrying about the Load Options and this commit in shim comes to
> mind:
> 
> https://github.com/rhboot/shim/commit/3322257e611e2000f79726d295bb4845bbe449e7
> 
> It seems to me the shim approach to the problem isn't too big of a deal:
> count the number of strings and if it's greater or equal to 2, then throw
> out the first one.  It's also already been used in production code across a 
> ton of platforms for several years, so if there was major breakages I would
> expect they're covered in that code too by now.

AFAICT, the >= 2 check is for seeing if it was invoked by the shell, and
if so, skipping the first word (which would be the name of the
executable). For handling the case we're running into here, it's
checking if loadoptions is valid UCS-2, though its idea of valid seems
to be that it must consist of characters < 0x100; and if not, trying to
parse it as a complete EFI_LOAD_OPTION.

> 
> > The firmware is obviously passing the wrong data, and I am reluctant
> > to quirk this out, since we'd have to interpret the contents of these
> > UEFI variables, and given the amount of 'value add' by the BIOS
> > vendors in this area, we may end up breaking things on other
> > platforms.
> > 
> > [0] https://lore.kernel.org/linux-
> > efi/20200909203830.GA490605@rani.riverdale.lan/
> 
> In the defense of others who have interpreted the spec, as I'm reading it I'm
> not convinced that it explicitly calls out what data should be passed. In
> section 7.4 which explains how LoadImage() behaves.
> 
> ```
> Once the image is loaded, firmware creates and returns an EFI_HANDLE that identifies the image and
> supports EFI_LOADED_IMAGE_PROTOCOL and the EFI_LOADED_IMAGE_DEVICE_PATH_PROTOCOL.
> The caller may fill in the image’s “load options” data
> ```
> 
> In this context the caller is most likely BDS, and it's "optional" to load
> content in.  Within section 9.1 which describes the loaded image protocol the exact
> format of the content of "LoadOptions" is not described.  I can see an interpretation
> it should be the full descriptor or that it can be the OptionalData.

LoadImage() is a general library function, it can be called by the
firmware boot manager, but also by any other EFI application during boot
services. In this context, LoadOptions is arbitrary data to be filled in
by the caller of LoadImage() if it wants to.

Section 3.1 is what describes how the Boot#### variables are to be
handled by the boot manager, and that is explicit about what gets
passed by the boot manager to the loaded image.

> 
> And actually if you looks in history from EDK code, you can see that it's been done that way there too at least at one time:
> https://github.com/tianocore/edk2/blob/b8d06293caa122f9c3bd2ae32a6c3f790a054e03/IntelFrameworkModulePkg/Library/GenericBdsLib/BdsBoot.c#L2433
> 

I don't think that's passing the whole Boot#### variable. "Option" there
is a BDS_COMMON_OPTION, and that is created from the Boot#### variable
using BdsLibVariableToOption, which copies just the OptionalData into
BDS_COMMON_OPTION.LoadOptions.

https://github.com/tianocore/edk2/blob/b8d06293caa122f9c3bd2ae32a6c3f790a054e03/IntelFrameworkModulePkg/Library/GenericBdsLib/BdsMisc.c#L598

> 
> Jacobo,
> 
> Can you provide some more details on your system that is reproducing
> this?  Model number, FW version would be useful.
> The links provided earlier on are on pretty old stuff, so knowing that this
> is a problem on something more current would be good.
> 
> I guess the other option if Ard chooses not to adopt a quirk for this
> described behavior is to use shim to load the kernel efistub, and let
> it do the split for you.
