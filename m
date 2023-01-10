Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A966429A
	for <lists+linux-efi@lfdr.de>; Tue, 10 Jan 2023 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjAJN7o (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Jan 2023 08:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjAJN6h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Jan 2023 08:58:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6438D3B1;
        Tue, 10 Jan 2023 05:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359104; x=1704895104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6cX28dGS0VjhPVEogbRObB8cGhlwWMZZWbw7paOa07c=;
  b=SlsJnJ5VZ5Tc8fMtvAoGfwhaxNMHSHiYb0IY9h8EbiFOJoAu3EDuLEon
   j7FAYAXi4leY371MaTs2H0yCUCLF1Ud5HsnyIuoFkoR0yoGveaM2nXg9A
   sgQiAc1wpWOsQ6B2b+DCCg7QYGYtDwz4UOWGliBw1OXZtOYdYd1dTZ05J
   jMIG6wuhLeRiLqML8UYjJX7csNW6PS1j93QwJAuA0XP+AGf7cbp77y5OA
   XdlUGDDLfWh4YEidH3IfmAwL/eRZMDnc5vSIqR67GRGvB2Eeu378eF0wW
   sn2RKgGgiTxmm3kz8b0l2VgzVqG5ZSKo2AiE+SuQ52j5h14NbZE1RUdsK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306659802"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306659802"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 05:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902372212"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="902372212"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2023 05:58:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFF8v-0073Mn-0o;
        Tue, 10 Jan 2023 15:58:21 +0200
Date:   Tue, 10 Jan 2023 15:58:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 1/2] efi/earlycon: Replace open coded strnchrnul()
Message-ID: <Y71u/Hn+khg/Nuj7@smile.fi.intel.com>
References: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208221217.56354-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 09, 2022 at 12:12:16AM +0200, Andy Shevchenko wrote:
> strnchrnul() can be called in the early stages. Replace
> open coded variant in the EFI early console driver.

Any comments on the series?

-- 
With Best Regards,
Andy Shevchenko


