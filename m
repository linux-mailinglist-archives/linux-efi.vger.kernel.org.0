Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32F5B199B
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIHKGt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIHKGr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 06:06:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0946C6CCF;
        Thu,  8 Sep 2022 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662631605; x=1694167605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utHqLGNMZQcLYnqO4sBDHQZs1TyYxxyrfzGILDMppNI=;
  b=SCj+/x7WPUeXkEpUrREhDhMKp36uuFpW55uGmzq2hyBEXdYhduZmeK4V
   9pYPXk6HJTMqh79LMK2jIJy7WxVzyKasrk+XCpzmYBFZ4uLkb+obGyjb5
   B8fFJKk+nngPhQPBaxqONF2gkQluPo17yf+ErSHAO9qnVb/SjQnyfxU7o
   eeDgMCQurGt6ft9GMl19NyyHwJ/GNu8obrUnBVY1VaqG2Iga6yE93AyVM
   dHVxxugGiMwVIWa6UXiOty1dbU77i3Eo5ZdbGhyot02vTUwevh4uteRLU
   lXuxVFBAHIsGuWpFbmrtopCBeeyr42lwjMjHbQjWIakbP5sUq4mtEbcwk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383422266"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="383422266"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:06:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="790383928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 03:06:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWEQc-00A4R0-1h;
        Thu, 08 Sep 2022 13:06:34 +0300
Date:   Thu, 8 Sep 2022 13:06:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org, "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v1 8/8] efi/dev-path-parser: Refactor _UID handling to
 use acpi_dev_uid_to_integer()
Message-ID: <Yxm+qgOKCSJ8z0b5@smile.fi.intel.com>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
 <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
 <CAMj1kXFLgo2fC80Z6zKUC8ULyLrFJ7XOvzwE5tYYLtzDhqqHOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFLgo2fC80Z6zKUC8ULyLrFJ7XOvzwE5tYYLtzDhqqHOw@mail.gmail.com>
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

On Thu, Sep 08, 2022 at 10:20:47AM +0200, Ard Biesheuvel wrote:
> On Wed, 7 Sept 2022 at 18:57, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> >         for_each_acpi_dev_match(adev, hid, NULL, -1) {
> > -               if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
> > +               ret = acpi_dev_uid_to_integer(adev, &uid);
> > +               if (ret == -ENODATA && node->acpi.uid == 0)
> >                         break;
> > -               if (!adev->pnp.unique_id && node->acpi.uid == 0)
> > +               if (ret == 0 && node->acpi.uid == uid)
> 
> Is it necessary to reorder the conditions here? I.e., why not

Code-wise there should be not much difference which does not affect the flow,
I think I moved it to be closer to the pattern "let's handle errors first",
but in this case I'm fine with your proposal.

> > +               ret = acpi_dev_uid_to_integer(adev, &uid);
> > +               if (ret == 0 && node->acpi.uid == uid)
> >                         break;
> > +               if (ret == -ENODATA && node->acpi.uid == 0)
> >                         break;
> 
> ?
> 
> With that fixed,
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


