Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B31BEA45
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgD2VvN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2VvN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:51:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B46C03C1AE;
        Wed, 29 Apr 2020 14:51:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s63so3729834qke.4;
        Wed, 29 Apr 2020 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yI4eOYJfhpsBqlg1PM3LtQp48NpgcJsBjjuzAmHhDUU=;
        b=obgSTAYx8xvFZBa/lm1gbkdL7zfTMb0zKB+DZ6UgbMYY3FCi9VncqKfnWo4wCSSoxy
         hUF4ttq8G0B0F0aAmNQOP8mfiRNDcwww9xtsykEZxWTxIVi/K6MjDkbqmZVVdAlxLuJ3
         N1svbTiYK+CPufQYVkTPQ1AyggVG/I5SRWD61RtxGUwnOo7L43y+XqPJmF+roZdfvd91
         Hk+sS9jLxHxFEtfsoNXWBneiaaisSf84/+DASsq8HQft5jNYymx0dTQxLAICPSqyRisl
         A0eVZ3XkIOHh1dTxB133U/d6S0g3Mb0e/lWn6CVCrdZd2uAktOuFzAt2gKoSYwuLuUto
         JbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yI4eOYJfhpsBqlg1PM3LtQp48NpgcJsBjjuzAmHhDUU=;
        b=pZW+kJH4wEF8vK0YGft/XeWrEmohxioCixvXnrqSxJ8c9izWf5NLTXBZBdcVYCqV4x
         M1cYDJch2FH+obU8aupy0QTpo2OUtfWBNUFoxM/qA1dpfJd9leBNBuO0lC3/+D9owaHC
         0lkp9olptESDG7cekx9GzOOlyC1w/XTdSALRa3+rAUDrA7Zx7DTjdwpi0dqiYSHyeLIS
         xd2N9fWT+W84ujRmxj2nkompdROiPx2UWpf20e+iPCOy/TCaMxLSV1sAIfgpC8DtL8jj
         w6s65oFqrGG5DSuVR8Hw9fdPXzkxY32ZIdNtmvr7iXHwe2lxtSCcgfKshMXU2GXPG8kD
         VsNg==
X-Gm-Message-State: AGi0PuaJprwf8iepfbNOv/+jYA479TMWbEhJRv+DmGd6Xd+NN2F8h75p
        XFRf0VXYRek1B8NgfrFUlAIOWG3n5XM=
X-Google-Smtp-Source: APiQypJoAu+Fpbyj7std7PGrE6L8FhaqosDACdbBSy1HeEz4BOypNoQTTpm3Z8dGOCzynxfEj0z6qw==
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr562712qke.307.1588197069303;
        Wed, 29 Apr 2020 14:51:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a3sm328391qka.61.2020.04.29.14.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:51:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 17:51:06 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
Message-ID: <20200429215106.GE1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu>
 <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
 <20200429214332.GC1621173@rani.riverdale.lan>
 <CAMj1kXEwvtQoWj2GjMzLY+wnaMu9cUP8jRpwuQBC0fpEy31r_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEwvtQoWj2GjMzLY+wnaMu9cUP8jRpwuQBC0fpEy31r_w@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 11:45:17PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 23:43, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> > > >
> > > > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > > > Use pr_efi_err instead of bare efi_printk for error messages.
> > > >
> > > > Perhaps it'd be better to rename pr_efi_err to eri_err
> > > > to it's clearer it's a typical efi_ logging function.
> > > >
> > > > $ git grep -w --name-only pr_efi_err | \
> > > >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> > > >
> > >
> > > Yeah, pr_efi_err() is probably not the best name
> >
> > Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?
> 
> If you don't mind spinning another couple of patches, yes, that would
> be helpful.

No problem.

> 
> Let's use efi_pr_info and efi_pr_err to stay aligned with the ordinary
> counterparts

Right, for some reason I thought it was pr_error but it's actually
pr_err.
