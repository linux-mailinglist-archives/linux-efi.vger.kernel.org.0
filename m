Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACC5B199E
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiIHKHH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiIHKHG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 06:07:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE68C6FD7;
        Thu,  8 Sep 2022 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662631625; x=1694167625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NCMYuaghCCLYiVfbRGO7/C8mw8n6/gmcgPBD0pal7aY=;
  b=CqJiWelJBoB3UOW6tUdDXngLqmeMyX+frhWw1BQ5DINhGQWvox/ZyP2I
   ns99I1qGS6+AznXxeyGrMgMY/W/ZzG6QpgAxGVnmJWroR9C0KStdaSbF8
   L1fxu5pmEUo2b0tHiP8CzaZnTiF3qh8Mu0+vjJTy9IJmvDoLyeu4fEStS
   2aF7PIcFshDgtoPbbI54f6zw1mXT0Iskx7ZfBEI+Rd5kRF2GPtEExLla/
   TNSYcmMUKEv7zgC8PiHmSsXlftkZuKX/yx+kmcgBB1w/ylSD+514ufaCt
   7VXFG4g5Egol0njhpchtQ6e+3vH1D2SuTEQBDeo74FVIiSQBqsUJ9WU3O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323321525"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="323321525"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="610639513"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:06:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWEQw-00A4Ra-1f;
        Thu, 08 Sep 2022 13:06:54 +0300
Date:   Thu, 8 Sep 2022 13:06:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
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
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 0/8] ACPI: unify _UID handling as integer
Message-ID: <Yxm+vkO31ip16+q0@smile.fi.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
 <fd1c459c-0c49-8fee-f71e-b2756aad84e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1c459c-0c49-8fee-f71e-b2756aad84e9@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 08, 2022 at 11:28:48AM +0200, Hans de Goede wrote:
> On 9/7/22 18:45, Andy Shevchenko wrote:
> > This series is about unification on how we handle ACPI _UID when
> > it's known to be an integer-in-the-string.
> > 
> > The idea of merging either all via ACPI tree, or (which I prefer)
> > taking ACPI stuff for v6.1 while the rest may be picked up later
> > on by respective maintainers separately.
> > 
> > Partially compile-tested (x86-64).
> > 
> > Andy Shevchenko (8):
> >   ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
> >     integer
> >   ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
> >   ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
> >   i2c: amd-mp2-plat: Refactor _UID handling to use
> >     acpi_dev_uid_to_integer()
> >   i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
> >   perf: qcom_l2_pmu: Refactor _UID handling to use
> >     acpi_dev_uid_to_integer()
> >   spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
> >   efi/dev-path-parser: Refactor _UID handling to use
> >     acpi_dev_uid_to_integer()
> > 
> >  drivers/acpi/acpi_lpss.c               | 15 ++++++------
> >  drivers/acpi/utils.c                   | 24 ++++++++++++++++++
> >  drivers/acpi/x86/utils.c               | 14 ++++++++---
> >  drivers/firmware/efi/dev-path-parser.c | 10 +++++---
> >  drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++-------------
> >  drivers/i2c/busses/i2c-mlxbf.c         | 19 +++++---------
> >  drivers/perf/qcom_l2_pmu.c             |  7 +++---
> >  drivers/spi/spi-pxa2xx.c               | 34 +++++++-------------------
> >  include/acpi/acpi_bus.h                |  1 +
> >  include/linux/acpi.h                   |  5 ++++
> >  10 files changed, 81 insertions(+), 75 deletions(-)
> > 
> 
> Thanks, patches 1-7 look good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for patches 1-7.
> 
> I have one small remark for patch 8, which I will send in
> a reply to patch 8.

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


