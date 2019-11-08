Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AECF4C86
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 14:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKHNDq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 08:03:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfKHNDp (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Nov 2019 08:03:45 -0500
Received: from zn.tnic (p200300EC2F0D3700CD138237C4E0A6A1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:cd13:8237:c4e0:a6a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 577001EC0CF0;
        Fri,  8 Nov 2019 14:03:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573218224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kum7mEcJwDy/+VDfRaoxsiXEBTdZ7IdRgQcyj7wtFnY=;
        b=GNHQ/WOL6d+xiM77RKDX3Qkhs8FEP0SrCcAL6ORVQNSitqSPEFK9mPQZxlvrOfFKWCb8OS
        67fkPBuMvs7lwJXiCMVRMARtwBSxmCa6Bm8YY7xhtbq6AwoDHxqYB7QYJVB/LPIgxKwH2R
        5reNerJ123Uk7F/tFDnC4E/f2ThePP0=
Date:   Fri, 8 Nov 2019 14:03:38 +0100
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
Subject: Re: [PATCH v5 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Message-ID: <20191108130338.GD4503@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
 <20191108100930.GA4503@zn.tnic>
 <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
 <20191108110703.GB4503@zn.tnic>
 <20191108125248.drmm7xakn7t7oyul@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108125248.drmm7xakn7t7oyul@tomti.i.net-space.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 08, 2019 at 01:52:48PM +0100, Daniel Kiper wrote:
> OK, got your comments. I will repost the patch series probably on Tuesday.
> I hope that it will land in 5.5 then.

I don't see why not if you base it ontop of tip:x86/boot and test it
properly before sending.

Out of curiosity, is there any particular reason this should be in 5.5?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
