Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285F526B097
	for <lists+linux-efi@lfdr.de>; Wed, 16 Sep 2020 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIOWO7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 15 Sep 2020 18:14:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36306 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgIOQhQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 15 Sep 2020 12:37:16 -0400
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 647901EC0328;
        Tue, 15 Sep 2020 18:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600187775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R4/KSvJodDTPWe9S1DH/Kj79tEBFBh4DMsZtvtyhfGw=;
        b=pwO1UNl/PLU5GDJTdKWXGaCYxEwToe9U7hjjH5lJkbChNV5MIMN61ccu0A20tPkPka5BKU
        ISR/sTdxp6j4xaIittEDYB5sH3SC6GDNNaH2QEHQPH2cZnIqotUSQpxHrdsUdZhd28ZEzz
        doCBRc/L0h1jjgluquSCjcyuhG775XM=
Date:   Tue, 15 Sep 2020 18:36:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alex Kluver <alex.kluver@hpe.com>
Cc:     linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, mchehab@kernel.org,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        kluveralex@gmail.com
Subject: Re: [PATCH v2 2/2] cper,edac,efi: Memory Error Record: bank
 group/address and chip id
Message-ID: <20200915163613.GP14436@zn.tnic>
References: <20200819143544.155096-1-alex.kluver@hpe.com>
 <20200819143544.155096-3-alex.kluver@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819143544.155096-3-alex.kluver@hpe.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 19, 2020 at 09:35:44AM -0500, Alex Kluver wrote:
> Updates to the UEFI 2.8 Memory Error Record allow splitting the bank field
> into bank address and bank group, and using the last 3 bits of the extended
> field as a chip identifier.
> 
> When needed, print correct version of bank field, bank group, and chip
> identification
> 
> Based on UEFI 2.8 Table 299. Memory Error Record

Whoever commits this - those last two sentences need fullstops.

> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> Reviewed-by: Kyle Meyer <kyle.meyer@hpe.com>
> Reviewed-by: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
> ---
> 
> v1 -> v2:
>    * Add static inline cper_get_mem_extension() to make it
>     more readable, as suggested by Borislav Petkov.
> 
>    * Add second patch for bank field, bank group, and chip id.
> 
> ---
>  drivers/edac/ghes_edac.c    | 9 +++++++++
>  drivers/firmware/efi/cper.c | 9 +++++++++
>  include/linux/cper.h        | 8 ++++++++
>  3 files changed, 26 insertions(+)

For the EDAC bits:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
