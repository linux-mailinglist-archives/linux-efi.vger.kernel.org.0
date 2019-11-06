Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60CF1C0A
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 18:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfKFRDf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 12:03:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732275AbfKFRDe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 6 Nov 2019 12:03:34 -0500
Received: from zn.tnic (p200300EC2F0E7700E06F38826D23B338.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:7700:e06f:3882:6d23:b338])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BD5C1EC0CD9;
        Wed,  6 Nov 2019 18:03:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573059813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x8TuSO4KobDwLqpo43lCyjTP+tJOg7rrILWAs8jjzZ8=;
        b=moOguzOmHuMaCYKvLkhZqnoQH9DJUJLlXLOYEGXXUFPVx2WRi6AZcEHmtpaWgW/+bVzGoQ
        vUnBlhpK9B3g8s0NAfjDR6Pdd61eqWiy6jp5ZnE9A5ziJExFZN7S/fi6hXgFQr40fwkkEQ
        ZgROC2wJHgC9wg6fCEUYxeWVG9KZCr0=
Date:   Wed, 6 Nov 2019 18:03:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, hpa@zytor.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
Message-ID: <20191106170333.GD28380@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104151354.28145-1-daniel.kiper@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 04, 2019 at 04:13:51PM +0100, Daniel Kiper wrote:
> Hi,
> 
> Due to very limited space in the setup_header this patch series introduces new
> kernel_info struct which will be used to convey information from the kernel to
> the bootloader. This way the boot protocol can be extended regardless of the
> setup_header limitations. Additionally, the patch series introduces some
> convenience features like the setup_indirect struct and the
> kernel_info.setup_type_max field.

That's all fine and dandy but I'm missing an example about what that'll
be used for, in practice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
