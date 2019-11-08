Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADBF455C
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 12:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfKHLHN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 06:07:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45042 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHLHN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Nov 2019 06:07:13 -0500
Received: from zn.tnic (p200300EC2F0D3700695E5CE6DC2DF0A9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:695e:5ce6:dc2d:f0a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED2F51EC0D03;
        Fri,  8 Nov 2019 12:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573211228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SxhUbKrHkDrtCwuXKZ6zF1k4QlFvkBU3G12snVS+e94=;
        b=B/c9f5O4hdwqYRhrNekEEddvja4Fqj0Hm8uQSTKRbIpJar7ekZZOeinBa79PLrOvbVI7cP
        MY09b8HmGkVTrNtn7lZORotRw9sHr1M88aPVqTX85L56QNYuXFhI0a5trOwaQ24i51dkZH
        hrJE5Luj8IFtRLDHFKq/8MYfDVQU6rk=
Date:   Fri, 8 Nov 2019 12:07:03 +0100
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
Message-ID: <20191108110703.GB4503@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
 <20191108100930.GA4503@zn.tnic>
 <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 08, 2019 at 11:47:02AM +0100, Daniel Kiper wrote:
> Yeah, you are right. Would you like me to repost whole patch series or
> could you fix it before committing?

Lemme finish looking at patch 3 first.

If you have to resend, please remove "This patch" and "We" in your text.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
