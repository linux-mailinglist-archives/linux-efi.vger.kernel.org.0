Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2E4031A6
	for <lists+linux-efi@lfdr.de>; Wed,  8 Sep 2021 01:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhIGX6J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Sep 2021 19:58:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:12470 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhIGX6I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 7 Sep 2021 19:58:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220369543"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="220369543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 16:57:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="538242883"
Received: from liao1-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.169.181])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 16:56:58 -0700
Date:   Wed, 8 Sep 2021 07:56:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 2/5][RFC] efi: Introduce
 EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Message-ID: <20210907235655.GA39306@chenyu5-mobl1>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <14bb2fa2c49934c627aec07077b96720d46b5202.1631025237.git.yu.c.chen@intel.com>
 <CAMj1kXH-S5t0kYfTELU_kmhK_Nzmf1WAdZTEGfSFUsDmbG7MYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH-S5t0kYfTELU_kmhK_Nzmf1WAdZTEGfSFUsDmbG7MYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 07, 2021 at 06:06:28PM +0200, Ard Biesheuvel wrote:
> On Tue, 7 Sept 2021 at 17:12, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Platform Firmware Runtime Update image starts with UEFI headers, and the headers
> > are defined in UEFI specification, but some of them have not been defined in the
> > kernel yet.
> >
> > For example, the header layout of a capsule file looks like this:
> >
> > EFI_CAPSULE_HEADER
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> > EFI_FIRMWARE_IMAGE_AUTHENTICATION
> >
> > These structures would be used by the Platform Firmware Runtime Update
> > driver to parse the format of capsule file to verify if the corresponding
> > version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> > kernel, however the rest are not, thus introduce corresponding UEFI structures
> > accordingly.
> >
> > The reason why efi_manage_capsule_header_t and efi_manage_capsule_image_header_t
> > are packedi might be that:
> > According to the uefi spec,
> > [Figure 23-6 Firmware Management and Firmware Image Management headers]
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER is located at the lowest offset within
> > the body of the capsule. And this structure is designed to be unaligned to save
> > space, because in this way the adjacent drivers and binary payload elements could
> > start on byte boundary with no padding. And the
> > EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER is at the head of each payload, so
> > packing this structure also makes room for more data.
> >
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Who is going to use these definitions? I only see this patch, where is
> the rest of the series?
>
Sorry, Ard, and thanks for taking a look at this patch.

The user of this definitions is an ACPI device driver, named Platform Firmware
Runtime Update driver. This driver is designed to do firmware update via SMI.
This driver will do sanity check of the capsule file using these structures before
the file is passed to SMI. We put this check in kernel space rather than leaving
it to SMI because the latter is very costly.

The series patch is at:
https://patchwork.kernel.org/project/linux-acpi/list/?series=543211
and the user is mainly PATCH 3/5:
https://patchwork.kernel.org/project/linux-acpi/patch/9b2bd7d1e40633ce6f4845fb5c9e30a3faad5e7a.1631025237.git.yu.c.chen@intel.com/
in valid_version().

thanks,
Chenyu
