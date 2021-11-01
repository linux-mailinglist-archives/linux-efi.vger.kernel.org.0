Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712AB441A5B
	for <lists+linux-efi@lfdr.de>; Mon,  1 Nov 2021 12:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKALE0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 07:04:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:52788 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhKALEZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 1 Nov 2021 07:04:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291831495"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="291831495"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 04:01:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="499991146"
Received: from dekunli-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 04:01:48 -0700
Date:   Mon, 1 Nov 2021 19:01:44 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v7 1/4] efi: Introduce
 EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and corresponding structures
Message-ID: <20211101110144.GA28054@chenyu5-mobl1>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <4898b5784e79b89bb25ce91384427b5ca3547b8f.1635317102.git.yu.c.chen@intel.com>
 <YXkjS/yhAYAIAWRu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXkjS/yhAYAIAWRu@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 27, 2021 at 01:00:43PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 27, 2021 at 03:07:24PM +0800, Chen Yu wrote:
> > Platform Firmware Runtime Update image starts with UEFI headers, and the
> > headers are defined in UEFI specification, but some of them have not been
> > defined in the kernel yet.
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
> > kernel, however the rest are not, thus introduce corresponding UEFI
> > structures accordingly. Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> > and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
> > in the uefi specification. And Ard has pointed out that, the __packed
> > attribute does indicate to the compiler that the entire thing can appear
> > misaligned in memory. So if one follows the other in the capsule header,
> > the __packed attribute may be appropriate to ensure that the second one
> > is not accessed using misaligned loads and stores.
> 
> ...
> 
> > +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> > +struct efi_manage_capsule_image_header {
> > +	u32	ver;
> 
> > +	guid_t	image_type_id;
> 
> Shouldn't it be efi_guid_t ?
>
I see, will change it, also in other patches.

thanks,
Chenyu 
