Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF6B2A3AD
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEYJSt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 May 2019 05:18:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54318 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfEYJSt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 May 2019 05:18:49 -0400
Received: by mail-it1-f194.google.com with SMTP id h20so19699274itk.4
        for <linux-efi@vger.kernel.org>; Sat, 25 May 2019 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XET7OF75wNiBS0S9YBCqjrCeD8nZnzrXhbrqUvMdrP8=;
        b=ceHJWOclYeyDuJd7Q+aBCyW8OCwNFP8/2cWymfgFMO3AHiV4OddjDn8yfqX+xarEuT
         QDG0HGrexSN7InLbYaWJc2k4H5kadELuPS8oT/40UksxXj9l1VNDDQqVXZ5jR9AaTaqw
         MQvnpIeWvRKTyesCYEN4KeoUdjR2inujPC0435YZvqMqunD5W6k1bDxy+xa6RjdN7n3K
         dmPEMXbwYu/QtRnAnOD9DEmXFcafL68r+OEYi5eqHiEOefJosh1ceV2DTQM6ZmE3nj16
         Iu4C5tFR8tDL/XibRnPlSvqjCOOaG+NCyaWEXHT04A/s1pATYUJPIIrw37Ec+fCtEKCs
         MLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XET7OF75wNiBS0S9YBCqjrCeD8nZnzrXhbrqUvMdrP8=;
        b=GcVexNqjLtJh5VMbUNtGNojArQvUfYoyxmoslAsT5kdWM+N7KFSEvmjpN6mYz0A8g5
         ICzq4w7QET6+cDrYPSt7uZhhIE27uRzFZHRQm/OCuN6K3HIp9WSQd4NbxtsWrTPedftH
         DwlA6w/syhmaXZ28LjO3M9y8NLFFuutGWcCXU3ikUBIlOjxWAeTvY2AWsJbQ6vmGJkk0
         4SEBPqYMmnB5KpHAk3cJnwY2JEmOuH5eXt6acP53RzUu/ONvfHBWlF7MHcv4+BXEOU4g
         doqAEnq1LH1xJNQZdGCpAB1z5nkjvb40SYEPXIOQ5OM4DYNodL3Obw+oiX1y+fzA+Ocv
         kJSQ==
X-Gm-Message-State: APjAAAU3t2aZNwGLcNSCN24OBY5DaqJtF2oTz/FcVbWy7lfZT/CbY9Xr
        J1f87sR9TttC0JlsXYubBKsP1GkvIo4EGipLlEInTg==
X-Google-Smtp-Source: APXvYqz59acG8/T/AZt2D2LSZs/6ic5Hm2z3iRvDn8ZZchk6sOZJbigHdn6crFhkOiYJp3hj4oetxEMkqhWgvWAmWTM=
X-Received: by 2002:a24:d00e:: with SMTP id m14mr19817246itg.153.1558775928708;
 Sat, 25 May 2019 02:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190517082633.GA3890@zhanggen-UX430UQ> <CAKv+Gu98JNK34Q6MNOe3aq0W5rbv6hUFiuc7cHxHJat5aTk_gg@mail.gmail.com>
 <20190517090628.GA4162@zhanggen-UX430UQ> <CAKv+Gu_mwFpdtNZm9QMFn69+vOMTOpv9gvuhnBL2NBXvwkhXqg@mail.gmail.com>
 <20190523005133.GA14881@zhanggen-UX430UQ> <CAKv+Gu_wRYZdDYXso0B5m_BPJznGQXpCWq4_0u34bConu0V1ow@mail.gmail.com>
 <20190525023608.GA11613@zhanggen-UX430UQ>
In-Reply-To: <20190525023608.GA11613@zhanggen-UX430UQ>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 25 May 2019 11:18:36 +0200
Message-ID: <CAKv+Gu-agMymoGm0G8Yj-siXwtPnqYjAHeu-wQwRT47Jqd27JA@mail.gmail.com>
Subject: Re: [PATCH v2] efi_64: Fix a missing-check bug in arch/x86/platform/efi/efi_64.c
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 25 May 2019 at 04:36, Gen Zhang <blackgod016574@gmail.com> wrote:
>
> On Fri, May 24, 2019 at 06:07:10PM +0200, Ard Biesheuvel wrote:
> > Apologies for only spotting this now, but I seem to have given some bad advice.
> >
> > efi_call_phys_prolog() in efi_64.c will also return NULL if
> > (!efi_enabled(EFI_OLD_MEMMAP)), but this is not an error condition. So
> > that occurrence has to be updated: please return efi_mm.pgd instead.
> Thanks for your reply, Ard. You mean that we should return efi_mm.pgd
> when allcoation fails? And we should delete return EFI_ABORTED on the
> caller site, right? In that case, how should we handle the NULL pointer
> returned by condition if(!efi_enabled(EFI_OLD_MEMMAP)) on the caller
> site?
>

No, the other way around. I have already updated the patch, so don't
worry about it.

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=d2dc2bc7b60b936b95da4b04c2912c02974c3e9f
