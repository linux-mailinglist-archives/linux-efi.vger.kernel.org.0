Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDC4A48A3
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 14:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379148AbiAaNtx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 08:49:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:62889 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379143AbiAaNtv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643636991; x=1675172991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCvnVIfnnsg4Om7JyESlCrRRmCTTcyTfYzN4cwo7ytw=;
  b=DeFdaTz/knNxNi+CbMLscPuDPIF/G1uOhVFBngH1Z8QYIAC7vel14gl7
   e3EJOsU0cElivTIfHeTWQ00BS2yqh3uI34HmabpH5q4x7ca/OW3CDFmx9
   zlAEFaspslHC1lfmhFbt4c8pOjt/PjM8izGkNLe1TTz7TB479pQcceak5
   o8DCbhh2fwsT/UADRfgFB+cATjsY5MjEfFlOgwdvtKMF8SAlvI4kdoSTb
   Nc8+IChA9KXVfSNFx5Ql+nYdxDVGAJtyWarHVraFZZ9NpPm8muNI1mZOg
   E3xjJ6XCwLjqtXW1IfTccqM3WlMLAtWxfli5YW5nh72884h3w8Irnfx4F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247677792"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247677792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:49:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="481753169"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:49:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nEX2v-00Gt4F-Iy;
        Mon, 31 Jan 2022 15:48:41 +0200
Date:   Mon, 31 Jan 2022 15:48:41 +0200
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
Message-ID: <YffouVvL9M4fch0I@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-13-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130204557.15662-13-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jan 30, 2022 at 09:45:49PM +0100, Hans de Goede wrote:
> From: Yauhen Kharuzhy <jekhor@gmail.com>
> 
> Add a "linux,pump-express-vbus-max" property which indicates if the Pump
> Express+ protocol should be used to increase the charging protocol.
> 
> If this new property is set and a DCP charger is detected then request
> a higher charging voltage through the Pump Express+ protocol.
> 
> So far this new property is only used on x86/ACPI (non devicetree) devs,
> IOW it is not used in actual devicetree files. The devicetree-bindings
> maintainers have requested properties like these to not be added to the
> devicetree-bindings, so the new property is deliberately not added
> to the existing devicetree-bindings.
> 
> Changes by Hans de Goede:
> - Port to my bq25890 patch-series + various cleanups
> - Make behavior configurable through a new "linux,pump-express-vbus-max"
>   device-property
> - Sleep 1 second before re-checking the Vbus voltage after requesting
>   it to be raised, to ensure that the ADC has time to sampled the new Vbus
> - Add VBUSV bq25890_tables[] entry and use it in bq25890_get_vbus_voltage()
> - Tweak commit message

...

> +static void bq25890_pump_express_work(struct work_struct *data)
> +{
> +	struct bq25890_device *bq =
> +		container_of(data, struct bq25890_device, pump_express_work.work);
> +	int voltage, i, ret;
> +
> +	dev_dbg(bq->dev, "Start to request input voltage increasing\n");
> +
> +	/* Enable current pulse voltage control protocol */
> +	ret = bq25890_field_write(bq, F_PUMPX_EN, 1);
> +	if (ret < 0)
> +		goto error_print;
> +
> +	for (i = 0; i < PUMP_EXPRESS_MAX_TRIES; i++) {

> +		voltage = bq25890_get_vbus_voltage(bq);
> +		if (voltage < 0)
> +			goto error_print;

It also can be (at least in align with the rest error paths)

		ret = bq25890_get_vbus_voltage(bq);
		if (ret < 0)
			goto error_print;
		voltage = ret;

followed up (but not necessarily)...

> +		dev_dbg(bq->dev, "input voltage = %d uV\n", voltage);
> +
> +		if ((voltage + PUMP_EXPRESS_VBUS_MARGIN_uV) >
> +					bq->pump_express_vbus_max)
> +			break;
> +
> +		ret = bq25890_field_write(bq, F_PUMPX_UP, 1);
> +		if (ret < 0)
> +			goto error_print;
> +
> +		/* Note a single PUMPX up pulse-sequence takes 2.1s */
> +		ret = regmap_field_read_poll_timeout(bq->rmap_fields[F_PUMPX_UP],
> +						     ret, !ret, 100000, 3000000);
> +		if (ret < 0)
> +			goto error_print;
> +
> +		/* Make sure ADC has sampled Vbus before checking again */
> +		msleep(1000);
> +	}
> +
> +	bq25890_field_write(bq, F_PUMPX_EN, 0);
> +
> +	dev_info(bq->dev, "Hi-voltage charging requested, input voltage is %d mV\n",
> +		 voltage);

> +	return;
> +error_print:

	if (ret < 0)

But it's up to you.

> +	dev_err(bq->dev, "Failed to request hi-voltage charging\n");
> +}

-- 
With Best Regards,
Andy Shevchenko


