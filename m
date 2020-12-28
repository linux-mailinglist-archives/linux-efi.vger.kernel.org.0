Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967C22E40A0
	for <lists+linux-efi@lfdr.de>; Mon, 28 Dec 2020 15:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbgL1Oyo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Dec 2020 09:54:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:17025 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbgL1Oym (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 28 Dec 2020 09:54:42 -0500
IronPort-SDR: 917c1yLinU9aoDJFlOGI5snbM+xoQw6VNa8ycXeGXxTKr7CF9M+Gkjl4J1Bpon64vmv6r143TM
 08hcSYMrGD4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="164102365"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="164102365"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 06:52:56 -0800
IronPort-SDR: +xk5Sb2MyAPO3xLz0jQ7HxZyG+FN1YxSsRLKKIITrGFFELCC0kEInuGqEU6U+r9/EWta8U7Q39
 E3FdZ8AYytrQ==
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="347011969"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 06:52:54 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kttuH-000EaO-0q; Mon, 28 Dec 2020 16:53:57 +0200
Date:   Mon, 28 Dec 2020 16:53:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/apple-properties: Reinstate support for boolean
 properties
Message-ID: <20201228145357.GY4077@smile.fi.intel.com>
References: <a4006978064f91dd42ec0554a3d2164a28ac61de.1609079197.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4006978064f91dd42ec0554a3d2164a28ac61de.1609079197.git.lukas@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Dec 27, 2020 at 03:30:32PM +0100, Lukas Wunner wrote:
> Since commit 4466bf82821b ("efi/apple-properties: use
> PROPERTY_ENTRY_U8_ARRAY_LEN"), my MacBook Pro issues a -ENODATA error
> when trying to assign EFI properties to the discrete GPU:
> 
> pci 0000:01:00.0: assigning 56 device properties
> pci 0000:01:00.0: error -61 assigning properties
> 
> That's because some of the properties have no value.  They're booleans
> whose presence can be checked by drivers, e.g. "use-backlight-blanking".
> 
> Commit 6e98503dba64 ("efi/apple-properties: Remove redundant attribute
> initialization from unmarshal_key_value_pairs()") used a trick to store
> such booleans as u8 arrays (which is the data type used for all other
> EFI properties on Macs):  It cleared the property_entry's "is_array"
> flag, thereby denoting that the value is stored inline in the
> property_entry.
> 
> Commit 4466bf82821b erroneously removed that trick.  It was probably a
> little fragile to begin with.

Thanks for spotting this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
One nitpick below, though.

> Reinstate support for boolean properties by explicitly using the
> PROPERTY_ENTRY_BOOL() initializer for properties with zero-length value.
> 
> Fixes: 4466bf82821b ("efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.5+
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/efi/apple-properties.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> index 34f53d898acb..0f37877db641 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -3,8 +3,9 @@
>   * apple-properties.c - EFI device properties on Macs
>   * Copyright (C) 2016 Lukas Wunner <lukas@wunner.de>
>   *
> - * Note, all properties are considered as u8 arrays.
> - * To get a value of any of them the caller must use device_property_read_u8_array().
> + * Properties are stored either as:
> + * booleans which can be queried with device_property_present() or
> + * u8 arrays which can be retrieved with device_property_read_u8_array().
>   */
>  
>  #define pr_fmt(fmt) "apple-properties: " fmt
> @@ -88,8 +89,11 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
>  
>  		entry_data = ptr + key_len + sizeof(val_len);
>  		entry_len = val_len - sizeof(val_len);
> -		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
> -						       entry_len);
> +		if (!entry_len)
> +			entry[i] = PROPERTY_ENTRY_BOOL(key);
> +		else
> +			entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
> +							       entry_len);

Can we use positive conditional, i.e.

		if (entry_len)
			entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
							       entry_len);
		else
			entry[i] = PROPERTY_ENTRY_BOOL(key);
?

>  		if (dump_properties) {
>  			dev_info(dev, "property: %s\n", key);
>  			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
> -- 
> 2.29.2
> 

-- 
With Best Regards,
Andy Shevchenko


