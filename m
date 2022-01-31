Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771B84A48DC
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 14:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiAaN5R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 08:57:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:14208 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379236AbiAaN5Q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643637436; x=1675173436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKPciRVFSEV+M+vvJu9GWn/BBoXrj3T+pfeFI1+Xq5M=;
  b=ZSYWLNdvSUXEEWgzZI1B3seBcpVVADG5w1pDZ1dkZR9ORDSGEOuasEaX
   ImLbWrHz02ZVBBrkapBSfC2NbkuZqA1bWn4yNte/XqUb+rOx7UfWS57YI
   sBnMQd32woKoVyddBYNWPiDBdQbqvfuz7IiFQ1U+KONDZM+wdLX/12Fgf
   8JJ1a1lOU1HLEI+868kkFnLa9jSQPv3jmkTC16mbgaHBEbO4tEw1MX59i
   tNBgymmR2Pzw5VOZ/4/sRJelnshamrpLyWjlXDHffF/d1aZFlO4+y9akW
   mvENqCwgGgoUpfBcmAcABP2OSWXfOd5+xxtOiWcYb5M5XUeZP6hwwEgKv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="246295736"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="246295736"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:57:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="630025734"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:57:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nEXA7-00GtBn-Al;
        Mon, 31 Jan 2022 15:56:07 +0200
Date:   Mon, 31 Jan 2022 15:56:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
Message-ID: <Yffqd4c7WrxTrHHL@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-19-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130204557.15662-19-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jan 30, 2022 at 09:45:55PM +0100, Hans de Goede wrote:
> This is a preparation patch for adding support for registering
> a power_supply class device.
> 
> Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
> will make the following switch-case return EXTCON_CHG_USB_SDP
> just as before, so there is no functional change.

...

> -		return EXTCON_CHG_USB_SDP; /* Save fallback */

> +		/* Save fallback */

I see it's in the previous code, but what does it mean?
I would read it as "Safe fallback", bit I have no clue.

-- 
With Best Regards,
Andy Shevchenko


