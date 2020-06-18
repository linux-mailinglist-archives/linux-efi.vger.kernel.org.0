Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9EC1FF115
	for <lists+linux-efi@lfdr.de>; Thu, 18 Jun 2020 13:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFRL6n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Jun 2020 07:58:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:28577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgFRL6n (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Jun 2020 07:58:43 -0400
IronPort-SDR: i4y/Xs1zJdZP+AcTRpWFh5YT21eUBeGgqeZ76vKSfBaT+WIkn5nmDmFxeOZbrqFfqLWlqxTWrp
 EZMRhh582XDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="160639092"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="160639092"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 04:58:42 -0700
IronPort-SDR: UibvuRw/ZqmkSiHgNUM8TeuCsy55NldQuq87CSsfs6d0/u/ZH69YfkwvV8aNahOE35lRvOoCBI
 Ho5eU1cMk51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="317806569"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jun 2020 04:58:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jltBs-00EG4v-2d; Thu, 18 Jun 2020 14:58:44 +0300
Date:   Thu, 18 Jun 2020 14:58:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] efi/dev-path-parser: Switch to
 acpi_dev_get_first_match_dev()
Message-ID: <20200618115844.GS2428291@smile.fi.intel.com>
References: <20200529130822.52370-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529130822.52370-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, May 29, 2020 at 04:08:22PM +0300, Andy Shevchenko wrote:
> The acpi_dev_get_first_match_dev() helper will find and return
> an ACPI device pointer of the first registered device in the system
> by its HID and UID (if present). Use it instead of open coded variant.

Lukas, any comment on this?

> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added Lukas to Cc (Ard), updated condition to handle UID=0 case
>  drivers/firmware/efi/dev-path-parser.c | 43 +++++++++-----------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index 5c9625e552f4..d3e5123ab618 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -12,51 +12,36 @@
>  #include <linux/efi.h>
>  #include <linux/pci.h>
>  
> -struct acpi_hid_uid {
> -	struct acpi_device_id hid[2];
> -	char uid[11]; /* UINT_MAX + null byte */
> -};
> -
> -static int __init match_acpi_dev(struct device *dev, const void *data)
> -{
> -	struct acpi_hid_uid hid_uid = *(const struct acpi_hid_uid *)data;
> -	struct acpi_device *adev = to_acpi_device(dev);
> -
> -	if (acpi_match_device_ids(adev, hid_uid.hid))
> -		return 0;
> -
> -	if (adev->pnp.unique_id)
> -		return !strcmp(adev->pnp.unique_id, hid_uid.uid);
> -	else
> -		return !strcmp("0", hid_uid.uid);
> -}
> -
>  static long __init parse_acpi_path(const struct efi_dev_path *node,
>  				   struct device *parent, struct device **child)
>  {
> -	struct acpi_hid_uid hid_uid = {};
> +	char hid[3 + 4 + 1];	/* 3 characters + 4 hex digits + null byte */
> +	char uid[10 + 1];	/* UINT_MAX + null byte */
> +	struct acpi_device *adev;
>  	struct device *phys_dev;
>  
>  	if (node->header.length != 12)
>  		return -EINVAL;
>  
> -	sprintf(hid_uid.hid[0].id, "%c%c%c%04X",
> +	sprintf(hid, "%c%c%c%04X",
>  		'A' + ((node->acpi.hid >> 10) & 0x1f) - 1,
>  		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
>  		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
>  			node->acpi.hid >> 16);
> -	sprintf(hid_uid.uid, "%u", node->acpi.uid);
> +	sprintf(uid, "%u", node->acpi.uid);
>  
> -	*child = bus_find_device(&acpi_bus_type, NULL, &hid_uid,
> -				 match_acpi_dev);
> -	if (!*child)
> +	adev = acpi_dev_get_first_match_dev(hid, uid, -1);
> +	if (!adev && !node->acpi.uid)
> +		adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
> +	if (!adev)
>  		return -ENODEV;
>  
> -	phys_dev = acpi_get_first_physical_node(to_acpi_device(*child));
> +	phys_dev = acpi_get_first_physical_node(adev);
>  	if (phys_dev) {
> -		get_device(phys_dev);
> -		put_device(*child);
> -		*child = phys_dev;
> +		*child = get_device(phys_dev);
> +		acpi_dev_put(adev);
> +	} else {
> +		*child = &adev->dev;
>  	}
>  
>  	return 0;
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


