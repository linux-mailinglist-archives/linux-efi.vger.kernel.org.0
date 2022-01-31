Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F84A4883
	for <lists+linux-efi@lfdr.de>; Mon, 31 Jan 2022 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbiAaNpH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 Jan 2022 08:45:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:7571 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbiAaNpH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 Jan 2022 08:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643636707; x=1675172707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CasoBmym73K2cb88XgHZZ0eFeBOjjcRUmQE9cD7PlDA=;
  b=NlR5rJPHQNSFcSR8sAr3+/bmxDJwMPm+glPB4qlWuij3FxJIstDkGQST
   BRkIxdl6HTkYsixCKmvSHy/PeqE/EjdcAxzAFntZwZdF22Wlk42ce+7RH
   Q0As2ao6hEbXe0o1e0OclraFohX8WB5YSE227f85IfeCaf4JKs+jXr2jC
   JMJdCCGKl3PSUol2a3pL6dqfhB4sDwaWLxcvECpQtC1KxsSzgSTaObYEr
   Y6deSIbiJ38biZpPWRXfFAM1MQLn1WIg2GSOoe1qujoJsdlx3/euJOXzY
   Vp1J4/Egb32JTzRQbh+wHO4zvhRQ9DoaABHStytfClZRVBIk+HGRbJ+41
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="247415336"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247415336"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:45:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="496924804"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 05:45:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEWyM-00Gsyj-IS;
        Mon, 31 Jan 2022 15:43:58 +0200
Date:   Mon, 31 Jan 2022 15:43:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v4 01/20] power: supply: core: Refactor
 power_supply_set_input_current_limit_from_supplier()
Message-ID: <Yffnnom1qTRFbo/o@smile.fi.intel.com>
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-2-hdegoede@redhat.com>
 <YffmDCHY6csr0uyD@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YffmDCHY6csr0uyD@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 31, 2022 at 03:37:16PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:38PM +0100, Hans de Goede wrote:
> > Some (USB) charger ICs have variants with USB D+ and D- pins to do their
> > own builtin charger-type detection, like e.g. the bq24190 and bq25890 and
> > also variants which lack this functionality, e.g. the bq24192 and bq25892.
> > 
> > In case the charger-type; and thus the input-current-limit detection is
> > done outside the charger IC then we need some way to communicate this to
> > the charger IC. In the past extcon was used for this, but if the external
> > detection does e.g. full USB PD negotiation then the extcon cable-types do
> > not convey enough information.
> > 
> > For these setups it was decided to model the external charging "brick"
> > and the parameters negotiated with it as a power_supply class-device
> > itself; and power_supply_set_input_current_limit_from_supplier() was
> > introduced to allow drivers to get the input-current-limit this way.
> > 
> > But in some cases psy drivers may want to know other properties, e.g. the
> > bq25892 can do "quick-charge" negotiation by pulsing its current draw,
> > but this should only be done if the usb_type psy-property of its supplier
> > is set to DCP (and device-properties indicate the board allows higher
> > voltages).
> > 
> > Instead of adding extra helper functions for each property which
> > a psy-driver wants to query from its supplier, refactor
> > power_supply_set_input_current_limit_from_supplier() into a
> > more generic power_supply_get_property_from_supplier() function.
> 
> ...
> 
> > +	ret = power_supply_get_property_from_supplier(bdi->charger,
> > +						      POWER_SUPPLY_PROP_CURRENT_MAX,
> > +						      &val);
> > +	if (ret == 0)
> 
> Can it be as simple as
> 
> 	if (ret)
> 		return;
> 
> 	...
> 
> 
> ?
> 
> Or did I misunderstand the meaning of 0?

Despite on this comment being addressed or not, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I don't see any blocking issues with the bq25890 part neither, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for the BQ25890 part.

-- 
With Best Regards,
Andy Shevchenko


