Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBB93D11B9
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhGUOQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbhGUOQB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 10:16:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A55C061575;
        Wed, 21 Jul 2021 07:56:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id l5so2662226iok.7;
        Wed, 21 Jul 2021 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J9GXO25yH99ijG3XbaBRz1X0sXh/ONbHUAdBNJQ2uQA=;
        b=Ox9tULYe6v8F+etXsBGnVP3ZxagjDPkPoE3e2Owy8q9dgWg8g7N7BBtrRQGvWFBr+6
         1DWnyRpCtzw8pSfNr9LhYV0FvVRySbzwR9Xct6LYLyJP2J7Q3sFcAEvDsmMybK7CYgvj
         wRnNAeDCTSfATzudZdTulAqJpXsyF1UvCqkDQck8iZV0s+D62hCPLCVZrr+9Sf7MgN91
         FzK2m+IyV8440MGHYwMhQTlL3qK6+KsbJA11y3y6TdK83Ioh6TMDtnlvyjQc1h4OU/tF
         t5tK8W1d8KZuZJYuXuvSFlti+PMn6KoQu2lwzwfZYnFtpr8Ql2pcf4dDjFyKSY4AgXyn
         kGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9GXO25yH99ijG3XbaBRz1X0sXh/ONbHUAdBNJQ2uQA=;
        b=h528Bp4eNLM9P8E3EepCqUR55r/lXSI7zCs9AhG03krzMzCgQWft5i7HKDam7rw9Ps
         H2oZdUiEV4z85InCwbdu23nS2PIFwiDS035XaK1aiLkq09RS5Mq1zTbSC1C4c9EpyDXJ
         NltIo/4jNL/u2w0E8zwNo2VaJrvs1qUylkBW7hGIARmY3zrmxHEFztuh9MrzlQz57dF7
         8Nwt6zYVbUate74YX9cwZv545PO74/caYDewKVZPjHptt+KmoOWiuCEbsd9gtrajNEhx
         XapEybN5sHb1Pc7fO77fcDddr94DTKxxSsTzJMgCcqOz0FJsJQkd7czr3NmSooBi9MYj
         440Q==
X-Gm-Message-State: AOAM531jyur+K2fZiM+CprDLSAMZ6DnRKR1lfxb0vatQYAmat8XhH6Kc
        vqgiyZKHckQ3mChyZttNAro=
X-Google-Smtp-Source: ABdhPJy7aOJWXiamd0Hlkl05QP+ZmCotvUqMDQL5gZVtwmyHFcb0CCzl9EIhAYopnrV/hlnp5ZOaBg==
X-Received: by 2002:a5d:9f11:: with SMTP id q17mr25728474iot.62.1626879397039;
        Wed, 21 Jul 2021 07:56:37 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d9sm5457443ilv.62.2021.07.21.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:56:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id E0B6427C005A;
        Wed, 21 Jul 2021 10:56:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 21 Jul 2021 10:56:35 -0400
X-ME-Sender: <xms:ozX4YGbCuZ7aC1uJCWtzhxttyZF9oCWQuxfX3jujAB8B0eLqdGoCOw>
    <xme:ozX4YJaFvWtXimH-yLAODBM7HsOnauqn2tSpZX_Jwcveo-8N6LGs9kh8w7244vfFC
    eW4yd5XwBQxaiCdYg>
X-ME-Received: <xmr:ozX4YA_9XlfW6YuQsp0zEuN95DJ08bJ5rvaXlevagGm00kaDhZEs8K34WH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:ozX4YIqlhBsXEhsz7ulYltaphbXKaHAj7rrOdlh2LYAKlc757cMA_g>
    <xmx:ozX4YBo8sGeT722A7iQEydilt0CXH7fx8zIlUZ69UaFEwL_R8FesfQ>
    <xmx:ozX4YGSP5_AU0KmG-TiagSuULopWGfoEG3Xsg-juLSlR9hsVI-kgCg>
    <xmx:ozX4YCRD0LHi8zbRJBvi-D1unRbeYy4dapFyEp9qwWIkPkleNhYt9PPgYiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:56:34 -0400 (EDT)
Date:   Wed, 21 Jul 2021 22:54:36 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v11 2/5] arm64: hyperv: Add panic handler
Message-ID: <YPg1LNq62LMZiXLX@boqun-archlinux>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-3-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626793023-13830-3-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 20, 2021 at 07:57:00AM -0700, Michael Kelley wrote:
> Add a function to inform Hyper-V about a guest panic.
> 
> This code is built only when CONFIG_HYPERV is enabled.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/arm64/hyperv/hv_core.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 4c5dc0f..b54c347 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -127,3 +127,55 @@ u64 hv_get_vpreg(u32 msr)
>  	return output.as64.low;
>  }
>  EXPORT_SYMBOL_GPL(hv_get_vpreg);
> +
> +/*
> + * hyperv_report_panic - report a panic to Hyper-V.  This function uses
> + * the older version of the Hyper-V interface that admittedly doesn't
> + * pass enough information to be useful beyond just recording the
> + * occurrence of a panic. The parallel hv_kmsg_dump() uses the
> + * new interface that allows reporting 4 Kbytes of data, which is much
> + * more useful. Hyper-V on ARM64 always supports the newer interface, but
> + * we retain support for the older version because the sysadmin is allowed
> + * to disable the newer version via sysctl in case of information security
> + * concerns about the more verbose version.
> + */
> +void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> +{
> +	static bool	panic_reported;
> +	u64		guest_id;
> +
> +	/* Don't report a panic to Hyper-V if we're not going to panic */
> +	if (in_die && !panic_on_oops)
> +		return;
> +
> +	/*
> +	 * We prefer to report panic on 'die' chain as we have proper
> +	 * registers to report, but if we miss it (e.g. on BUG()) we need
> +	 * to report it on 'panic'.
> +	 *
> +	 * Calling code in the 'die' and 'panic' paths ensures that only
> +	 * one CPU is running this code, so no atomicity is needed.
> +	 */
> +	if (panic_reported)
> +		return;
> +	panic_reported = true;
> +
> +	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
> +
> +	/*
> +	 * Hyper-V provides the ability to store only 5 values.
> +	 * Pick the passed in error value, the guest_id, the PC,
> +	 * and the SP.
> +	 */
> +	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->sp);
> +	hv_set_vpreg(HV_REGISTER_CRASH_P4, 0);
> +
> +	/*
> +	 * Let Hyper-V know there is crash data available
> +	 */
> +	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
> +}
> +EXPORT_SYMBOL_GPL(hyperv_report_panic);
> -- 
> 1.8.3.1
> 
