Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3143E452
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 16:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJ1O5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 10:57:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37630 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1O5q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 28 Oct 2021 10:57:46 -0400
Received: from zn.tnic (p200300ec2f13a70087f257aa50e887e8.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:a700:87f2:57aa:50e8:87e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1667D1EC0399;
        Thu, 28 Oct 2021 16:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635432918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wit40pmGBFUUYMqFuqQPfke5mp2YXmEvMWSrnWJwDOE=;
        b=rcLtq+TuOSFEVsaab1ni9tPdIkDEHZTKgRP52MlLT4mCYQlgkg2EBszEZ312FzNdaR7vHK
        JyKQTw/XbJzWJ6jLxi01HGxLB0Ew6LvE8y+OCPGRtZja7ZLqABZ10mvBlZkZjsz+OulP5A
        lch8pNmSPhXeYZnexjZwp287pIMjChU=
Date:   Thu, 28 Oct 2021 16:55:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
Message-ID: <YXq50yzJQqrJk13v@zn.tnic>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com>
 <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 28, 2021 at 11:28:57AM -0300, Martin Fernandez wrote:
> Userspace will just read this values and conclude (as it is right now)
> if your memory is able to do encryption.

And do what with that information?

> As I mentioned above, with the TME part, you will conclude if your
> memory is being encrypted or not, and if not, you can see why not.
> For example, if you have TME, you have it enabled but you have
> crypto_capable = 0 in your nodes, then you probably have an old BIOS
> that doesn't support UEFI 2.7, and that's why you don't have your
> memory flagged with EFI_MEMORY_CPU_CRYPTO. And then you can tell to
> the user that maybe a BIOS update will fix that.

If it is all about dumping this new EFI_MEMORY_CPU_CRYPTO
attribute for each region, you can extend efi_print_memmap() and
efi_md_typeattr_format() to show that in dmesg and not add a bunch of
code to the kernel.

If you wanna query encryption status, we have flags in /proc/cpuinfo for
that and we can add more if needed.

The stress being on "if" because from all this intro text I cannot find
a single persuasive use case.

So what is the real-life use case?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
