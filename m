Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1190DF2E63
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbfKGMrJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 07:47:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41256 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKGMrJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Nov 2019 07:47:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id e9so1810165oif.8;
        Thu, 07 Nov 2019 04:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJ+XM7e35yl7YewLYP0iJjwmpEainWYQoTZVXoXrUd0=;
        b=h6XJq3+/adLqxWvXOz575ug243YpCT6DDWxT7wydq7O1a96cnDR4D3EuHnXY2MF3vR
         xYNj0SR5rm/YIIJrWNcbcu6vB/rVafYcrkOm6Ua+AmSNkhd9n2bDySvGFA4wRx1iqjrO
         nMOVUD4M48onKaIOcRIDBdPuCebi3VpVuHNIWH0tMAZjBNm1+umeEu3LfVYYnZVglijh
         ebi2z5xH0jItrDcJ4/ZSHJ5o9nPEmuM9bfobiMioHl+Ww6oy/cTQI3+h/vkDCv2WF24g
         XEkg1lCml/1bEJ8XoBDqfL4NHmfzqcjjopUFtTqXvKNj9mvHAoOP8kyJa5SPSpjoL8S8
         wz3Q==
X-Gm-Message-State: APjAAAVoBl61W839xj2mjN7THC/Xv24N31OfJajfO0UC6Ald+wU3koXs
        spXE9MS4T4Gdv2q6xFxgD0dMuJePjpF9Ji3B1Jg=
X-Google-Smtp-Source: APXvYqzlr7almGaTB4dbuD39z3gB6B3WnVS7o80LQ8cjmDZcFRCmiHdFTDSP/fLzfS2WS0wlNj1lXp3k4W0jsLB7Yc8=
X-Received: by 2002:aca:1101:: with SMTP id 1mr3414464oir.103.1573130827691;
 Thu, 07 Nov 2019 04:47:07 -0800 (PST)
MIME-Version: 1.0
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Nov 2019 13:46:54 +0100
Message-ID: <CAJZ5v0hDaxcPBwwx2FaxKKJGNOvY_+JuvF7CJ0tbX1TjEisvUQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] EFI Specific Purpose Memory Support
To:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <kbusch@kernel.org>, Len Brown <lenb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Lutomirski <luto@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 7, 2019 at 2:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v7:
> - This is mostly a resend to get it refreshed in Ingo's inbox for v5.5
>   consideration. It picks up a Reviewed-by on patch4 from Ard, has a
>   minor cosmetic rebase on v5.4-rc6 with no other changes, it merges
>   cleanly with tip/master, and is still passing the test case described in
>   the final patch, but development is otherwise idle over the past 3
>   weeks.
>
> [1]: https://lkml.kernel.org/r/157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> ---
> Merge notes:
>
> Hi Ingo,
>
> This is ready to go as far as I'm concerned. Please consider merging, or
> acking for Rafael to take, or of course naking if something looks off.
> Rafael had threatened to start taking the standalone ACPI bits through
> his tree, but I have yet to any movement on that in his 'linux-next' or
> 'bleeding-edge' tree.

Indeed.

I have waited for comments on x86 bits from Thomas, but since they are
not coming, I have just decided to take patch [1/12] from this series,
which should be totally non-controversial,  as keeping it out of the
tree has become increasingly painful (material depending on it has
been piling up already for some time).

If need be, I can expose that commit in an immutable branch, so please
let me know if that's necessary.

BTW, Dan, I think that it was a mistake to make the rest of your
series depend on that patch.  The new directory could have been
created at any convenient time later.

Cheers,
Rafael
