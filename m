Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903BE4AB890
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiBGKQh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 05:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245646AbiBGKCV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 05:02:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80ABC043181;
        Mon,  7 Feb 2022 02:02:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B90E1EC0354;
        Mon,  7 Feb 2022 11:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644228134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6NmcNnj4Xwf+e2Un6wF4u6C4XPINvN7+qgEn8DmbNjU=;
        b=WVpaEJgzqF5fq7YPdG4XbSK6DMWR9AJm/JHYAgntaWj2aL7CaiHvp04Hh8HQhCF4tJh2Fn
        kA9JlCzFyKRnnZPRSyJ72oUaGsNFgh4WF9RjPlhlRNUeuuO0GaShR6GVoGRkIFCRXBKOGO
        lxTh4qa2rvorw3ow9d33JQZwyjDvjtU=
Date:   Mon, 7 Feb 2022 11:02:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <YgDuIeYvken1IArn@zn.tnic>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
 <Yf1UO6jF91o9k4jB@zn.tnic>
 <202202061924.6A2D278@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202061924.6A2D278@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Feb 06, 2022 at 07:39:46PM -0800, Kees Cook wrote:
> Oh, this seems weird to me, as I'd expect it to show up since the CPU is
> _capable_ of it, even if it's not in use. (Am I really using avx512vl,
> e.g.?)

We're trying to put feature flags in /proc/cpuinfo which mean that the
kernel supports the feature - not every CPUID bit out there. For that
there's tools/arch/x86/kcpuid/kcpuid.c

Otherwise /proc/cpuinfo becomes a dumping ground for feature flags and
there's no shortage of those.

> But as you point out later, it does work that way for a lot of things
> and boot params. If this is the way things are supposed to be done,
> it looks like we should wire up "nx" vs "noexec=off" boot param to do

See here:

https://lore.kernel.org/r/20220127115626.14179-1-bp@alien8.de

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
