Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2214A9CF2
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 17:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiBDQ2v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiBDQ2v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Feb 2022 11:28:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21123C061714;
        Fri,  4 Feb 2022 08:28:51 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 414B31EC0622;
        Fri,  4 Feb 2022 17:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643992124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cQ4SzNKx3zUshpOS52iKeUUnDT1JTg4DzobvVWJLUl4=;
        b=hutPCjQ4kXRa9goBUgZS7qZcxK+wY1MNq8xOaINWMn8PfqNuBtg+Wq1aJ7lcmdo439in0W
        ncibPfA78mJvETAWDxvaU2zI0O5sBqj0kl0Yf8EETupo55b56ZyDghdqQpwPGvQIZymeka
        28y24wFfFi80jdzS2EbP2KOqdzJHuFk=
Date:   Fri, 4 Feb 2022 17:28:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <Yf1UO6jF91o9k4jB@zn.tnic>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 04, 2022 at 10:23:22AM -0600, Limonciello, Mario wrote:
> > > > As there is interest in seeing these capabilities from userspace, it

This needs to be explained in a lot more detail: why, what is going to
use it, how, etc.

We don't do user-visible APIs just because.

> As Tom agreed in previous post, Boris is mistaken here.  I just double
> checked on my side on a workstation that supports SME and comparing
> /proc/cpuinfo before and after SME is enabled via mem_encrypt=on.  I
> confirmed that nothing changed.

Then we should clear that "sme" flag if memory encryption is not
enabled. Like we do for all other flags.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
