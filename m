Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30B7D4106
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 15:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfJKNXw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 09:23:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58854 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfJKNXv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Oct 2019 09:23:51 -0400
Received: from zn.tnic (p200300EC2F0C8D0081E4E393F9295E7C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8d00:81e4:e393:f929:5e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A7501EC0691;
        Fri, 11 Oct 2019 15:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570800226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5fLMyzBqU12Rh/Q+Kr0qKD7ip1UeUg/XeOmZ+J5DUfE=;
        b=TY+eyYtu5/pzkkpWLzgWnp1g9O6nXDcuUnGdLOIoV8X6uSagOOK4qZxQ5t1lBkqA9QrOWr
        Tvp4tjg9UHyjMYBQRe4rTOMgnMviKRRPVTob5WvDPzYbJOXSUMksSrJiP3kXkwrpnN103r
        /cjxcRAFEX2u6wy9uAefN1VOn1yk26s=
Date:   Fri, 11 Oct 2019 15:23:39 +0200
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
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
Message-ID: <20191011132339.GB8824@zn.tnic>
References: <20190919160521.13820-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919160521.13820-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 20, 2019 at 12:05:21AM +0800, Kairui Song wrote:
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
> usable memory region.
> 
> It's incorrect to use the lowest memory address. In later stage, kernel
> will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> but efi stub will end up relocating kernel below it.

So far, so good.

> Then before the kernel decompressing. Kernel will do another relocation
> to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> over write the blockage at the default load address, which efi stub tried
> to avoid, and lead to unexpected behavior. Beside, the memory region it
> writes to is not allocated from EFI firmware, which is also wrong.

This paragraph is an unreadable mess and should be rewritten in simple,
declarative sentences.

The patch itself looks ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
