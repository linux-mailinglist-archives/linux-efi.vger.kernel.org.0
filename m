Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993DA178660
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 00:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgCCXfB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 18:35:01 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36519 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgCCXfB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 18:35:01 -0500
Received: by mail-qk1-f195.google.com with SMTP id u25so757197qkk.3;
        Tue, 03 Mar 2020 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mv8DBr/4IZAnH6uZUX2k2VHUQoNtWWcAjMVSdauA5Qw=;
        b=KshmkRwngcwfRq2RmS2yFVvllh7z2ekdPd9uwWhU/5MHzOnyNnHM9vG6r45o9fNOeZ
         niFoV6ESGVeOhRtxnDX8qBD2mCRlhfmyKiiunZ+iLFW77uBg6yAawO8wAz+SXATFniak
         ESrroSBXfFhJ954OiRiYGncFRJr4Gf8H5PaoSs103N6zn+ubhlIQeNZ3DdaB1kVxdqMg
         ZRoQSneUfjqOgC/+Q3giHLwMFXefh4n8i/fklN/eF3U+XiYkxmqYRfilijOzYts1N9jt
         WSGXHEEW6IyIFNu2+4JwvbHAgW4N1Oj9/1hRoU/ylr+sxy2FMEbrvcqsQWJAsA/s09/r
         iCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mv8DBr/4IZAnH6uZUX2k2VHUQoNtWWcAjMVSdauA5Qw=;
        b=EyaIR0GSSRWLooki8cB7cN2OyCFGMsjODYPJ2zICgiA+1obwEwFsd9y6G9NDhZTL2O
         0N7q6O5AGQ/D1cGX6Y96KT4JUA32H2QM0INAfwJt3NqajP0sOu0bw93ZVu8tGkG1tgnf
         0FntEg0XTHaScPW5ZfYXpAoowm5x1l4nFLkxAg16FVRJvWYpcEOyHloVXTjmDnYICbl5
         R++SWQPO7G69abSDnavJfPkVeFVKeScY/+7v41lZhE0BcnvAUKwTz5H6IcsluPvWMsA0
         qOu9zGZnnHdr4gzu180x2O4AYbHg5fA6GS5/7hcW49QO0hoTvVg2hibHy37kjPhsJxF5
         PRtg==
X-Gm-Message-State: ANhLgQ3KFpfbCug+q0aYQ4x7Y6LLKYknkT/gvFWbksVBbnf/WzueXm22
        8BDdxgwzylTQLVYRjzM49M5ofNvBlg0=
X-Google-Smtp-Source: ADFU+vtZBBbwMF3sMJrjPdpFShiTNBAjg4Ok9/h9xJ6x/5l2XJPzFxYac5IU2kQGXl5/Z7WBGhWGow==
X-Received: by 2002:a37:270a:: with SMTP id n10mr489200qkn.244.1583278500230;
        Tue, 03 Mar 2020 15:35:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d5sm13268330qke.105.2020.03.03.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:34:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 3 Mar 2020 18:34:58 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] efi/x86: Don't relocate the kernel unless
 necessary
Message-ID: <20200303233457.GA154112@rani.riverdale.lan>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-1-nivedita@alum.mit.edu>
 <20200303221205.4048668-6-nivedita@alum.mit.edu>
 <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9LON5SeJ7UMTeHxP1OcSkz_eGGunpXx_csjh_fp1PhDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 12:08:33AM +0100, Ard Biesheuvel wrote:
> On Tue, 3 Mar 2020 at 23:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Add alignment slack to the PE image size, so that we can realign the
> > decompression buffer within the space allocated for the image.
> >
> > Only relocate the kernel if it has been loaded at an unsuitable address:
> > * Below LOAD_PHYSICAL_ADDR, or
> > * Above 64T for 64-bit and 512MiB for 32-bit
> >
> > For 32-bit, the upper limit is conservative, but the exact limit can be
> > difficult to calculate.
> >
> 
> Could we get rid of the call to efi_low_alloc_above() in
> efi_relocate_kernel(), and just allocate top down with the right
> alignment? I'd like to get rid of efi_low_alloc() et al if we can.
> 

But we don't have a top-down allocator, do we? ALLOCATE_MAX_ADDRESS
guarantees the maximum, but it doesn't guarantee that you'll be as high
as possible.
