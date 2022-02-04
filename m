Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97D4AA298
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 22:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiBDVt5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 16:49:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41484 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238679AbiBDVt4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Feb 2022 16:49:56 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F4B01EC051E;
        Fri,  4 Feb 2022 22:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644011391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fz8mGn5BOy2DieOoSZMrMULfKn9aZV+hq3dOFBMU7OA=;
        b=AYwZQgPXEHeM4bHXv25Qg14ii4tf7Laou46fjqMj+JVnEHviTt8tqubc2/KSU25dwtVnoY
        hzYyVOFebfDcF3xB+Ez7pVEFVzlGdmcDymFYvU53Zrf2t799+2qhidiVLCHDwnYFqIaz/J
        +iG1VLnhpmLRrrszSsmV3YFa0CdONcw=
Date:   Fri, 4 Feb 2022 22:49:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <Yf2feojR7ZxhtykG@zn.tnic>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
 <Yf1UO6jF91o9k4jB@zn.tnic>
 <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
 <Yf1p0ZjPf9Qaqwtg@zn.tnic>
 <c0007699-61ae-6df3-0675-2ac6ee58a59c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0007699-61ae-6df3-0675-2ac6ee58a59c@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 04, 2022 at 12:49:08PM -0600, Tom Lendacky wrote:
> Yep, and that should be safe. We would have to look at the generated code as
> there can't be any memory stores after the native_wbinvd() and before the
> native_halt().

I don't think anything else changes here besides the CPUID. Rest of the
asm is the same.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
