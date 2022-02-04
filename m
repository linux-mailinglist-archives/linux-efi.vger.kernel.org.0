Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E4A9E82
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 19:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356110AbiBDSBA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377297AbiBDSA7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Feb 2022 13:00:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F433C061714;
        Fri,  4 Feb 2022 10:00:59 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15E151EC063A;
        Fri,  4 Feb 2022 19:00:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643997654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0uGEKSITxQrWpa/yaW47k8Ta9BvFQRSsB43CPM3U2pE=;
        b=UUQLxIaoMf/nwCi4J8rxMOVbaUu6wbdcXn3eagaWD3Td7lbAn/YW7n2TUL1Zie3G6r13QM
        v3jTcAXxJfJefnQxi6sIWf5jmADHjUhQUZu5FdVbGqcDnLvwo+RLpOLKFiY5ddE/s7dcj3
        md+zSSsXkFUV0mIYljXLuJxw24gsCp8=
Date:   Fri, 4 Feb 2022 19:00:49 +0100
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
Message-ID: <Yf1p0ZjPf9Qaqwtg@zn.tnic>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <67d2711b-200c-0894-4ff7-beb3eb304399@amd.com>
 <CAKgze5YM2+BRjj2nvb+_dnuCg5WtWvQ6FQyNYJ1c8G6Orn=aQw@mail.gmail.com>
 <5c5ffe29-d3d3-2955-cf78-ad275110f012@amd.com>
 <ec9e29a4-0d2b-1423-d92e-6f025b56f8cc@amd.com>
 <Yf1UO6jF91o9k4jB@zn.tnic>
 <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ee34cad-8daf-6282-f2ed-cbc92a89d013@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 04, 2022 at 11:12:04AM -0600, Tom Lendacky wrote:
> https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/process.c#L761

For those who won't open a browser just to see what he means :), that's
this snippet:

void stop_this_cpu(void *dummy):
	/*
	 * Use wbinvd on processors that support SME. This provides support
	 * for performing a successful kexec when going from SME inactive
	 * to SME active (or vice-versa). The cache must be cleared so that
	 * if there are entries with the same physical address, both with and
	 * without the encryption bit, they don't race each other when flushed
	 * and potentially end up with the wrong entry being committed to
	 * memory.
	 */
	if (boot_cpu_has(X86_FEATURE_SME))
		native_wbinvd();


Well, we do clear our *representation* of CPUID flags for other features
- see output of

$ git grep -E "(setup_)?clear_cpu_cap"

for examples. We do that for SME even: early_detect_mem_encrypt().

Which means, since this needs to be "processors that support SME", this
line should change to:

	/* ... test the CPUID bit directly because the machine might've cleared
	 * X86_FEATURE_SME due to cmdline options.
	 */
	if (cpuid_eax(0x8000001f) & BIT(0))
		native_wbinvd();

I'd say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
