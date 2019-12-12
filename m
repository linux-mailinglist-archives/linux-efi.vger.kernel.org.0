Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF9411D2E3
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLLQ4x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 11:56:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39029 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfLLQ4x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 11:56:53 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so2171102qko.6
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kE3Iq+H630YEuFcNW3dYvTCcd9IIfCBLMZqxLhQGu5o=;
        b=G7nbcWmgQxxQkG4+6E0hwDwHR5s8T/zzgqfGC9C+WLmDNb+A3zmgm6+Gauk2R+Z9gZ
         7zmErUk2uP1xLNKIOPMAefpwRA0mWDzBuBdAiFpnJBuyDMhPGUFPZ3xYXGeirY81EaQB
         /wPxQ5bsDBBWzPEFJ6we5mLkAA7CY+IqSrZFlMIDbMRDh5iCm74fZdR3t8VkPYijiPvl
         mRxBLmdTO5BIcLtHfiX21WTjpZK1CIbXGR4PBFtXphIIr9Pgd8/rqkmhp4oPTJKIjcRU
         OTjWRv+nQgpcJ4jt/+jphraHPfeKaEfhB3Ydi1MTORWmCFdtLquIEQEOcKfQf70O0Ey8
         xROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kE3Iq+H630YEuFcNW3dYvTCcd9IIfCBLMZqxLhQGu5o=;
        b=rwr2TOD978JXfi2Ma4v0/WQQSQ8gKgpBYwR8cXACcSo6Gyp9bK2XPchj6IloR1cI1L
         8vwxrI4k8nJW2lRudFrXk6clF/H9Di0+eAxsGZRL2X4wxtqvnzFz1g++X+vpJ/didmJs
         T9dQEpirg4+S+Ymk93wfEGd79s4hfteZeKCH7ksGW2bOPi7tnagCh1XsHb+5m30Smh3Z
         2X70bREX8sxncWeJyXJG7GR6PDSSu18UAFvmdRku4uiXYk1r2UsCANbKESn+VvkPl/4k
         QIIfZ1Vnahn1UnmrmxLug0IHxD9ix/VvXsj6EIDCQiZfU5Eq6Fx14ZAibxQggxVFBUq5
         nR+g==
X-Gm-Message-State: APjAAAUoebkLisQyY/ei0duoA2DupODBG5Ea6crqxQTadh4lrGZdrYiV
        j63EaToHRKaj8uxSMJu4tWHuoGZ1
X-Google-Smtp-Source: APXvYqxuaY/7IS8LhHxCsffFikHZFrDtm/YeVFz+z/xF8DgYgDc9wbDwfVN7rN3Hu/LLUqFjZAUN2A==
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr9080550qka.31.1576169811950;
        Thu, 12 Dec 2019 08:56:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c66sm1921668qkf.7.2019.12.12.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 08:56:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Dec 2019 11:56:50 -0500
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/earlycon: Fix write-combine mapping on x86
Message-ID: <20191212165649.GA117958@rani.riverdale.lan>
References: <20191210232410.17890-1-nivedita@alum.mit.edu>
 <CAKv+Gu8s=kT_21WasEsTRh+6COQYD0mpzOT5n0qhD1Y+YdR3JQ@mail.gmail.com>
 <20191211110435.GP32742@smile.fi.intel.com>
 <20191211173746.GA220404@rani.riverdale.lan>
 <20191211180330.GZ32742@smile.fi.intel.com>
 <CAKv+Gu8TbPg_SGZvTc+ZHgTnAq9zYtei7ZgqpdHv=5nNpW4j1Q@mail.gmail.com>
 <20191211200007.GB32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191211200007.GB32742@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 11, 2019 at 10:00:07PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 11, 2019 at 06:06:28PM +0000, Ard Biesheuvel wrote:
> > On Wed, 11 Dec 2019 at 19:03, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Dec 11, 2019 at 12:37:46PM -0500, Arvind Sankar wrote:
> 
> > > Perhaps comment near to if can explain this.
> 
> > I'm fine with the ternary, actually. What do you feel is wrong with it?
> 
> I don't like ternary when it takes more than one line. I found them hard to
> follow.
> 
> It's anyway style, so, go ahead with it.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
Thanks. 
> > Can't we just set a global flag to MEMREMAP_WB or MEMREMAP_WC in the
> > init code, and use that directly?
> We can't use it directly in efi_earlycon_map though, so we still need to
> translate there, and we'd need an if/else in the init code, so this
> would just move the if/else from here to the init code.

Ard, re your comment, does that cover it and the patch is ok as it
stands then?
