Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3ED5B1F60
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIHNiF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiIHNiE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 09:38:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E6BC2F80;
        Thu,  8 Sep 2022 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662644283; x=1694180283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b3oDheI9HlriGFBUl+RRrQ8972WbuLW62mIovZOq/O4=;
  b=AmoZm+W7TstuiHoN+lzO9Xwl3sOPu9V77HWp7FFB17i53WmsmrG43h5Q
   MtkdjavKgjaTAaANdhPa5j2JFwsSDPOcTQs+5hss7DHVy90Q7zb6D8o8u
   wy6dhPIGyiAfK0uWmNUVDnqRVfo5S4yaim4tGeGJ6va0r4snzfLkrfsHy
   tB7F8HfGKnstiNcD3/nwRs6R/murSU8yp92639+eXcFblgUuKSTc49nHD
   zj08SA19N788t8JF2CadK86Ee97M8bcXpcTof/5H/9fsHv89QCEGYE8G5
   1GuLoOQfPl5avD+QZPHtt1sQHyPAnRB+JBkffpO6nuTKMCT0eEgTVZSg7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298508517"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298508517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:38:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683234779"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:37:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWHj6-00A92n-2S;
        Thu, 08 Sep 2022 16:37:52 +0300
Date:   Thu, 8 Sep 2022 16:37:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v2 0/8] ACPI: unify _UID handling as integer
Message-ID: <YxnwMLvgQAPOkeeK@smile.fi.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 08, 2022 at 04:29:02PM +0300, Andy Shevchenko wrote:
> This series is about unification on how we handle ACPI _UID when
> it's known to be an integer-in-the-string.
> 
> The idea of merging either all via ACPI tree, or taking ACPI stuff
> for the v6.1 while the rest may be picked up later on by respective
> maintainers separately

>(currently all depends on Wolfram, other
> patches have got the tags from the maintainers).

I stand corrected, the perf patch is not tagged yet.

> Partially compile-tested (x86-64).

Forgot to mention that there is a new user of this API is pending:
https://lore.kernel.org/linux-gpio/20220908072621.3415957-1-jay.xu@rock-chips.com/

-- 
With Best Regards,
Andy Shevchenko


