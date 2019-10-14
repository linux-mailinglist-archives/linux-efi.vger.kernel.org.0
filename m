Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF37D5FD4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfJNKO3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 06:14:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47968 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730860AbfJNKO3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Oct 2019 06:14:29 -0400
Received: from zn.tnic (p200300EC2F0658000D81860DC41819CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:d81:860d:c418:19cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 178E01EC0C81;
        Mon, 14 Oct 2019 12:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571048068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wkz9C43pehfzIi2G8U/rqKdkFbNpdbpgepEvHllTaWY=;
        b=M8CTQTPoMBdW++4DWBzrcGsHBNI9VODSHqJEsTxJJ3z8S8NsL1i1KINDFF752dXr4X08ZD
        8v9PBq698wKG6xqwWv4kG6H8X8eKrlNsCmRbPAGcMhYwPI0+z82Rk/q6wTrGhi2gfdQcV6
        4YxZ8BgCsE/zmOTHaXjMbj5lRQBSYWY=
Date:   Mon, 14 Oct 2019 12:14:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20191014101419.GA4715@zn.tnic>
References: <20191012034421.25027-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191012034421.25027-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Oct 12, 2019 at 11:44:21AM +0800, Kairui Song wrote:
> Currently, kernel fails to boot on some HyperV VMs when using EFI.
> And it's a potential issue on all platforms.
> 
> It's caused a broken kernel relocation on EFI systems, when below three
> conditions are met:
> 
> 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
>    by the loader.
> 2. There isn't enough room to contain the kernel, starting from the
>    default load address (eg. something else occupied part the region).
> 3. In the memmap provided by EFI firmware, there is a memory region
>    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
>    kernel.
> 
> Efi stub will perform a kernel relocation when condition 1 is met. But
> due to condition 2, efi stub can't relocate kernel to the preferred
> address, so it fallback to query and alloc from EFI firmware for lowest

Your spelling of "EFI" is like a random number generator in this
paragraph: "Efi", "efi" and "EFI". Can you please be more careful when
writing your commit messages? They're not some random text you hurriedly
jot down before sending the patch but a most important description of
why a change is being done.

And if you don't see their importance now, just try doing some git
archeology, trying to understand why a change has been done in the past
and then encounter a commit message two-liner which doesn't say sh*t.
Then you'll start appreciating properly written commit messages.

> usable memory region.
> 
> It's incorrect to use the lowest memory address. In later stage, kernel
> will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> but efi stub will end up relocating kernel below it.

Why don't you simply explain what
choose_random_location()->find_random_virt_addr() does? That's the
problem you're solving, right? KASLR using LOAD_PHYSICAL_ADDR as the
minimum...

> The later kernel decompressing code will forcefully correct the wrong
> kernel load location,

... or do you mean by that the dance in
arch/x86/boot/compressed/head_64.S where we move the kernel temporarily
to LOAD_PHYSICAL_ADDR for the decompression?

You can simply say that here...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
