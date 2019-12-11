Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1131F11BA73
	for <lists+linux-efi@lfdr.de>; Wed, 11 Dec 2019 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfLKRht (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Dec 2019 12:37:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34483 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKRht (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Dec 2019 12:37:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id d202so20388163qkb.1
        for <linux-efi@vger.kernel.org>; Wed, 11 Dec 2019 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDrhSmyN01JdJd4gFsHwIcGgM+/51/oVamxPHVLTsr8=;
        b=jJYoj4uw1kPLkqB/DJaYSCwq4oekECsX4q4Fg/J39CPD2w93TYh88UxYrusanS1vxP
         japGTdchPP3phP+Qy9VZiFbFRql4n9I8bvF81CoUPMZ7+Ln62SQ2j/uh6ocsTxx023vZ
         Wtzkg0LeIIzUqsUmaOghjKMw7ezkl7rhW5P5ro6G00RHk9iWLYiT9uGBt/4FfK1wC6ZO
         Jw22ydXBBRlajQWE19PRCiaes+2/N6CuW+9KX2mk1zXAD3kHuOAoB70Pt7fWNhViLpkd
         FHUM23zxLLN3Oq5bHAQlACjRi7lP632yVSUoM0rNfzX7Y7PSqsFk/QflNPveoRyQYIea
         c6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDrhSmyN01JdJd4gFsHwIcGgM+/51/oVamxPHVLTsr8=;
        b=eN7C3uR4VEY9WqVw6DoakhOspzA+5B8l7NWLoH3x2x8L3eTJc1DLhC59K4gBxe5uRY
         Rb6nm17Lp3t0SbpQZRUFi4+9d8UIfzSbrVJkuYWVMaMfUdfF9OI0lG/7aoBCUhKBlrav
         FjKFnE1OUfPYrvpDmGI+d39zU02dQDnn2HQRV92KySDXR/+7tRx43tCJj2yvuA+5W2Tc
         K2sVTwH48YKZc/MEzRhORMjvLNW9wX9yFZKWxfdwlq5JVXOI1dyNEqiRlYK7GNRjy1ZN
         kDcmi2PsHAdPfeXkY5qXKX7DJWdeLO8u4crHizS18X5rJpNpjVo66gMNwDdFEtsAfmlp
         mOFA==
X-Gm-Message-State: APjAAAVE0pFyJmh76dH6trzc2iieUmD/fHL8vC1OM0i+PxvCGqKYOxDg
        oqjLPj+0jMp9MIcEDldYAd0=
X-Google-Smtp-Source: APXvYqxBhFvXW7n5cEOg92QkUMgVQVGBfmmMwiAb/VQ1ApPzGuSnFMw+eE2enVww3SN0fHgCFC2BAA==
X-Received: by 2002:a37:8b85:: with SMTP id n127mr4161389qkd.353.1576085868467;
        Wed, 11 Dec 2019 09:37:48 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i2sm1111824qte.87.2019.12.11.09.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:37:48 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Dec 2019 12:37:46 -0500
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191211173746.GA220404@rani.riverdale.lan>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211110435.GP32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 01:04:35PM +0200, Andy Shevchenko wrote:
> 
> Make sense.
> One comment below.
> 
> > > -       if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
> > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
> > > -       else
> > > -               efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
> > > +       efi_fb = memremap(fb_base, screen_info.lfb_size,
> > > +                         fb_wb ? MEMREMAP_WB : MEMREMAP_WC);
> 
> I would really like to keep the style with if-else.
> 
I edited this back to the if/else and then realized why I chose the
ternary. It makes it easier for the reader to see that the only thing
that depends on fb_wb is the MEMREMAP_ flag that gets used, while with
the if/else the reader needs to compare both function invocations to see
that that's the only difference.

It's not a big deal, so if you still prefer the if/else I'll revise the
patch.
