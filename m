Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE448EFC9
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jan 2022 19:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiANSR5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jan 2022 13:17:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:31260 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236765AbiANSR5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Jan 2022 13:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642184277; x=1673720277;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ESS4JLWQLJTooACDgnGQbyKtubRvAZlerSf3Jz3ope4=;
  b=ZCWcpLC8wEpwWSBQIVrKphN3W1CFtBvYUYA/0XlfMWDtG3giwAcoOpAw
   dYyib617s/ifgXJVfj+BKxRxjf8dooDM8KCoYG3VC7AspNzJnlWR/waKS
   5un8R6UpAIOkSNPtfpmJq8/M9apzdkLT130nvN8jznU73+TwrgP0LprGp
   3gHFv5rY77WeafDrNig9ZGgnHiYpKpJb5URl1WfF18OR4cPS3s9m+/z/N
   ezBsRE3RELj7m06G8aAuR7+q7gKSbds5qkmaqAU/blQrtuWqSq0YeUG4j
   4da7DruV0uEnDaanUgPJZ34HVm8o6MFfAPhayeWxKbRL8rntkGs0ElhEB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="307644756"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="307644756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 10:17:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="491602157"
Received: from richasha-mobl.amr.corp.intel.com (HELO [10.251.12.158]) ([10.251.12.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 10:17:56 -0800
Subject: Re: [PATCH v5 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
 <20220113213027.457282-4-martin.fernandez@eclypsium.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <eea2c529-b874-58e6-f0b2-1483cc7e30a6@intel.com>
Date:   Fri, 14 Jan 2022 10:17:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113213027.457282-4-martin.fernandez@eclypsium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/13/22 1:30 PM, Martin Fernandez wrote:
> +/*
> + * Update crypto capabilities in a range
> + */
> +static u64 __init __e820__range_update_crypto(struct e820_table *table,
> +					      u64 start, u64 size,
> +					      enum e820_crypto_capabilities crypto_capable)

This looks like an almost pure copy-and-paste of a 70-line function.
That's not the end of the world, but it does seem like a place where
refactoring is in order.

The rest of this series looks pretty straightforward, but this part in
particular is the most worrying.
