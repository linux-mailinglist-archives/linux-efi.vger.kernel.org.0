Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17C93CFA00
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhGTMU5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGTMUx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 08:20:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14511C061574
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 06:01:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so2033916wmq.0
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aT7B7aLtrHA38WRCCkcWibI+OBLuTfXFqvYRJ204kL8=;
        b=WQOOu9EUP4QZrBDWS9EctGVO+GmPjrxym15Qbs5R69qSSEdvCHmpIY1/pk31fA69bp
         3bhC+HD4e8CKzboAfJ+pob2QA2TRhC1Np5OjjzICbqkxEwpGsaSp5RJW4pQU+z0OC23I
         0sG4uqigJR5y1K6AdXcTXz1r+jHYxj5pVPrh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aT7B7aLtrHA38WRCCkcWibI+OBLuTfXFqvYRJ204kL8=;
        b=NOra4tXK53XZc9iVzFeQaDOAT7ky3NbBI44iuZfLJFc2PE/5hZQjEuc8Yz0fBl8Or6
         mnFxdolZHjBjU9fFk3P6jy/Suu06fN+RlS2Lv9TFoVVI+0AWvWsr/uq7s7YCKhVMlzma
         Cg9pgrmYY+r/Ik6NfbeHeOU620k/w1GQw/4aOOGheBCaNNqvrc4Jot0WeZaclPu5z2hM
         hG4pldcqPs/X/K5eei1zsJaCKwxFI0wRvGq4dK7uKmQrQ4YldoP+zCaLk++Lbv7ca/iI
         yOfVh3BsmjrKVoqdpS9bieEdq505JgKFsfFNYwBeENnyK1Z02SZYPjKN1uPZGpEAxMMR
         rRQA==
X-Gm-Message-State: AOAM531JRJ6c/h9pBLq5Po79Xt9lpq97OI3E65U6zJm/ao7LwqPmrOGQ
        CKWnnXG6rgb6sztlNckdcUSLxA==
X-Google-Smtp-Source: ABdhPJwyy66JJKeYq0Mz7cYqrI/HK2CM9a/YOzkD7Z06g/Y6R4UrwQlWLQ5wT2w19Z/rHR9fxuhTcg==
X-Received: by 2002:a05:600c:2948:: with SMTP id n8mr32984505wmd.11.1626786090699;
        Tue, 20 Jul 2021 06:01:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g18sm19422048wmk.37.2021.07.20.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:01:30 -0700 (PDT)
Date:   Tue, 20 Jul 2021 15:01:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
Message-ID: <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
Mail-Followup-To: Ard Biesheuvel <ardb@kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20210625130947.1803678-1-javierm@redhat.com>
 <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
 <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021 at 09:10:52AM +0200, Ard Biesheuvel wrote:
> On Mon, 19 Jul 2021 at 04:59, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 15 Jul 2021 at 18:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > >
> > > Hi
> > >
> > > Am 13.07.21 um 18:59 schrieb Javier Martinez Canillas:
> > > > On 6/25/21 3:09 PM, Javier Martinez Canillas wrote:
> > > >> The simplefb and simpledrm drivers match against a "simple-framebuffer"
> > > >> device, but for aarch64 this is only registered when using Device Trees
> > > >> and there's a node with a "simple-framebuffer" compatible string.
> > > >>
> > > >> There is no code to register a "simple-framebuffer" platform device when
> > > >> using EFI instead. In fact, the only platform device that's registered in
> > > >> this case is an "efi-framebuffer", which means that the efifb driver is
> > > >> the only driver supported to have an early console with EFI on aarch64.
> > > >>
> > > >> The x86 architecture platform has a Generic System Framebuffers (sysfb)
> > > >> support, that register a system frambuffer platform device. It either
> > > >> registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
> > > >> VGA/EFI FB devices for the vgafb/efifb drivers.
> > > >>
> > > >> The sysfb is generic enough to be reused by other architectures and can be
> > > >> moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
> > > >> logic used by non-x86 architectures to be folded into sysfb as well.
> > > >>
> > > >
> > > > Any more comments on this series? It would be nice for this to land so the
> > > > simpledrm driver could be used on aarch64 EFI systems as well.
> > > >
> > > > The patches have already been acked by x86 and DRM folks.
> > >
> > > Time to get this merged, I'd say. People are asking for these patches
> > > already.
> >
> > Can we just merge via drm-misc and make sure the acks are present and
> > I'll deal with the fallout if any.
> >
> 
> Fine with me. Could you stick it on a separate branch so I can double
> check whether there are any issues wrt the EFI tree?

It'll pop up in linux-next for integration testing or you can pick up the
patch here for test-merge if you want.

And since Dave has given a blanket cheque for handling fallout he'll deal
with the need for fixups too if there's any.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
