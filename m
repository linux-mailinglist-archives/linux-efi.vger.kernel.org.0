Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B066832CB
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjAaQex (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 11:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAaQeo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 11:34:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B01259B;
        Tue, 31 Jan 2023 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675182860; x=1706718860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0DEwPKhkQjGI3UKmg7bswgp8ZdYCS9oYnQ8XHjDrvXQ=;
  b=ki+WXunXTiLyhaB2R2mDWJErtonsdmvcL74C0yVvaN9DFJjbLDjweX49
   H7VImkHECvYAE5GG9143Pj6CojvL3a7gLNwRCo+dvk1zzYZSYSXUEGHax
   oviqdgXoqubSqRIbaZhLyEjj0Siutt+Xgta8yM/6UYOdWucR3xhZiQD91
   Ja5Aq+JvYdBvyEaOFKxiNOIO/yfAbGEU35LeiBcZok2Y+3glYIBN12tC5
   isXun+SALEwIguZYPIub9JJlL2EGsAyMjANg35QggsN1Izz4+1azaJh/p
   saPC4THpG+zPsvxvedEc8FQHD/1/VdH3auE9ZMh9pylu+61B0OFbRk+IV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325588872"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325588872"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:33:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="666545423"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="666545423"
Received: from bdoolin-mobl1.amr.corp.intel.com (HELO [10.209.125.63]) ([10.209.125.63])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:33:06 -0800
Message-ID: <59f89cd9-9de8-cbec-7bce-cfef3284fd4c@intel.com>
Date:   Tue, 31 Jan 2023 08:33:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2, RESEND] x86/efi: Safely enable unaccepted memory in
 UEFI
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux-efi@vger.kernel.org, "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <20230131004928.153623-1-dionnaglaze@google.com>
 <CAMj1kXG9ONi4_AD1G0Py_qrLLzRfSXGCTEOeu2xowViO0mJkuA@mail.gmail.com>
 <CAAH4kHaqObDRfKAzM8tTrhmQWZx7w2oTP=YJOo=fCG1kHDvj8w@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAH4kHaqObDRfKAzM8tTrhmQWZx7w2oTP=YJOo=fCG1kHDvj8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/31/23 08:08, Dionna Amalie Glaze wrote:
>>> +       efi_status_t status;
>>> +
>>> +       if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
>> Do we need to check for IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) here as well?
>>
> Arguably no, since the firmware should only make the protocol
> available when it determines that the protocol should be used. In our
> case, that's just SEV-SNP. The firmware's TDX logic will not expose
> this protocol.
> 
> This maintains flexibility for the rare case that the TDX go-to-market
> schedule doesn't align with upstream's acceptance of unaccepted memory
> support, but does accept the generic TDX support. Best not paint
> ourselves into a corner.

Yes, please.  Maintaining this functionality for TDX would provide some
more flexibility in how things get accepted upstream.
