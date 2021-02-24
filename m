Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419403235D0
	for <lists+linux-efi@lfdr.de>; Wed, 24 Feb 2021 03:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBXCii (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Feb 2021 21:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhBXCih (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Feb 2021 21:38:37 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4BC06174A;
        Tue, 23 Feb 2021 18:37:57 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 204so837084qke.11;
        Tue, 23 Feb 2021 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gew/d97c74HBNGUJfx+Rk0cvl8/ZTJmIMUjr9vTVx7M=;
        b=Ba9GMlCINUM+zY2JrGDsVLEbfP5OL5LB5Lw8Zm/phXQTYxBbGx1KE8j1zohBruOQKI
         O0/tmltbBWlopzuFvEvxtJioRfKWXhrusxsyjarp2eL2szg6ZMZJ7o9J+lgTvTOFa2WI
         Ulwcafe8tfBPsjfdWBRQM0tyAatPbS2YClRL1zMjwXGwMaOo6gY7aPG3ACfHQhcWFuSw
         Q+5YkT04eJI5IZJhj/RX/meMx4pTWC5xkLcA33T9HuGWo9gjzPlfLFqe1IoNIpxg9A+B
         ifTmRqN/+mNOc/gqTLAf40Tr4UifQF4DwB2IT1VGfqA/Z0WP83q8OzfvfASkL1hpBU8W
         /I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gew/d97c74HBNGUJfx+Rk0cvl8/ZTJmIMUjr9vTVx7M=;
        b=awpdtZWA/rwDRiemHnGnbmfA21ymMGtnxc1yneEycSnbyPO2tuD2LHTLS5el+Hstmq
         C4as51ybmOhCUx12O618bWuo6L6/M2ZAQ3NZJt/Ts1q6q3g4sugLdqJzhrb2fKc1Kq1x
         s8wSXqBcqogyReJEs2x8Pw9hjCfP3moHZ/+kMrG21OtVksnMG8DiIZl19y5H0jG4KKKB
         J6VdZOxPPeXZ7+xS/Y3Ir2AwpPtYnRUwWUv9ABA+QaTv02DmLnKpn6WBY8q9MNQa55Fo
         9e6JyVSFAgM2HDyB0ZYFxaUmPwwcoSS4v7il9vsMGDTGftzT+lyZsR7V0j1qHJmvL2+u
         8JIA==
X-Gm-Message-State: AOAM5324nqDf5+Z5O6Rihj6B1zLGd/DeiJIM/t3SdFl9hjkpoKxq/Cbk
        aImdOFOvxqNVU6GVCuF6bbo=
X-Google-Smtp-Source: ABdhPJyv6fSMmxXyLVhqw8VjDlG1wwoFJhAdl2rxOscK1Ck0FT3LMmAZ/S0HMcFZ+aoVAWLm+IdRLg==
X-Received: by 2002:a37:389:: with SMTP id 131mr29684614qkd.177.1614134276886;
        Tue, 23 Feb 2021 18:37:56 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v187sm578477qkd.50.2021.02.23.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 18:37:56 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7279727C0054;
        Tue, 23 Feb 2021 21:37:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Feb 2021 21:37:55 -0500
X-ME-Sender: <xms:Abw1YGSm55fnSS2IfXVEjvsQALZDXT2FmLIttNcYUAw0Z0MwU_Mw9A>
    <xme:Abw1YLzMRTFXxC7z7CfA7r8GcSwRcw_f19HGYHT6dr3FbAPJhUzqjoOOOjXrTWfrn
    3enMbm6IplhWDNt_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphepudefuddruddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Arw1YD1sWW2t4jgDSfqyNdFYBIOr7SaDAgN6qla8ivhjUpPMTEcXxA>
    <xmx:Arw1YCBQcdnpuDWsZaon4mpyVs4atIGfgN2rLIEMQMsM_fI11vcuRw>
    <xmx:Arw1YPih_zyVxAy6eYnGJKRRqwEz5_d54XlulvrXBC5fEmhz3UnQHg>
    <xmx:Arw1YCoEIJbHHyoZglKSFZlK1BF5Ua1lvOjIB4gjzOLZ-ti4rLk2dIOe1tQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id C334A108005C;
        Tue, 23 Feb 2021 21:37:53 -0500 (EST)
Date:   Wed, 24 Feb 2021 10:37:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Message-ID: <YDW73Oh//1iAGTka@boqun-archlinux>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
 <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 18, 2021 at 03:16:29PM -0800, Michael Kelley wrote:
[...]
> +
> +/*
> + * Get the value of a single VP register.  One version
> + * returns just 64 bits and another returns the full 128 bits.
> + * The two versions are separate to avoid complicating the
> + * calling sequence for the more frequently used 64 bit version.
> + */
> +
> +void __hv_get_vpreg_128(u32 msr,
> +			struct hv_get_vp_registers_input  *input,
> +			struct hv_get_vp_registers_output *res)
> +{
> +	u64	status;
> +
> +	input->header.partitionid = HV_PARTITION_ID_SELF;
> +	input->header.vpindex = HV_VP_INDEX_SELF;
> +	input->header.inputvtl = 0;
> +	input->element[0].name0 = msr;
> +	input->element[0].name1 = 0;
> +
> +
> +	status = hv_do_hypercall(
> +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COMP_1,
> +		input, res);
> +
> +	/*
> +	 * Something is fundamentally broken in the hypervisor if
> +	 * getting a VP register fails. There's really no way to
> +	 * continue as a guest VM, so panic.
> +	 */
> +	BUG_ON((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
> +}
> +
> +u64 hv_get_vpreg(u32 msr)
> +{
> +	struct hv_get_vp_registers_input	*input;
> +	struct hv_get_vp_registers_output	*output;
> +	u64					result;
> +
> +	/*
> +	 * Allocate a power of 2 size so alignment to that size is
> +	 * guaranteed, since the hypercall input and output areas
> +	 * must not cross a page boundary.
> +	 */
> +	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
> +				sizeof(input->element[0])), GFP_ATOMIC);
> +	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
> +

Do we need to BUG_ON(!input || !output)? Or we expect the page fault
(for input being NULL) or the failure of hypercall (for output being
NULL) to tell us the allocation failed?

Hmm.. think a bit more on this, maybe we'd better retry the allocation
if it failed. Because say we are under memory pressusre, and only have
memory enough for doing one hvcall, and one thread allocates that memory
but gets preempted by another thread trying to do another hvcall:

	<thread 1>
	hv_get_vpreg():
	  input = kzalloc(...);
	  output = kmalloc(...);
	<preempted and switch to thread 2>
	hv_get_vpreg():
	  intput = kzalloc(...); // allocation fails, but actually if
	                         // we wait for thread 1 to finish its
				 // hvcall, we can get enough memory.

, in this case, if thread 2 retried, it might get the enough memory,
therefore there is no need to BUG_ON() on allocation failure. That said,
I don't think this is likely to happen, and there may be better
solutions for this, so maybe we can keep it as it is (assuming that
memory allocation for hvcall never fails) and improve later.

Regards,
Boqun

> +	__hv_get_vpreg_128(msr, input, output);
> +
> +	result = output->as64.low;
> +	kfree(input);
> +	kfree(output);
> +	return result;
> +}
> +EXPORT_SYMBOL_GPL(hv_get_vpreg);
> +
> +void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
> +{
> +	struct hv_get_vp_registers_input	*input;
> +	struct hv_get_vp_registers_output	*output;
> +
> +	/*
> +	 * Allocate a power of 2 size so alignment to that size is
> +	 * guaranteed, since the hypercall input and output areas
> +	 * must not cross a page boundary.
> +	 */
> +	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
> +				sizeof(input->element[0])), GFP_ATOMIC);
> +	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
> +
> +	__hv_get_vpreg_128(msr, input, output);
> +
> +	res->as64.low = output->as64.low;
> +	res->as64.high = output->as64.high;
> +	kfree(input);
> +	kfree(output);
> +}
[...]
