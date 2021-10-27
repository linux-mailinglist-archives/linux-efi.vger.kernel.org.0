Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1830743C740
	for <lists+linux-efi@lfdr.de>; Wed, 27 Oct 2021 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhJ0KDm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Oct 2021 06:03:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:16201 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235237AbhJ0KDd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 27 Oct 2021 06:03:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230073802"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230073802"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:01:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="529573274"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:01:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mffjf-001Qor-Po;
        Wed, 27 Oct 2021 13:00:43 +0300
Date:   Wed, 27 Oct 2021 13:00:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
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
Message-ID: <YXkjS/yhAYAIAWRu@smile.fi.intel.com>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <4898b5784e79b89bb25ce91384427b5ca3547b8f.1635317102.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4898b5784e79b89bb25ce91384427b5ca3547b8f.1635317102.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 27, 2021 at 03:07:24PM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update image starts with UEFI headers, and the
> headers are defined in UEFI specification, but some of them have not been
> defined in the kernel yet.
> 
> For example, the header layout of a capsule file looks like this:
> 
> EFI_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER
> EFI_FIRMWARE_IMAGE_AUTHENTICATION
> 
> These structures would be used by the Platform Firmware Runtime Update
> driver to parse the format of capsule file to verify if the corresponding
> version number is valid. The EFI_CAPSULE_HEADER has been defined in the
> kernel, however the rest are not, thus introduce corresponding UEFI
> structures accordingly. Besides, EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER
> and EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER are required to be packed
> in the uefi specification. And Ard has pointed out that, the __packed
> attribute does indicate to the compiler that the entire thing can appear
> misaligned in memory. So if one follows the other in the capsule header,
> the __packed attribute may be appropriate to ensure that the second one
> is not accessed using misaligned loads and stores.

...

> +/* EFI_FIRMWARE_MANAGEMENT_CAPSULE_IMAGE_HEADER */
> +struct efi_manage_capsule_image_header {
> +	u32	ver;

> +	guid_t	image_type_id;

Shouldn't it be efi_guid_t ?

> +	u8	image_index;
> +	u8	reserved_bytes[3];
> +	u32	image_size;
> +	u32	vendor_code_size;
> +	/* ver = 2. */
> +	u64	hw_ins;
> +	/* ver = v3. */
> +	u64	capsule_support;
> +} __packed;

...

> +/* WIN_CERTIFICATE_UEFI_GUID */
> +struct win_cert_uefi_guid {
> +	struct win_cert	hdr;

> +	guid_t		cert_type;

Ditto.

> +	u8		cert_data[];
> +};

-- 
With Best Regards,
Andy Shevchenko


