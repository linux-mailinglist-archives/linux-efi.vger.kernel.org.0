Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E199015CEE1
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 01:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBNAKx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 19:10:53 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42533 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNAKw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 19:10:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so6214271qkj.9
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 16:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aUEcYz9K4VLL5nGbvcm6Gu8W5N+sLyI0U0rpkuTxw3s=;
        b=s1OMtYE9iVayDfE3aeTM/23RFdwdU0l0F4Wvx4oUJcqFX9SI1PEbRcEyf4BvX+c13F
         prevgpFqdI32sh5LFbBPIi9BwmHzF8tT372oZsl31tJGq/xajL1US2WmhlC1amLozV12
         +EPxcIb//OijCHKQfW0M0cumTp7c+MQxOTqubvKqgC84avomUFz0sJMWvZ4R05FLUSaQ
         xwXJrmqr2eR3Z95cLBsqa9O54wwn+oGKqz3sQ6Bh6zjVpjNLlyeRwRzxFyrknzlHnc51
         Xs0pdBsGgrNmbKsyCwtXonKwkMxir02yC1AdUDpT34HASKRmTdQlsN0mGaMUFr1RSz9E
         98eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUEcYz9K4VLL5nGbvcm6Gu8W5N+sLyI0U0rpkuTxw3s=;
        b=XmLJrmT/0c/qDE94tr5m1Cue4Q13QV7685vrY1c/FeFtk0P22/SrCJCfrf32QNVIJT
         vCjibm33CCSg1HXs6dykvj2Cr6jexuSlpMSjgBKWWzQlGRDalq2BC7AmdiInZKu2Ceqc
         zhSUafzR5w0Auzijmp1e4lPaEjj0jKY/Psi176LzEz6RlOJb4YFpY9CSWixVdw/xU2O+
         03iV05dxPfJ+qcGHVInGRROnrP7JxavpHmGG1KhcT73bkWhAajxqen0xbFeTx61P21NL
         igLVXc+AIQRiqKrqBeZqkX+ZaHViL3B6pEZafnRPizW29WNuQJOHjygGCedXoo/9kpkz
         XK/w==
X-Gm-Message-State: APjAAAW8V/ie5CkjULuRZ63s1MVacVMdCy/9Mdb0GDoPZrw3sDwwIRVL
        b8dk4vqzleEVPgsGbmGV0dI=
X-Google-Smtp-Source: APXvYqyxGT06EcrW/HaX5yk4ROGph/XenpbLUl+r0HZNUM8+pfg6WbANZJvRM7LJqnNcyQd8/2aaVg==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr169038qka.160.1581639051615;
        Thu, 13 Feb 2020 16:10:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k58sm2476813qtb.60.2020.02.13.16.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 16:10:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 19:10:49 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Brown <mbrown@fensystems.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200214001048.GA3054227@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
 <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
 <20200213184752.GA1424509@rani.riverdale.lan>
 <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 13, 2020 at 10:36:14PM +0000, Ard Biesheuvel wrote:
> On Thu, 13 Feb 2020 at 19:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Feb 13, 2020 at 05:55:44PM +0000, Ard Biesheuvel wrote:
> > > On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > As an alternative to the new section, how about having a CONFIG option
> > > > to emit the 64-bit kernel with a 32-bit PE header instead, which would
> > > > point to efi32_pe_entry? In that case it could be directly loaded by
> > > > existing firmware already. You could even have a tool that can mangle an
> > > > existing bzImage's header from 64-bit to 32-bit, say using the newly
> > > > added kernel_info structure to record the existence and location of
> > > > efi32_pe_entry.
> > > >
> > >
> > > That wouldn't work with, say, signed distro kernels.
> >
> > No, the idea would be that the distro would distribute two signed
> > images, one 32-bit and one 64-bit, which are identical except for the
> > header. At install time, the installer chooses based on the system's
> > firmware bit-ness.
> >
> 
> I guess it would be possible, but then we'd need two different images
> while today, we can run the same image on both kinds of firmwares. The
> only thing I am trying to do is remove all the quirky bootparams stuff
> from the loader so that we can switch to LoadImage

Yeah, but doing that will allow you to boot directly from firmware on
existing machines, and only one image needs to be chosen at install
time, so it just adds a few MiB to the package. I guess most people will
still use a boot manager or loader that can be easily enhanced to use
LoadImage and the new section, but it would be nice to have the option
to avoid that.

> 
> > >
> > > > Also, the PE header can live anywhere inside the image, right? Is there
> > > > any reason to struggle to shoehorn it into the "boot sector"?
> > >
> > > It cannot. It must live outside a region described by the section headers.
> >
> > It could still be inserted after .setup, or at the very end of the file, no?
> 
> The PE/COFF spec mentions that the COFF header needs to follow the
> signature. Also, the SizeOfHeaders field would become somewhat
> ambiguous if the header is split up like that.


Ah, the definition of SizeOfHeaders doesn't make much sense if the
headers weren't contiguous with the MS-DOS stub. I guess they just
wanted the MS-DOS stub to potentially vary in size, but still want the
header to immediately follow it, drat.
