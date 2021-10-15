Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FD42FBB8
	for <lists+linux-efi@lfdr.de>; Fri, 15 Oct 2021 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhJOTMN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Oct 2021 15:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhJOTMN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Oct 2021 15:12:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 361B56108B;
        Fri, 15 Oct 2021 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634325006;
        bh=vuv4ThUrmJnicKqrCER7VCEEShBnDhSJeqRegsHiVbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmFRNxZRaTKcfqlW3ItWPQyjkGDb+Na1j8MR3W0Hjgl8Ez7T7YZzFQBS0Iir0P7Oh
         V3Xh2lN9y1e/OZUeUIFnAy1+2B5g01lihs2A/taFkfoi+xsIRPOj754gHLj1Y5OoRz
         K8ZF+E/+ygtsk4ZM290UczzytSO9zDnDCt9gtnlb2isS32jhJGKgE/WBnYJQL/JH3e
         MHuyJsFgkzTRPppOnbhjT6BCBZ6C5+CpkOFj7TUl4nVthIh+ZWdh7W5noZorDDIt2a
         AkoRL82U0XbG4Csaf3h5kcF749FJilHEwk+uYRasXSc2Pu2qac5bc/FoMn3WwMKVh0
         i3GNgkcnG6qNQ==
Date:   Fri, 15 Oct 2021 12:10:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] efi: select CRYPTO for EFI_EMBEDDED_FIRMWARE
Message-ID: <YWnSDFPOx0U6iziT@gmail.com>
References: <20211015131946.13374-1-vegard.nossum@oracle.com>
 <CAMj1kXH5U7Ztv_vn=ej8GJh9hWoVetQz3RxihoYL8WxdLJZMQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH5U7Ztv_vn=ej8GJh9hWoVetQz3RxihoYL8WxdLJZMQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 15, 2021 at 03:55:01PM +0200, Ard Biesheuvel wrote:
> (+ crypto folks)
> 
> On Fri, 15 Oct 2021 at 15:24, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >
> > Fix the following build warning:
> >
> >   WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
> >     Depends on [n]: CRYPTO [=n]
> >     Selected by [y]:
> >     - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]
> >
> > Fixes: f0df68d5bae88 ("efi: Add embedded peripheral firmware support")
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> 
> Hello Vegard,
> 
> I don't think this is the right fix, to be honest. The crypto library
> functions have no dependencies at all on the crypto API, so I think it
> would be better to do something like the below:

Actually some of the crypto library functions need __crypto_xor() and
__crypto_memneq() which are only compiled when CRYPTO.  So that will need to be
fixed by moving those functions to an appropriate place first.

- Eric
