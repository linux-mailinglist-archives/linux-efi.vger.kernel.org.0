Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617AC5B5889
	for <lists+linux-efi@lfdr.de>; Mon, 12 Sep 2022 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiILKjN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Sep 2022 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiILKjL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Sep 2022 06:39:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAED21241;
        Mon, 12 Sep 2022 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662979151; x=1694515151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3vFwdYLxWsQ9bEvrr+2hHC3zOoyKWcZ+8GtDAo7dCU=;
  b=FUx8SQDi+VRECKMNKEnrPkpJ8h77lUkDB8/1EhzRLRgCAce1DSqj4Ind
   BPryJaJGJCURHbm3FycsO0pHttBthL2JYA3Gc3pyWRDDVwFzFM057WQ/0
   q5e6cwGM4zx5BpkcOPdjxOeoA9PF0iigpQA+r5z5sc18qGcSg7Yxi+Lvs
   02wmm6NEf9vXY/qVbeDUhq6JUtaIxBdRlMjKO2DYAH3LZfb+aLw9OE1B8
   xcOSLczz7hBLTMW+a9Akn5SICrseaiOI62IR4CP3zubvMvh3b6Qoh2Ku7
   M2uIDcFwt2hl7feJvxAJDH/pr7tI4wMYII6D4GU7+zKl+blDsBia4UnCg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359558492"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="359558492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="719712154"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:39:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oXgqC-001Irg-2C;
        Mon, 12 Sep 2022 13:39:00 +0300
Date:   Mon, 12 Sep 2022 13:39:00 +0300
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
Message-ID: <Yx8MRPxPrNG1XRqV@smile.fi.intel.com>
References: <20220908132910.62122-1-andriy.shevchenko@linux.intel.com>
 <YxnwMLvgQAPOkeeK@smile.fi.intel.com>
 <CAJZ5v0j5FO+OcX6VdiR-tuDCrHFwErquxzZGUu3ZLQ1G57T-+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j5FO+OcX6VdiR-tuDCrHFwErquxzZGUu3ZLQ1G57T-+Q@mail.gmail.com>
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

On Sat, Sep 10, 2022 at 06:32:10PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 8, 2022 at 3:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Tentatively applied as 6.1 material.

Thanks!

> If there are updates, we'll make changes as they go.

There is one at least to fix a warning in the perf patch. Should I resend
a fixed patch, just a fix, or entire series with a fixed patch?


-- 
With Best Regards,
Andy Shevchenko


