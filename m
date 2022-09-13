Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C632B5B7849
	for <lists+linux-efi@lfdr.de>; Tue, 13 Sep 2022 19:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiIMRlc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Sep 2022 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiIMRkJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Sep 2022 13:40:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612F56C12D;
        Tue, 13 Sep 2022 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663086828; x=1694622828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qwr5ms5q+Z7ve8a7ukY4qstUnie8LtphKGzGWejbU+Y=;
  b=T6A+Is1AMgpldxYhyUOOmpKSuQF3fy/bZm850aGYSnDaDQ5FO0zuwodW
   bMhuX20eU2HyivOTnQE6HHii1MAYiTzLzOfjb6Pl1A3rHn2rxUC4mr7lS
   cKdh1fG0NmV+xtBNm7Ez7pYRtNMl9vjP5/2AXus4p61lP6n/R3qIQUi1O
   1IooFxzZ+fwOtq3SpRPUKp93KMys5fbyxwFD9ovrxH3S23h9hH2Qn0MDF
   dXgOCn0VynDwNSw0v2ZIO+IWbukqe5WaAIl6+Ye+dAc/X3l4lOMLwp7zy
   BFz5Yoj60IsPAssfyz5LjnzczAhfsM3WCrCiF7UJBmYstyEuEtVTdym+a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="295777096"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="295777096"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:32:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="742222406"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 09:32:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oY8q1-001qD0-2E;
        Tue, 13 Sep 2022 19:32:41 +0300
Date:   Tue, 13 Sep 2022 19:32:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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
Message-ID: <YyCwqeQ35F2P9v82@smile.fi.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
 <YxnwMLvgQAPOkeeK@smile.fi.intel.com>
 <CAJZ5v0j5FO+OcX6VdiR-tuDCrHFwErquxzZGUu3ZLQ1G57T-+Q@mail.gmail.com>
 <Yx8MRPxPrNG1XRqV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx8MRPxPrNG1XRqV@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 12, 2022 at 01:39:00PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 10, 2022 at 06:32:10PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Sep 8, 2022 at 3:38 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Tentatively applied as 6.1 material.
> 
> Thanks!
> 
> > If there are updates, we'll make changes as they go.
> 
> There is one at least to fix a warning in the perf patch. Should I resend
> a fixed patch, just a fix, or entire series with a fixed patch?

Since LKP found one small issue with SPI patch when CONFIG_ACPI=n, I decided
to send a v3. Please, replace this by a new version in your tree, thanks!

-- 
With Best Regards,
Andy Shevchenko


