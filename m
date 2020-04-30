Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A131C084F
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD3Ukp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3Ukp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Apr 2020 16:40:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1256C035494;
        Thu, 30 Apr 2020 13:40:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c63so7275660qke.2;
        Thu, 30 Apr 2020 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2wXB9P7L6VKnvrEKDuVZ8Fz1x78dwH0yzpQ7LI1qBdQ=;
        b=nYuOYdv7i3bBXGdXg/0tRS14pcT5A/jnwkPsmkk7D2/iEGPitWHtu2SSm4fBYB72uz
         LEJYj/5tICP1sWA5mpc6tpGeHNQpUEv63D2kgZMEkoV16sCqRd0DmxYIa2VrMlGjlx4k
         J3MaAYrzCAyGYMYWDg00z3zuWehzrdx/Tl7/1HxNZWDPnlMX94qfGN9CCcLlqzKiFykZ
         iYHLT7L9R8ZFfjsuhbC25FepzOh5QLLwR7hgvRe1BraJvLRtTlut50bu2Nnhkugus2BD
         HMPaCPRgOHN0mxAwh6YcpzPeOb/o+22/bJ3Uys5gJDP9n25p3bCb0BxkUG4J92e+ADeB
         yvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2wXB9P7L6VKnvrEKDuVZ8Fz1x78dwH0yzpQ7LI1qBdQ=;
        b=DB6eCqP6MxQrG2wSBCxhEHFh5yFZRuFMw6MMeFRps1L2fuIwLQe0jRTlbw5ihAt36/
         Jyfdzyj3EGUJhUvBjRtJ80EaD8WigM6g4n6M3S9pRWM1dY+TYYXAPHWfQ4083amL4Bw0
         ZHMsUWaFZC6Nr72NzF/hH9xGkv6bFnsSYT3AZCRPp8HGjfu4Z53dVLBgqQRYmgdPayiu
         WeFrYFeXZB0/cuSWAss2Myj/6FFtZ2qFk720MjKK72vtCXRYOcfNUhXkVeqm98IlR17e
         GSrBO9Jof25XI+JUCXtpnepv7tyH+vTS8qXVIDHyLFWBJhidkUftg5TOCRMASKX5vSCx
         nCFA==
X-Gm-Message-State: AGi0PuZinGCLYQMMEjQowOAsL3ulBO3dz+oi4C+6CR8RSz18Lbrgr4cG
        hr1uXLo9LgZsziWj7JLi/Eg=
X-Google-Smtp-Source: APiQypK2X+EbL4/u6yuToTVoXvzdrYETv1gNeyOhrBY1Iwa28a1bEOJ2lPZub08UxLUQHzoVu2aD2g==
X-Received: by 2002:a05:620a:1347:: with SMTP id c7mr396651qkl.246.1588279244010;
        Thu, 30 Apr 2020 13:40:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l9sm674497qth.60.2020.04.30.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:40:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 30 Apr 2020 16:40:41 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH 1/2] efi/libstub: efi_info/efi_err message neatening
Message-ID: <20200430204041.GA2579913@rani.riverdale.lan>
References: <20200430182843.2510180-1-nivedita@alum.mit.edu>
 <091e3fc3bdbc5f480af7d3b3ac096d174a4480d0.1588273612.git.joe@perches.com>
 <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGMnTfYiU_vMDYG0uy7Na7wy=5DRHERTzZQeb4UBusn0g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 30, 2020 at 09:29:46PM +0200, Ard Biesheuvel wrote:
> On Thu, 30 Apr 2020 at 21:12, Joe Perches <joe@perches.com> wrote:
> >
> > Use a standard style for these output logging messages.
> >
> > Miscellanea:
> >
> > o Use more common macro #defines with fmt, ##__VA_ARGS__
> > 0 Remove trailing messages periods and odd ' uses
> > o Remove embedded function names and use %s, __func__
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >
> > Perhaps these trivialities on top of this series?
> >
> 
> The EFI printing routines don't actually support format strings.
> 

The x86 real-mode bootup code actually has a printf.o that clocks in at
under 2k. We could add it in, and it would also be nice to move it into
lib or something, since at least alpha and powerpc implement something
very similar for boot-time messages.
