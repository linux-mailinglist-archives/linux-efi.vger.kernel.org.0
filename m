Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB144A48CF
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379186AbiAaNzW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 08:55:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:64460 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347928AbiAaNzT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643637319; x=1675173319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMPytbrkqxecRxMjZoXl+pVJH16/C9F19T8BjSjbHlY=;
  b=K3lQ8clKgJVhfp0ofBTwMQl9rQiZg0dIXdNkXNY2rYULJ6ci2kR6MR5N
   sFIR+XoQlDIM/qI7/P6rS3oo/0mUrpGdU/EjXw6OyGYkli31xHgEaUls6
   nTg+S866GA580uNjSlJJdOpYRkobLh7MZkr50aUuQjXYCEUjy46rv0Ayw
   li+ZIQMsfzEA/MITghyGfxo1FZIskfZBmhjhEGyisBwTzOH/ODmzjbF0W
   oXSQSOhkWN4mPfD/tHDjcGVQuMfsIbTU1Ym58HvclPwOhpoZxN5GNyjBG
   /ToA3lTcpSq6mkBGFhlAtBWRT3W2abAwFg2mLXPhIcVkRfywrmOwkRhVk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="271931483"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="271931483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:55:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="698007721"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:55:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nEX8E-00GtA0-3a;
        Mon, 31 Jan 2022 15:54:10 +0200
Date:   Mon, 31 Jan 2022 15:54:09 +0200
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
Subject: Re: [PATCH v4 17/20] extcon: intel-cht-wc: Support devs with Micro-B
 / USB-2 only Type-C connectors
Message-ID: <YffqAchYMoSVqMTz@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-18-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130204557.15662-18-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jan 30, 2022 at 09:45:54PM +0100, Hans de Goede wrote:
> So far the extcon-intel-cht-wc code has only been tested on devices with
> a Type-C connector with USB-PD, USB3 (superspeed) and DP-altmode support
> through a FUSB302 Type-C controller.
> 
> Some devices with the intel-cht-wc PMIC however come with an USB-micro-B
> connector, or an USB-2 only Type-C connector without USB-PD.
> 
> Which device-model we are running on can be identified with the new
> cht_wc_model intel_soc_pmic field. On models without a Type-C controller
> the extcon code must control the Vbus 5V boost converter and the USB role
> switch depending on the detected cable-type.

...

> +	if (ext->vbus_boost && ext->vbus_boost_enabled != enable) {
> +		if (enable)
> +			ret = regulator_enable(ext->vbus_boost);
> +		else
> +			ret = regulator_disable(ext->vbus_boost);

> +		if (ret == 0)
> +			ext->vbus_boost_enabled = enable;
> +		else
> +			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);

Can we go with

		if (ret)
			dev_err(ext->dev, "Error updating Vbus boost regulator: %d\n", ret);
		else
			ext->vbus_boost_enabled = enable;

?

> +	}


-- 
With Best Regards,
Andy Shevchenko


