Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6B1BEC04
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2WVB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WVB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 18:21:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C73C03C1AE;
        Wed, 29 Apr 2020 15:21:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so3374993qtb.5;
        Wed, 29 Apr 2020 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QlkVaiVcBOHNkB5ExNKJRxqXIe1PfFKILjvlG5hRlg0=;
        b=iSYywjiPEaoZgqGWHWsYQtRoLNwu6veFylWlF6ZsYH4D2pE652/y3b0TG5vv7uPuS1
         ssnE4Vw3meDDMdj62qMuqDD+V9w950rvXy8hPdN1Q8+/aeJ6nuJtIQzCB/y6PU27eucr
         /nq4mT6lrPmHzOq9Y4Lv+nicLSAFI5zMDDMNhmG730hYmsEcamMSKV91Syf1IpACDDVW
         yNY+t4469MPznK0HcvgR/Ry8Ayt2eFl3mWzVv/rdjbkmy9Utd8f50swv37v6kKrxxXBR
         tncPDIdPoz5LC0ouj7mZ7Q4hzvODcgMfQ3cSRggPKlDnhT8Tl4F8QqdhAB/zcVxu3Cbx
         ogJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QlkVaiVcBOHNkB5ExNKJRxqXIe1PfFKILjvlG5hRlg0=;
        b=YBVB1VeDSpOt1jJwb8nMAjbHdiFm38TT4dShVdP7tm8vwSbWsEbMiadwTXowBxn7rc
         mqn+51LtSSJnu29J/K1yo5gSEY5ZdW5NsZGZUQDUif4S4FVkvnL6chE/C993qWCme4mT
         p3rLv9zOI5q7thkOdmlHs7qxCoz4YKgH0bTtnrIMbUA/QPHlAH4TUK05qEn20BPvnusJ
         VmZvMZyeTxci8hOFPRFkdBAFNfx8PZ//Vuhbi69z6brl+TrFpdahVikHuwDGcYCJr6pn
         D73cSx4lTOFYpYtoWh8okFw4qWz2HJmyaXhDSu0G9Qd3MRDHl5ZVYlq0hrRzwV20INl8
         Q9Hg==
X-Gm-Message-State: AGi0Pub+UXdA6uatuisETw28Omkpqd9l4/xLLfpxr0AgDB+29zFiyfV6
        VsSmG3YLFbZLMNEbQLxNdi5015JTCgU=
X-Google-Smtp-Source: APiQypJtRbZMrEQXh43TsjlPJyH0lrH1FMh1wR7ThB/RYDQVccxT8lyADglxmV+Y2U5rD3wOrhTx3Q==
X-Received: by 2002:ac8:4e45:: with SMTP id e5mr548115qtw.101.1588198860273;
        Wed, 29 Apr 2020 15:21:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y17sm359287qky.33.2020.04.29.15.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:20:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 18:20:57 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
Message-ID: <20200429222057.GA1645040@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu>
 <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
 <20200429214332.GC1621173@rani.riverdale.lan>
 <31b23951ee2b8e2391f3208b60a7132df18be74e.camel@perches.com>
 <CAMj1kXFJfK=tspytknqdABRfYMhA23FWOs8QoasX1jZ6z=F3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFJfK=tspytknqdABRfYMhA23FWOs8QoasX1jZ6z=F3Gg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 11:55:04PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 23:53, Joe Perches <joe@perches.com> wrote:
> >
> > On Wed, 2020-04-29 at 17:43 -0400, Arvind Sankar wrote:
> > > On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > > > >
> > > > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > > > so it's clearer it's a typical efi_ logging function.
> > > > >
> > > > > $ git grep -w --name-only pr_efi_err | \
> > > > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > > > >
> > > >
> > > > Yeah, pr_efi_err() is probably not the best name
> > >
> > > Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?
> >
> > Perhaps not use pr_ in the name at all.
> >
> > I suggest:
> >
> > pr_efi          -> efi_info (or efi_debug or efi_dbg)
> >                    (it is guarded by an efi_quiet flag, default: on)
> > pr_efi_err      -> efi_err
> >
> 
> Agreed. Shorter is better if there is no risk of confusion..

Ok, I'll use efi_info/efi_err. We could add debugging output as
efi_debug later, enabled if efi=debug is specified.

While we're here: most of the existing cases of pr_efi look like notice
or info level, except maybe these two, which probably should be at least
warnings?

drivers/firmware/efi/libstub/arm64-stub.c
62: pr_efi("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");

drivers/firmware/efi/libstub/efi-stub.c
254: pr_efi("Ignoring DTB from command line.\n");
