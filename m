Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96B15CEE4
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 01:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBNANA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 19:13:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40085 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBNANA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 19:13:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so5831369qto.7
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 16:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U2uxh4cJsZDeQkDsJrMsdoCY2KIVy1rPr4keDyaSDXM=;
        b=YRKZVX8PMmQU9cU15U3HR+LuxuSdQ7O9wlhZFbzGwaaNFgRE1XgdHZs1kUwYleVGU3
         Kr2+fQnEOuj1p1mjtNvAVGPF+oP0i7C7O7PpYjvwfFuyFKR0V/bEIqOnnam93vz8oYT4
         OC9Prb/5NFO2S2u6+NDsAVCiuPVqipSZzLUhbv5eDRucgiN6tTJ9Ni0SdcnpDpi/i89k
         kFzMRIqzMGGZ9tgdgmbxe2tAkiQatCe2ZgBZvyUJ00ntK1ilCsPetO+4NvAZfuk+FAi6
         9kynapw5hzIpbWvQWxGNOi7k2JXzJSNUabd+L4qP6mazhSwIcKgMA3Pf50quFu5Yua5d
         Q8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U2uxh4cJsZDeQkDsJrMsdoCY2KIVy1rPr4keDyaSDXM=;
        b=JodF4fpCiGVUKIzH/2eEjZV9y0IPUZHqXR/DMdHrOUpKutaaX/oW7SyBXtgtLNj5Xd
         qEo1pUxsqDWvGIQvQQzvo2Odi3S5VyWYB5blVNVtARKYjtBqVnMdR7dqkqINnNd0cX9N
         s5mGM1a+C85IxntCZhT3/rL4e/pGWM/LNUi0MsQVjv7+m2NTSeyGG8iH3ravwIoby/L0
         M9G1bgoBffGMIsCL+oiCTDdhUmcpphl/9VRMadr6y6TY2dE3yM+K1s1olbn1ng0Tal1Q
         ej4Ft9UnhTuRx09BefOyuVbfDwmaDhiIGd1Ys+zbtOnb0hmtLcT/VwHTDDQ5nfApBqhP
         B+qQ==
X-Gm-Message-State: APjAAAV7wuLdBTOInB3yff8XnTJ57sgnrb8xy/fQdGaMUphAdiqRBuuJ
        kPUidJeDzBAQD3m/g1iqFx8=
X-Google-Smtp-Source: APXvYqy3086oi1D+oGgCHhgBu7bWRlwhFonU6wdS6ywe/LTVnELLQMhFT96nu4gmNs7VNZe7tIExMQ==
X-Received: by 2002:aed:2783:: with SMTP id a3mr575335qtd.284.1581639179551;
        Thu, 13 Feb 2020 16:12:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v80sm2175993qka.15.2020.02.13.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 16:12:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 19:12:57 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20200214001257.GB3054227@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
 <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
 <20200213184752.GA1424509@rani.riverdale.lan>
 <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
 <20200214001048.GA3054227@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214001048.GA3054227@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 13, 2020 at 07:10:49PM -0500, Arvind Sankar wrote:
> On Thu, Feb 13, 2020 at 10:36:14PM +0000, Ard Biesheuvel wrote:
> > On Thu, 13 Feb 2020 at 19:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Thu, Feb 13, 2020 at 05:55:44PM +0000, Ard Biesheuvel wrote:
> > > > On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > As an alternative to the new section, how about having a CONFIG option
> > > > > to emit the 64-bit kernel with a 32-bit PE header instead, which would
> > > > > point to efi32_pe_entry? In that case it could be directly loaded by
> > > > > existing firmware already. You could even have a tool that can mangle an
> > > > > existing bzImage's header from 64-bit to 32-bit, say using the newly
> > > > > added kernel_info structure to record the existence and location of
> > > > > efi32_pe_entry.
> > > > >
> > > >
> > > > That wouldn't work with, say, signed distro kernels.
> > >
> > > No, the idea would be that the distro would distribute two signed
> > > images, one 32-bit and one 64-bit, which are identical except for the
> > > header. At install time, the installer chooses based on the system's
> > > firmware bit-ness.
> > >
> > 
> > I guess it would be possible, but then we'd need two different images
> > while today, we can run the same image on both kinds of firmwares. The
> > only thing I am trying to do is remove all the quirky bootparams stuff
> > from the loader so that we can switch to LoadImage
> 
> Yeah, but doing that will allow you to boot directly from firmware on
> existing machines, and only one image needs to be chosen at install
> time, so it just adds a few MiB to the package. I guess most people will
> still use a boot manager or loader that can be easily enhanced to use
> LoadImage and the new section, but it would be nice to have the option
> to avoid that.

Also not quite today, right? You still need this patchset and the
modifications to bootloaders to get away with one image.
