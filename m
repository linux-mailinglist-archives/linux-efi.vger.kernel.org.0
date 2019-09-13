Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9998DB22D2
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2019 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbfIMPCl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Sep 2019 11:02:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37052 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390376AbfIMPCl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Sep 2019 11:02:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id 11so2906508oix.4
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2019 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL1GjXU4OxVtgje4G6mCeYw5JgQRyVmMHSk6LS6L6h0=;
        b=XcrIfAGLgnCngGnqO1DJcdE95s67blXTpvCmuoC4POiBmx1B9clK5ZNugaQYZJsHUK
         LRRlS7On0v8cTv9pXBKg5amy+FZZUlwUL7z05OwVEHx82wbE3R4S2AW1N/pUtqyq+coe
         IxqcEgPQZzwzDUjxbbqdywUSKT8qPsXxZunO4CUbU0DklVvrpC3nBd3ULVxpo/T9HIUV
         CxZ18AffXR0nlOKPGBkl6EiS3GhbOs46/HGXTUldnrXoG2kQLecamfhdRyIzxHQX4Ta4
         86UKX/JIqHw9xYUfiv4/nwCOTRYSHTLVvwAOG3sBbWBbBCNaCkJREJNSrKCEVbUnh+Ms
         xEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL1GjXU4OxVtgje4G6mCeYw5JgQRyVmMHSk6LS6L6h0=;
        b=G68TAIBx3KxiqV8lpzn0KAZ9i4ASpvWrfeHwtBw7zQgMHXZuAS6I5daw4FwlEPvcW8
         goNeCPRi19H3dCCS3ZZ6FgpRcZWtrssd7y2Mqgbsz4aK/MwhDo6g1ryctOs9dXUK2Qb6
         oPpo/su2A+zGgqXm5/RGBiUiiw/qYgbmKascJwQVudO/NycynMgWUT+x7be8OnsAa3zF
         T9g6tEq/CbhuhElcMt2MtwMkp89fHA9QhKFLUFTo3uvUM3DMedEi4M08OlyksmGQQEgF
         QBGT+QmfF9UiuIoO1e3SXBJrPrI3aiIpO12wXHh8iaPPm4n4ffpb9La9ifkSv0EJZMBp
         xotQ==
X-Gm-Message-State: APjAAAXMed9c2qk+6gjxlcqobqKvdVWfjgY2+HVALai22jAPq9/Lerv6
        +pfR6QAFXyXTzle3ruBJPy9DluUPFjcgz943psDU1A==
X-Google-Smtp-Source: APXvYqyeEJXWj7rpxrv1qz+5i2zLZaF/SLL5wmnwCw6eD+cUG7FsoCaEJNlzjXu8gUdNFX/hYHgq60QKgMlpEmp2U7Y=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr2670978oia.70.1568386960199;
 Fri, 13 Sep 2019 08:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712996407.1616117.11409311856083390862.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu-UK75nCreZb=v7PQne4Ay25B7oRAeRg4AB1XopYXt3Cg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-UK75nCreZb=v7PQne4Ay25B7oRAeRg4AB1XopYXt3Cg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 08:02:26 -0700
Message-ID: <CAPcyv4jv8OacA-P+DFj_d9gq3P-7b9xcr4=m3kx7nTvyko6i2g@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] x86, efi: Add efi_fake_mem support for EFI_MEMORY_SP
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 13, 2019 at 6:02 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Aug 2019 at 03:07, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Given that EFI_MEMORY_SP is platform BIOS policy descision for marking
>
> decision

Fixed.

>
> > memory ranges as "reserved for a specific purpose" there will inevitably
> > be scenarios where the BIOS omits the attribute in situations where it
> > is desired. Unlike other attributes if the OS wants to reserve this
> > memory from the kernel the reservation needs to happen early in init. So
> > early, in fact, that it needs to happen before e820__memblock_setup()
> > which is a pre-requisite for efi_fake_memmap() that wants to allocate
> > memory for the updated table.
> >
> > Introduce an x86 specific efi_fake_memmap_early() that can search for
> > attempts to set EFI_MEMORY_SP via efi_fake_mem and update the e820 table
> > accordingly.
> >
>
> Is this early enough? The EFI stub runs before this, and allocates
> memory as well.

Unless I'm missing something the stub only allocates where the kernel
will land. That should be handled by the new mem_avoid_memmap()
extensions to consider "efi_fake_mem" in its exclusions.
