Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 929FA39670
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfFGUHl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 16:07:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35988 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUHl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 16:07:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so3004362otr.3
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCiKEWFDcZP7j811fk8M8DkkVpOdsBHHGSCQGbcAqsM=;
        b=cX5B/ybN+9E76C8vJtaIyiZ12P5fTDIXvvmXG0mOyMhb/Md40OxzeycYBwXFnWA0IJ
         eHlbUUA10FvcMoJyZ8CTLDV9XHwhiUCX3OgHH81/Z7uy38VkIfuK665/O+t5F/pa0u8f
         QgcsAPD0wM+v2RvkhElbUU6b+LR29R1dqNkyno4eRZhIDtlQF/cFlGPX6xi1pTmSenIR
         RWyEjxRs88GDKPlo3xDEyPXchy6YBS7fEh0gh5qhe5t/i15+k6BZqVFzebLLrAceNQdc
         KYQQxtBe2uLzxpejgnrt3bWzxDBrq8tYDPjhi92QfxXzxDjAwak55hrZX6LaF12G9aHE
         srjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCiKEWFDcZP7j811fk8M8DkkVpOdsBHHGSCQGbcAqsM=;
        b=E4lotkWy3UfjksYI54tf7PtfZDimJpp4yeqwStHFTwEL6REHHwq+dLvQ3zX0wKMJi7
         ndAt+dWeRRFM/mLTVCf5R2mQgbz6b4gJYCrcS1w9rKmbtzQW0h9RA2TKjIFOoyvP9dsX
         q8CANsd74EEx/WWQ1rZjp3GnQQqam9P+MptKGOoBspSNwB7m0066MN+YgNbnxiSLlp7g
         w+v0HbINpTbK2B+XiyMDxKRxgSZOwpO3xP+V4eVjEmbJKUujihbYkgPayHH8Oof/miZ9
         uychydBuX0CuwCrYcJVnFJe3ZYIGxiJHmCr9sEZ6I/GQLyp3irNILIqJrAmgDuYUHq7o
         1feA==
X-Gm-Message-State: APjAAAWoQtpfHrMs3cTj2yBGT6yIgevH7BHLNCGxnfflJLvgREx95ahb
        MjhMHjlyMr0kaHBKTkIZkumMEwOizB18llgn7tjmbw==
X-Google-Smtp-Source: APXvYqz2rbY6yUyrAbyzCD+KOoV/chSruHULmHuQow0UVyDGQb5c3BZJ2KdwaL++9IlM9uuK2zqoXUgttHphpe1xf4A=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr15801599otn.71.1559938060915;
 Fri, 07 Jun 2019 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567538.3036719.16306480832003017141.stgit@dwillia2-desk3.amr.corp.intel.com>
 <e2fd563a-1be4-b4dc-09fa-886f0319be5b@intel.com>
In-Reply-To: <e2fd563a-1be4-b4dc-09fa-886f0319be5b@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 13:07:30 -0700
Message-ID: <CAPcyv4jhoxDXUwv4vgDYo=aLAAOxZ-Yq0qcgi5kHF_ybGUd-gg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] device-dax: Add a driver for "hmem" devices
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 7, 2019 at 12:54 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 12:27 PM, Dan Williams wrote:
> > This consumes "hmem" devices the producer of "hmem" devices is saved for
> > a follow-on patch so that it can reference the new CONFIG_DEV_DAX_HMEM
> > symbol to gate performing the enumeration work.
>
> Do these literally show up as /dev/hmemX?

No, everything shows as daxX.Y character devices across hmem and pmem
producers. For example:

# daxctl list -RDu
[
  {
    "path":"/platform/hmem.1",
    "id":1,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax1.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  },
  {
    "path":"/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1",
    "id":2,
    "size":"125.01 GiB (134.23 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax2.0",
        "size":"125.01 GiB (134.23 GB)"
      }
    ]
  },
  {
    "path":"/platform/hmem.0",
    "id":0,
    "size":"4.00 GiB (4.29 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax0.0",
        "size":"4.00 GiB (4.29 GB)"
      }
    ]
  }
]
