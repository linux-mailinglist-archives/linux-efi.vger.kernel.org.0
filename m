Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FF23D11B0
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 16:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhGUOOJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Jul 2021 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhGUOOI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Jul 2021 10:14:08 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82EC061575;
        Wed, 21 Jul 2021 07:54:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b6so2495329iln.12;
        Wed, 21 Jul 2021 07:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnGmo/fy5JZJZKX65E0J62+Rst19HIULEQ4sdo7Eb8w=;
        b=bGrx8MfBqOjRugClxOJXLkIIidfG+RHRxwXPJwJ+ZFh49MFhoO34WcASdceKFsVAfF
         7HLWlj7aXwmzdqPFD6hHZOtznS1zNSpkM62RuqBrZlGH6tDVfDq8a0ERNQI1ujSumjAx
         3OEgYIyFfLtAspDVHAkX77mC+bBs+Eky8oghMz+4g3JIZvMK6bgL7iJ7fS+IBR/HHYma
         2EibuGfpbH6yTFZkgGjn8sRPcMlbSvsIoBiFOrjMuR3LLIw3Lpv0SHIRfvI/NDOj2dYu
         MOgaMvyiT/VbcbnbcszKX4TzbZO7jbnbrbUkM1JmckZQiGLslXXt0tyIS8FLzid4V9SP
         f/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnGmo/fy5JZJZKX65E0J62+Rst19HIULEQ4sdo7Eb8w=;
        b=Nc001Ht66nWLQCahOSzcbz9GeXAgeflaO9fw77oN9M3i0HLU9NsQSShlKNyx3INar2
         MYq0QiCAWd9Yk8/LQewIKKB1m00CEeJdRRtFmnRbwvOjTWn4xu2FnW7hHpXDbxVC/X+E
         4sNICVf2kJVhxrSO/mswyjqUtjfEdpl2Eom6OUDjWaIIQKsMYBPSHnSpFjxLMBcxp59d
         H08MYkefrUG9v/y4MIZyC3Q/idK5WmGkqLEFv8XXJY+scsCgO5yHn2Vx8gZTQpGyqVrg
         Oyf5VTZBQPuv3Lb+8GgcyV08NRVJS2JMo/qNSeG7y+nQua7ODJoc5IRAxBWoYscZwA4y
         ZiBQ==
X-Gm-Message-State: AOAM530DMOY3aQ1p75kxfFkQ3a9zUyz3OgWds4KIyX/SLYL4DhwBt8Bd
        yq9WzGt99b/z5X8rI1Y2yps=
X-Google-Smtp-Source: ABdhPJztiZIhk5PT0XPEB9YTcNeI6pk9uPg4hwCrD6StxeZX1w0K0zubLBGsRFjvvYTpK1NFsPXu1g==
X-Received: by 2002:a92:c0c3:: with SMTP id t3mr23817194ilf.80.1626879283872;
        Wed, 21 Jul 2021 07:54:43 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c4sm13015692ilq.70.2021.07.21.07.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:54:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 30F6127C005A;
        Wed, 21 Jul 2021 10:54:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Jul 2021 10:54:42 -0400
X-ME-Sender: <xms:MDX4YO-dX3aoliP4rW5rN6LfbrrEZ8_5xoLc_z5UR-OXuXqy_b0riA>
    <xme:MDX4YOsU5XAFk3leEe420a0dXA8qrph_XRSoJubpcJiatH6HOW7H9U9n_GLfnf9w-
    HPmgmPcXEOtZMxiww>
X-ME-Received: <xmr:MDX4YEBiWeyNyfFb6TNA48LI5gjiYPQA1FB3Tf7d81ZQYywJAFTNQ3fl0-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:MDX4YGfBN0gMPiy5GPKLto5xKIEto31a9yMx4kGiqy8J1UsgxNMq6w>
    <xmx:MDX4YDOnt7DRLpUr2uNA1YZmSe2LH10kvHj8QLlGVwKuk3Joloo6hQ>
    <xmx:MDX4YAmfVByI4y7_oQ1qcmqQ3C_vQ83a0CI1JSYhnU1M362Y9z1q4Q>
    <xmx:MTX4YAmGZImVzq-a6Wd_8V9ze1KqKHoP3HB2QzZ2rwTQd51tQcs5LaaHU6A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:54:40 -0400 (EDT)
Date:   Wed, 21 Jul 2021 22:52:41 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v11 5/5] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Message-ID: <YPg0uZRcDm0wj0J7@boqun-archlinux>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
 <1626793023-13830-6-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626793023-13830-6-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 20, 2021 at 07:57:03AM -0700, Michael Kelley wrote:
> Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> ARM64, causing the Hyper-V specific code to be built. Exclude the
> Hyper-V enlightened clocks/timers code from being built for ARM64.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

FWIW,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/hv/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d..e509d5d 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
>  
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> +	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +		|| (ARM64 && !CPU_BIG_ENDIAN))
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR
>  	help
> @@ -12,7 +13,7 @@ config HYPERV
>  	  system.
>  
>  config HYPERV_TIMER
> -	def_bool HYPERV
> +	def_bool HYPERV && X86
>  
>  config HYPERV_UTILS
>  	tristate "Microsoft Hyper-V Utilities driver"
> -- 
> 1.8.3.1
> 
