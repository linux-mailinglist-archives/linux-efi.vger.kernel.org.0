Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A394515CE24
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 23:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBMWg1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 17:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMWg1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 17:36:27 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD050222C2
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581633387;
        bh=JU3goHu7gsc+wO1ffpTCrRoCNDgmBOMfYIX03xTJlXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KuZavOgvBzqv+Qxh1BFMchPE7rZHU/sde4FMKB0n1cRkHuF8yB2nSpwg6p41mkK5I
         A52ju/TzH5VcdbBNLQwxyEmQw9uqML5Zj/LUu/+bvFfCJOFuPrRtpJ12zGykuHomH0
         zDNcpUMCRBFKFURaoXhBegKJjltrEob12YNDMmAo=
Received: by mail-wm1-f54.google.com with SMTP id a5so8024570wmb.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 14:36:26 -0800 (PST)
X-Gm-Message-State: APjAAAWcbkpPN4NYrrQCEifl1OI0MEe38b2AEOZEnANfVwsRckjaKgmb
        7aVzyF6aEyvPYkLog0PUgM0eyHyo3goQ69DPVtirVA==
X-Google-Smtp-Source: APXvYqwbn5MVNy/geSnY+QWWK0EmTyse/GP6qimB1vsXCBiqPWCuxVIvXO0w48vYKkBBBZ/xAF8BVoT6KTDIxw7M9kk=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr263116wmf.133.1581633385212;
 Thu, 13 Feb 2020 14:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20200213145928.7047-1-ardb@kernel.org> <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com> <20200213184752.GA1424509@rani.riverdale.lan>
In-Reply-To: <20200213184752.GA1424509@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Feb 2020 22:36:14 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
Message-ID: <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Feb 2020 at 19:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 13, 2020 at 05:55:44PM +0000, Ard Biesheuvel wrote:
> > On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > As an alternative to the new section, how about having a CONFIG option
> > > to emit the 64-bit kernel with a 32-bit PE header instead, which would
> > > point to efi32_pe_entry? In that case it could be directly loaded by
> > > existing firmware already. You could even have a tool that can mangle an
> > > existing bzImage's header from 64-bit to 32-bit, say using the newly
> > > added kernel_info structure to record the existence and location of
> > > efi32_pe_entry.
> > >
> >
> > That wouldn't work with, say, signed distro kernels.
>
> No, the idea would be that the distro would distribute two signed
> images, one 32-bit and one 64-bit, which are identical except for the
> header. At install time, the installer chooses based on the system's
> firmware bit-ness.
>

I guess it would be possible, but then we'd need two different images
while today, we can run the same image on both kinds of firmwares. The
only thing I am trying to do is remove all the quirky bootparams stuff
from the loader so that we can switch to LoadImage

> >
> > > Also, the PE header can live anywhere inside the image, right? Is there
> > > any reason to struggle to shoehorn it into the "boot sector"?
> >
> > It cannot. It must live outside a region described by the section headers.
>
> It could still be inserted after .setup, or at the very end of the file, no?

The PE/COFF spec mentions that the COFF header needs to follow the
signature. Also, the SizeOfHeaders field would become somewhat
ambiguous if the header is split up like that.
