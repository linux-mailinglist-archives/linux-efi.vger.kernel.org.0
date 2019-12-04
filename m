Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEAD112EE0
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfLDPpY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 10:45:24 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39571 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfLDPpY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 10:45:24 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so5029qvk.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kROhKPYxklFqZ6CrAQSnfrXhhvAUDuc12mlOZXqijSI=;
        b=rpYfpo3VqMQSrS9g3Qb+zahQa4UYUwNRU22IolkVa5wwo9WcnimsA91CQkAmDDo+Gr
         ZECCKxZmSQY1UKfZ8SysgKlwsoZ5+xsu1vD1sIGzmMf3i5iPBBe3bIEpvIq5BmB53QIa
         NQl6p/XxapzmChq+apebPrMOsB8TapVQymBH3FYspA/flZCDSELJS2pxIC6GBpZEIQPh
         W/ehySC9HRFbdN4y1iHyq6q6Z6G44Y21+sibVLPGPYWugjkW5XCNxzZcHEWEiYAXimGa
         gAaLxqxBbOoKbkrYdxz107XK3WkSyQlmYNhTARqtc5qebjo2Q9/nNEr1WFPWDMUtzo/v
         sXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kROhKPYxklFqZ6CrAQSnfrXhhvAUDuc12mlOZXqijSI=;
        b=C0qxaaBme8NgLsqJdql3BOu6p/Yq9BoQaRWR9etJs6lAEtGWVg0QGfTL15pcXNYUsi
         ipoxXwlOZ25PdWEAvO4SrOhJwQAbHN8+MpbTxK0hwonjRQT6h9kamMymEv6bJ9NTCB0b
         S+BZFBm+V/CQ6tzEGx99H8fzaD37CYDWySsPS0vm84cIQS/hnceiu3HJ/HdfhcVWauGp
         MI+NghdHyVOqJ50qGur0dvOdyK8KZLnFxxLaJP6OWH0kEeC50V3nEC0R3wSW+1Hc4z3p
         7vlHGfBq/0Pw6D4ujuavqsON2KLYSESUppRYgIXmySECeVhBuboAzUQE4QycLRaeMoPY
         gKWw==
X-Gm-Message-State: APjAAAVC2uM/DcVSJN1PhTqykfT2yA3Z9Nvbo3Q4LFElpL34meUo+KTG
        T241A5wVHHABpXGmM9niTDY=
X-Google-Smtp-Source: APXvYqyayhhVyg5pdyvlKMT/+MeEOBHE0uwoT5TqQ83pMvCAFEExIQjnvapeDhqjqixVab9rM66KLw==
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr3259420qvb.222.1575474323115;
        Wed, 04 Dec 2019 07:45:23 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l7sm4105298qtf.84.2019.12.04.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:45:23 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Dec 2019 10:45:21 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/2] efi/gop: Fix return value of setup_gop32/64
Message-ID: <20191204154521.GD626282@rani.riverdale.lan>
References: <20191203214728.19264-1-nivedita@alum.mit.edu>
 <CAKv+Gu-xTUBhV3Git9opPRs5sJvsCSHrcy9-=5Ac+nMaZhe7-w@mail.gmail.com>
 <20191204152348.GA626282@rani.riverdale.lan>
 <CAKv+Gu8LHeAM6wGS+abWPX9Mu4fkd_HBwP=XxzyvuzVZy01xLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8LHeAM6wGS+abWPX9Mu4fkd_HBwP=XxzyvuzVZy01xLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 04, 2019 at 03:28:30PM +0000, Ard Biesheuvel wrote:
> On Wed, 4 Dec 2019 at 15:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Dec 04, 2019 at 03:03:04PM +0000, Ard Biesheuvel wrote:
> > > On Tue, 3 Dec 2019 at 21:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > There are two ways the status return of setup_gop32/64 could be
> > > > incorrect.
> > > >
> > > > 1. If we don't find a usable GOP because none of them have a framebuffer
> > > > (i.e. they were all PIXEL_BLT_ONLY), but all the efi calls succeeded, we
> > > > will return EFI_SUCCESS even though we didn't find a usable GOP. Return
> > > > EFI_NOT_FOUND instead, allowing the caller to probe for UGA instead.
> > > >
> > > > 2. If we do find a usable GOP, but one of the subsequent ones fails in
> > > > an EFI call while checking if any support console output, we may return
> > > > an EFI error code even though we found a usable GOP. Fix this by always
> > > > returning EFI_SUCCESS if we got a usable GOP.
> > > >
> > >
> > > Please split this into 2 patches
> >
> > Not quite following -- what should be the two pieces? Are you saying to
> > split the success return and the failure return into two patches -- that
> > seems excessively fine-grained.
> >
> 
> Your commit log describes two distinct changes 1. and 2. The patch
> addresses those two issues, and in addition, moves variable
> declarations around. The result is much more difficult to read than
> necessary.
> 
Ok fair enough. I'll do that in v2 and just leave out the declaration
move then.
