Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC7510185
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351919AbiDZPNR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351918AbiDZPL7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 11:11:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62F161BB7;
        Tue, 26 Apr 2022 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650985702; x=1682521702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j2V5+3CZNEUZjk60xmVPNepccy31dj0aymHOLGJ7vBI=;
  b=XWm3AW2MQuj0gLHrqbeZHigmbhllG/SEEGEcAPoOQLv6vY3B2JelNnrE
   3ecLFFWkuNAvuOM5DGWZIhOtvXMyPRN0b1/mIZl9xaM4nJq/tUKzpl56W
   dSFowNBXnK8LBatx4aWo07dvdfSly1avO+I4BrVGGSxbQ3g0c3nR9bf4y
   XJNaGuEx5765gMfARJqP+QtZt/Qp0XhVd/+Mu2+k14SrC4gKdi2MtabET
   Dlo9qrUiIZauICQ+gtO9cg49aBfKsD3qM4Unejy3AZmMNvj3yhNU4OrFY
   gukKvazZwUoRP8i6WGWXiLQrscAhofQt2YChYV51GoXmZluOKonCaZ2Vy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265129903"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265129903"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 08:08:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="595802962"
Received: from dsocek-mobl2.amr.corp.intel.com (HELO [10.212.69.119]) ([10.212.69.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 08:08:20 -0700
Message-ID: <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
Date:   Tue, 26 Apr 2022 08:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 5/8] x86/e820: Refactor e820__range_remove
Content-Language: en-US
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-6-martin.fernandez@eclypsium.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220425171526.44925-6-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/25/22 10:15, Martin Fernandez wrote:
> +/**
> + * e820__range_remove() - Remove an address range from e820_table.
> + * @start: Start of the address range.
> + * @size: Size of the address range.
> + * @old_type: Type of the entries that we want to remove.
> + * @check_type: Bool to decide if ignore @old_type or not.
> + *
> + * Remove [@start, @start + @size) from e820_table. If @check_type is
> + * true remove only entries with type @old_type.
> + *
> + * Return: The size removed.
> + */

The refactoring looks promising.  But, there's a *LOT* of kerneldoc
noise, like:

> + * @table: Target e820_table.
> + * @start: Start of the range.
> + * @size: Size of the range.

and this:

> + * struct e820_type_updater_data - Helper type for
> + * __e820__range_update().
> + * @old_type: old_type parameter of __e820__range_update().
> + * @new_type: new_type parameter of __e820__range_update().

Those are just a pure waste of bytes.  I suspect some more judicious
function comments would also make the diffstat look more palatable.

Also, in general, the naming is a bit verbose.  You might want to trim
some of those names down, like:

> +static bool __init crypto_updater__should_update(const struct e820_entry *entry,
> +						 const void *data)
> +{
> +	const struct e820_crypto_updater_data *crypto_updater_data =
> +		(const struct e820_crypto_updater_data *)data;

Those are just some high-level comments.  This also needs some really
careful review of the refactoring to make sure that it doesn't break any
of the existing e820 users.
