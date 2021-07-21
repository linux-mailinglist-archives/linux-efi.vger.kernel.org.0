Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254663D0DFD
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhGULAW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbhGUKnA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 06:43:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBABC061574
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 04:23:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c12so1792126wrt.3
        for <linux-efi@vger.kernel.org>; Wed, 21 Jul 2021 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5r4SARj9UXSpcoZXx50eoUO8FuzdCp7+FLIK6b9NrWI=;
        b=Cg//U4Y/1gDgxt7k5xmPgDyo0T0uwh0g+60Sh5AVkHS8/ei3NhtyBF6YUUZECQJ58p
         cUzo7OyBMRL1w7ZINYSSzxOiPjjdfCP8gmgVRIQrnKhlqKVsz4YOjpHWokj0QfreyYfD
         rHb7sejYFAOJAr8kwsiMNxNWVcph5CirgTBgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5r4SARj9UXSpcoZXx50eoUO8FuzdCp7+FLIK6b9NrWI=;
        b=IRNo5Rco8cpsLNsKYPEr21FPYIvI3cgKHAw6q2SWX2MGZQTbOmE+NXJz2mwF8zIh0y
         q2WMJEoXEmd4jURjvJfMFbX42wSpgryZ8dvblekgQXsE1POFRj5g71yN8RYvYgC4zKPU
         ZcjtmfjYU+vF0M1gaYS7lYVOFv0xZm37jK3lQwnq6A4kgrD7BIsIVi82da3A3NKFe3ee
         5/yFc1sm2a6swjIKLhNOexjbQW+VX+Jl1yOg95Ynb0Q6NUF5ijyg3zcyqW0JvX9C/mwN
         J/A6rix4pg32lOJq3QEIyMXy4s12z9bvLeqtuyu3un8xuazgtHftlpQF8xKAUU/4ESAG
         Vwpw==
X-Gm-Message-State: AOAM5312q7cr9vDkgxfNnIEhAbod8kCNF0EIFsvJKZhiBxbYk9f2xkCt
        l4u4nKq6UJexLVlPXrla1bIMrw==
X-Google-Smtp-Source: ABdhPJz23x9YYT7kn6ADtNpcXFeq0lIiwVkk98kY+doYcdNtjlUQIlafrn5wFGkpRjXik49b18LU5g==
X-Received: by 2002:a5d:6482:: with SMTP id o2mr41030703wri.367.1626866616114;
        Wed, 21 Jul 2021 04:23:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f26sm21862934wmc.29.2021.07.21.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:23:35 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:23:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v3 0/2] allow simple{fb, drm} drivers to be used on
 non-x86 EFI platforms
Message-ID: <YPgDtQ0sGRlvNH0F@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, Dave Airlie <airlied@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Russell King <linux@armlinux.org.uk>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <8dd26141-a09c-39e2-5174-4cad8d21c49c@suse.de>
 <CAPM=9tyfNPa2f5PDBLm4w_H_riEQ5P3rEhX73YGE1y_ygRox+w@mail.gmail.com>
 <CAMj1kXErHteZ+MKYvp=yYmwVxV3A=vjtnG351hZHV+3BPwDQvw@mail.gmail.com>
 <YPbJJ/0tSO/fuW7a@phenom.ffwll.local>
 <03f0edef-e54e-8a2a-4b50-683d3d42e249@redhat.com>
 <YPbWrV/cIODdgu6A@phenom.ffwll.local>
 <37e05f02-b810-0cb1-cc4f-95711cd148d9@suse.de>
 <44a75f18-e3a6-f764-b0ec-ce3ac05805a9@redhat.com>
 <1e85fae7-ef95-b2f7-3463-e90958e54684@suse.de>
 <0ad257ce-44d9-beea-8afb-c879146c523b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad257ce-44d9-beea-8afb-c879146c523b@redhat.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 21, 2021 at 12:15:12PM +0200, Javier Martinez Canillas wrote:
> On 7/21/21 12:07 PM, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 21.07.21 um 07:09 schrieb Javier Martinez Canillas:
> > ...
> >>>
> >>> Can I simply put the patches in to drm-misc-next? There was some talk
> >>> about a topic branch?
> >>>
> >>
> >> ... which AFAIU means that there's no need for a topic branch, since the
> >> patches will be present in linux-next. And the EFI folks can use that to
> >> check if there are any integration issues or regressions caused by these.
> > 
> > Merged into drm-misc-next.
> > 
> 
> Thanks a lot Thomas for all your help!

Yeah topic branch makes sense when we have further work that will build on
top of a patch sets in at latest _two_ different subsystems, and it
doesn't make sense to just merge it all in one place (because too much
work, or a refactoring that's too invasive and will cause random conflicts
with subsequent work in the same subsystem, or ...).

Otherwise just acks and then merge in one place. We shouldn't do
bureaucratics like topic branches if there's not an actual need for them.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
