Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76A690E51
	for <lists+linux-efi@lfdr.de>; Thu,  9 Feb 2023 17:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBIQ1f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Feb 2023 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIQ1f (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Feb 2023 11:27:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B62ED5A
        for <linux-efi@vger.kernel.org>; Thu,  9 Feb 2023 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675960054; x=1707496054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9M+jCybV1yApcakYwNAUtZNPevLpW0gaG6aUc0Nx6nU=;
  b=iVSPmCErGgJIzalEr6gvGCdFN7q9ZHSROvfOzLAApXAuABroYCiC4nGA
   I2fztWXbBtca3M/TJcbPX9wF5l3md0o8H6JiD3D8drMPGHCBWiTfXCmiL
   HYdRHjzL+GamjHqBQ/ZCQ2dRAaGlde0SadHNHVAeUPPmMlGNmnYelzqSV
   YEiNNAc9+kVRsv1g9fBGCpFW0LY+DbT8nn4rHb+08J3oJLCPAfOdXXRoi
   uzMqe77XNVK4lbCTvJYDYlqoQ3Hs/qARasz7xTpzDojq0HOoxrZF2dlm4
   RpVjkDQEQrVv3eH1tBAY6gKtbxbG3IKkGrUImQvm+VU9w2eUCXRHiFfPH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="332291170"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="332291170"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:27:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="996578405"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="996578405"
Received: from aryanpra-mobl.amr.corp.intel.com (HELO [10.212.150.227]) ([10.212.150.227])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:27:32 -0800
Message-ID: <43146301-b99f-be9c-b2e5-ad7a21c46c4b@intel.com>
Date:   Thu, 9 Feb 2023 08:27:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] efi: x86: Wire up IBT annotation in memory
 attributes table
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230206124938.272988-1-ardb@kernel.org>
 <20230206124938.272988-4-ardb@kernel.org>
 <ca9dc359-899b-ec69-36e0-17225189da01@intel.com>
 <Y+QCvSmdrqaJjxoT@hirez.programming.kicks-ass.net>
 <Y+QMNzjz0l8cnW4Y@FVFF77S0Q05N.cambridge.arm.com>
 <63e51b92.170a0220.ca7b5.2b23@mx.google.com>
 <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXHZwKPifJu1Y+hvjivJWU9YMJHyR84Y23nMsYrCxM0uYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/9/23 08:23, Ard Biesheuvel wrote:
> I have no strong preference one way or the other, but given that
> apm_32.c is not the epicenter of new development, and the call from
> EFI code is self-documenting already ('
> ibt_save(efi_disable_ibt_for_runtime)', I'm inclined to just queue the
> patch as-is, and leave it to whoever feels inclined to spend more free
> time on this to come up with some nice polish to put on top.
> 
> Unless anyone minds?

No objections from the x86 side.
