Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B705B322B
	for <lists+linux-efi@lfdr.de>; Fri,  9 Sep 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiIIIoy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Sep 2022 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiIIIox (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Sep 2022 04:44:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC552804;
        Fri,  9 Sep 2022 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662713091; x=1694249091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dx9fQD19vhc3Jmyo1THX6cO2GO5PTZm/g2LWty61b2Y=;
  b=QHJpo1E6dJTFxXdxjg8SBKDzuiS7/urim38S/RO1qaRRdBd2XP988Ecv
   9tLqlJovQe2PD08cuXLwF/sdkE00wSXtcUOxMIaNak+JOAE0JqLrtenmP
   ck7SHlXHrJV3Dtk5PAwXopKGiVdoTQ07CgTLZWrEQdiX3zZCuQPNuHeDA
   MdjXbjYsYoSKF+o4wiK7a0UKBg/XKgZxpbg+rvXDk9vsf56uS8cTshb5n
   uS4lW0/W8cflaLO8+9WNqGUioCxrUgRKPQfbJcBN2NFlmLQaXXT2j9ev5
   QbicBYoILqrJk4fzGuCUvjJL6oNDqTV8SOkE1MEEmVrdK1yKUhSqliPXt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284448271"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="284448271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:44:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="615204912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:44:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWZcu-00AUCb-2A;
        Fri, 09 Sep 2022 11:44:40 +0300
Date:   Fri, 9 Sep 2022 11:44:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, kbuild-all@lists.01.org,
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
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2 6/8] perf: qcom_l2_pmu: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Message-ID: <Yxr8+NYw/+gbmTBu@smile.fi.intel.com>
References: <20220908132910.62122-7-andriy.shevchenko@linux.intel.com>
 <202209091254.rIFedxQL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209091254.rIFedxQL-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 09, 2022 at 12:40:36PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:

Indeed.

> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/device.h:15,
>                     from include/linux/acpi.h:15,
>                     from drivers/perf/qcom_l2_pmu.c:4:
>    drivers/perf/qcom_l2_pmu.c: In function 'l2_cache_pmu_probe_cluster':
> >> drivers/perf/qcom_l2_pmu.c:882:17: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Wformat=]

Fixed locally.

-- 
With Best Regards,
Andy Shevchenko


