Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EDF1F25
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKFTnT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 14:43:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfKFTnT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 Nov 2019 14:43:19 -0500
Received: from zn.tnic (p200300EC2F0E770015F12088A3A733FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:7700:15f1:2088:a3a7:33fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 476DB1EC0CCC;
        Wed,  6 Nov 2019 20:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573069397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ispzmoCNVnfldM6nKX7veRr0TPeyd0yKxE1spA1TaBc=;
        b=YEKNuwnXhFvXTQKghtkDmqtoKBfr+3vCzK+52VXSmLJzHsUMi2Eszo+4Y3+CPZzZ6FR7Wr
        Psetif/T1gU5xoavkZKEWuju6VydeqZkc4MLlwubc0Ojq+5x3OB7HoSoavN8i3HRs6/KPM
        GUFBk8Z/klTXeVYa+6vDlVbXTmDuni4=
Date:   Wed, 6 Nov 2019 20:43:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com
Cc:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ard.biesheuvel@linaro.org,
        boris.ostrovsky@oracle.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        eric.snowberg@oracle.com, jgross@suse.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
Message-ID: <20191106194310.GE28380@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191106170333.GD28380@zn.tnic>
 <3EABBAB2-5BEF-4FEE-8BB4-9EB4B0180B10@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3EABBAB2-5BEF-4FEE-8BB4-9EB4B0180B10@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 06, 2019 at 09:56:48AM -0800, hpa@zytor.com wrote:
> For one thing, we already have people asking for more than 4 GiB
> worth of initramfs, and especially with initramfs that huge it would
> make a *lot* of sense to allow loading it in chunks without having to
> concatenate them.

Yeah, tglx gave me his use case on IRC where they have the rootfs in the
initrd and how they would hit the limit when the rootfs has a bunch of
debug libs etc tools, which would blow up its size.

> I have been asking for a long time for initramfs creators to split the
> kernel-dependent and kernel independent parts into separate initramfs
> modules.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
