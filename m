Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F05B1990
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIHKFI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIHKFH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 06:05:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2F9E8B2;
        Thu,  8 Sep 2022 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662631506; x=1694167506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Ek9wygy8aZWzMgiPRlm9cfMhpuOEUegAjyWFacJCV0=;
  b=kzKMbkSq4YUCxWQ7saoC0bjymdOKShvwuVQf5aF2xJu8x20EUQWj9PpV
   +CquM/sdd15/u9QVTK0ggJshpo4+MLHoj5q/oLDcHiExpnxtjoPoyXKmf
   h05t3ITz41VmrX4ZwYfHa3K6xoW+23WCf1dlAyo9HM02oCuKUjRt0xp3a
   Z+IceWTvZiryPvkTJ2l3XpfGifoV4KEwVVm0VhxX3Un2G0FuIbLrCVz5a
   xoJ1utYV4NitvWoQt7uAUl7J/ShFDux+8P5fo6003NdV1JFa4wljpdl09
   j+Wf82o4/FiXgrUzXSsl2lY44sBK3rpZ5pl/XjQkG2D+E9w+k5KA9mnAV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="298465140"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="298465140"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:05:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="790383420"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:04:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWEP1-00A4Oy-2z;
        Thu, 08 Sep 2022 13:04:55 +0300
Date:   Thu, 8 Sep 2022 13:04:55 +0300
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
Subject: Re: [PATCH v1 8/8] efi/dev-path-parser: Refactor _UID handling to
 use acpi_dev_uid_to_integer()
Message-ID: <Yxm+R+x5zSTvDFrj@smile.fi.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
 <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
 <72acff59-81f0-f466-6197-d3e993f051ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72acff59-81f0-f466-6197-d3e993f051ac@redhat.com>
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

On Thu, Sep 08, 2022 at 11:29:22AM +0200, Hans de Goede wrote:
> On 9/7/22 18:46, Andy Shevchenko wrote:

...

> > +	long ret;
> 
> "long ret" should be "int ret" here since that is what acpi_dev_uid_to_integer()
> returns.

I put it long since the efi_get_device_by_path() uses long ret (for the sake of
consistency with the existing code), but I have no objections to move it to
int.

-- 
With Best Regards,
Andy Shevchenko


