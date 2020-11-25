Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD92C3B1D
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgKYIb7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 03:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgKYIb7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Nov 2020 03:31:59 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5DE20857;
        Wed, 25 Nov 2020 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606293111;
        bh=0TbyJFqC/MKrXSc4TqTalhP9Fe3e/+ybdRR3JhOb0ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJwOwqbB8LmAa1K+BF1QhX/yXjxFZ0M3TnSxwcLhGyScRXXPciU4IZQtkRZtDrfqS
         KptcoI3zrPWJc02mBSgTTKJMb1nLMP0xroadkDPSu31842DaAVUCXuV1DFqLGf/KRi
         fMFuiepDf0WU9x/8iiOag4JOpCnREImSLgx+ZWoE=
Date:   Wed, 25 Nov 2020 09:32:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.garrett@nebula.com, jk@ozlabs.org
Subject: Re: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Message-ID: <X74WuTEjLXzAziwJ@kroah.com>
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
 <c4c57a4b65d57bb7b2e87870a92558a5@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c57a4b65d57bb7b2e87870a92558a5@natalenko.name>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 24, 2020 at 10:24:27PM +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> On 24.11.2020 15:23, Ard Biesheuvel wrote:
> > Surely caused by
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/efivarfs?id=fe5186cf12e30facfe261e9be6c7904a170bd822
> 
> This also soaked through the stable queue into v5.9.11, and now the same BUG
> is triggered in the latest stable kernel.
> 
> /cc Greg

 cc: me for what?

/me has no context as to what to do here...

thanks,

greg k-h
