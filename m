Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4084D4A4BBC
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 17:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380257AbiAaQVZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 11:21:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:13463 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380116AbiAaQVW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 11:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643646082; x=1675182082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r4B9aWmQfZmAaLbnAQfzd6iHm0LZz0ye6Jl1awPoYCg=;
  b=EoE5yYS+QdBksyJd8PQKO3R2+BegmG94DXYMrjmG2VYfiuu9IXrihrOZ
   SoZORi4QrRCVl+zQ84UCq4fqXqkG34qNA3VYEKEPzA2752odt3AVxVuEp
   CALNZFezIgCpfWL8P01Gaori3g7MyvrF1wfhP8Gp+bymD+loIyL1to79t
   WMeHbgtW1E+j03AmmlwnBf97uM4x8zd9vJkfX103xIsYOEW1lnhyG2nRG
   gikvS7u926HOd9AMOMUnQuRlIaDwF3d5mJ5BLWVZyuzBadYKoVN5pAifX
   dZGOU3D6Mc8NRgiOw1zRkhDu6jGTERtF5iGhTIrEeAbsfeyWbRyEYSoeK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="271966417"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="271966417"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 08:20:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="565181799"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 08:20:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nEZPA-00Gw7r-2E;
        Mon, 31 Jan 2022 18:19:48 +0200
Date:   Mon, 31 Jan 2022 18:19:47 +0200
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
Subject: Re: [PATCH v4 12/20] power: supply: bq25890: Support higher charging
 voltages through Pump Express+ protocol
Message-ID: <YfgMI2Qq4tMAiEn7@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-13-hdegoede@redhat.com>
 <YffouVvL9M4fch0I@smile.fi.intel.com>
 <bc465932-b2e5-7ff4-1b9a-cf2d76079251@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc465932-b2e5-7ff4-1b9a-cf2d76079251@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 31, 2022 at 04:18:23PM +0100, Hans de Goede wrote:
> On 1/31/22 14:48, Andy Shevchenko wrote:
> > On Sun, Jan 30, 2022 at 09:45:49PM +0100, Hans de Goede wrote:

...

> >> +	for (i = 0; i < PUMP_EXPRESS_MAX_TRIES; i++) {
> > 
> >> +		voltage = bq25890_get_vbus_voltage(bq);
> >> +		if (voltage < 0)
> >> +			goto error_print;
> > 
> > It also can be (at least in align with the rest error paths)
> > 
> > 		ret = bq25890_get_vbus_voltage(bq);
> > 		if (ret < 0)
> > 			goto error_print;
> > 		voltage = ret;
> > 
> > followed up (but not necessarily)...
> 
> The suggested pattern is useful when ret needs to be set on the error-exit
> path, but we are not doing that here. So I prefer to just keep this as is.

Are you talking about above proposal?

Still wouldn't be better to use it that if we want, for example, to print an
error code, it can be done easily? For the sake of consistency.

> >> +	}
> >> +
> >> +	bq25890_field_write(bq, F_PUMPX_EN, 0);
> >> +
> >> +	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
> >> +		 voltage);
> > 
> >> +	return;
> >> +error_print:
> > 
> > 	if (ret < 0)
> > 
> > But it's up to you.
> > 
> >> +	dev_err(bq->dev, "Failed to request hi-voltage charging\n");

-- 
With Best Regards,
Andy Shevchenko


