Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64725105F1
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 19:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiDZR4N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiDZR4L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 13:56:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C10D1208E;
        Tue, 26 Apr 2022 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650995583; x=1682531583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqUIzyKlR1H4AWn7rRefqRtq3YT/aLsnxjGSzWgozcU=;
  b=bfhDEV8F5VghxEWFPhZOIWEfEtSXKE2Jkh1YVPEg0FWam01bhknSytoy
   IcwJ8z5cXX95dl82x0ufhyDP5dbnxFtHhBZdxquEgcWg9ZwFJ7MY+Rc/o
   aLIBQrqIe/qj61PRUzLq0pfbL9M+52m/moYCIvZMBGNNlV4mvc/uOvGx3
   Ouk6YNBB7z/NV8ll7Wed8d+w/APACgwoTZybDQWQ1VxlMZosrVngIiEHB
   +7QDlyaCVbH27ezLpdcl76k6oOWRBCmw07yj1SlYSd6xjSiOzb5hBO1jo
   IJo6MhNobHBKPXekXKjxTdCFHhgb0/2pIrMkts2JXQWyOG9IOwjlmhFkv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245595597"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="245595597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:53:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="580064081"
Received: from dsocek-mobl2.amr.corp.intel.com (HELO [10.212.69.119]) ([10.212.69.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:53:00 -0700
Message-ID: <90b448ba-2d5c-b0a2-4716-a8470fe09af0@intel.com>
Date:   Tue, 26 Apr 2022 10:55:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 5/8] x86/e820: Refactor e820__range_remove
Content-Language: en-US
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-6-martin.fernandez@eclypsium.com>
 <a02186b9-b72c-1484-2973-c59272ae0a7e@intel.com>
 <CAKgze5Y1bKUAqPHEY71y_puTmuV2K02qjt0qzwO-KA3SYio0Tw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAKgze5Y1bKUAqPHEY71y_puTmuV2K02qjt0qzwO-KA3SYio0Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 4/26/22 10:37, Martin Fernandez wrote:
>> Also, in general, the naming is a bit verbose.  You might want to trim
>> some of those names down, like:
>>
>>> +static bool __init crypto_updater__should_update(const struct e820_entry
>>> *entry,
>>> +						 const void *data)
>>> +{
>>> +	const struct e820_crypto_updater_data *crypto_updater_data =
>>> +		(const struct e820_crypto_updater_data *)data;
> Yes I agree on this. Do you have any suggestions for these kind of
> functions? I want to explicitly state that these functions are in some of
> namespace and are different of the other ones.
> 
> In the end I don't think this is very harmful since these functions are one-time
> used (in a single place), is not the case that you have to use them everywhere..

Let's just start with the fact that this is a pointer to a structure
containing an enum that represents a single bit.  You could just pass
around an address to a bool:

	bool crypto_capable = *(bool *)data;

or even just pass and use the 'void *data' pointer as a value directly:

	bool crypto_capable = (bool)data;

That, for one, would get rid of some of the naming craziness.

If it were me, and I *really* wanted to keep the full types, I would
have just condensed that line down to:

	struct e820_crypto_updater_data *crypto_data = data;

Yeah, it _can_ be const, but it buys you practically nothing in this
case and only hurts readability.
