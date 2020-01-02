Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79512E9FD
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgABSit (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 13:38:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40923 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgABSit (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 13:38:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so32036377qkg.7
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 10:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZf9k3UEXmyhBozIDN+8Az1p/hrthyNyWYwTi1vwCn0=;
        b=XAFwFruNI9Hb6WPL3Fd6S4iYg+AoO9N3edOVMtf//wXsLXSLhcFsEnt/+493rnpsJZ
         f+A2r5gCLaDcBkR7/ftm4sDksWd961w9I/0COiOgESPrOlrzmnOrdhMSl4NjCbF5FDFm
         Vs0m9RzN8t/cOCFBiMnv4Yllynipni3sa+OIWlrTjFPjkVO/ylNb8MCFNN8rrM1l9LAt
         DCmdZqj8HZGEuvBVxIBX7PdtqXh4GVruuWrJbtr9mDOTQx0YHj09LEJHrXqGdt2PncNf
         IJayvss1vA9wTSo4Ph0gn6VZDEkMTxywMBFgEjG4rpeJgGU1+ufzsZieMJtwgbjOk3xV
         dM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZf9k3UEXmyhBozIDN+8Az1p/hrthyNyWYwTi1vwCn0=;
        b=cWj9b4DUTQtf8KgXE/XXKu1EcfUAp/s38wacw1BibkKbehPFPSqeBiH/YQFS1salOE
         LjIMIbEwFKahYMRbXY7CfrenuGcuF/8x40OWpN4ZfQnQTvbipWJRZU3GsIFwyENGZee9
         Z040bspbY5TpaD+EEGEdOdwnYvtQrhNuOjP5MFRmVRcISgCVyBEcbI7MEejIkCwj4a2y
         U/4ruHmYyXBa/IE2VLFaQVOpqmmNXzYoknYPXIcwNp7WIeIaCdFsOIuKcN8Vxhq6Gsf4
         uHCsGS+dGMw3nM+SpNrcQrn7n6P/NcnWWNsiFtkhyAP6np53Bfyfdu0aoPKHailhINuo
         LBMg==
X-Gm-Message-State: APjAAAW7yjdWu+rk65JQEp7L1CKoF4EN3BM0+4gAn2xfGCwFUgmEbnJ2
        sDFedFTRaFu7i5st0oRN7n8=
X-Google-Smtp-Source: APXvYqxzdFmlC7qSMQwsHZ49Xs2E0rht6JTTisw5DR6tZNxxdNvSonlctBMYMD0JwZikBuMB8ySNWw==
X-Received: by 2002:a37:814:: with SMTP id 20mr67509926qki.314.1577990328416;
        Thu, 02 Jan 2020 10:38:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a36sm17241102qtk.29.2020.01.02.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:38:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 13:38:46 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102183846.GB720259@rani.riverdale.lan>
References: <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
 <20200102155129.GA668939@rani.riverdale.lan>
 <CAKv+Gu9Ne6HT1csRE4r-LZnZ9vUEOqnzHHjoj+a=NU=Tnj6o4w@mail.gmail.com>
 <CAKv+Gu_ksPvVpD=GxBNcJNhqak_k0-HZaK0jM10mKN==7k83xA@mail.gmail.com>
 <CAKv+Gu8m5vtJ6_TUgqy-Aa_7FNyhYBx=gsh1c62_impS2G99AQ@mail.gmail.com>
 <20200102172637.GB701372@rani.riverdale.lan>
 <CAKv+Gu9eEC+yQM1BsLTWLYkxCugVw76-nPQOQ14EavkJHGtcdg@mail.gmail.com>
 <20200102174142.GA713602@rani.riverdale.lan>
 <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-NDps2EP865v45sUbKRwSc2fwvcfLt64BKX_D=ErmvMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 06:48:52PM +0100, Ard Biesheuvel wrote:
> >
> > Do you remember if we ever figured out what was wrong with Matt
> > Fleming's patch to fixup the GOT for the EFI stub too?
> >
> 
> No, I don't think we did. It is simply infeasible to diagnose this on
> someone else's laptop who is on the other side of the world.
> 

Hm looking at that code, I think it wouldn't do the GOT relocation
adjustment needed after copying the kernel for decompression. But then
it shouldn't have worked at all presumably...

Maybe we should just try again and see if it breaks anyone.
