Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD533E0611
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhHDQks (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:40:48 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55885 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhHDQkq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Aug 2021 12:40:46 -0400
Received: by mail-wm1-f51.google.com with SMTP id x17so1566757wmc.5;
        Wed, 04 Aug 2021 09:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ntN9WY4zmMZ23iXHsqDbV7BPHjIIMx7cF5b4w8slmdM=;
        b=E9rg148APKDCUiGyWGvz8xK7eXKnUuSmsPzc/AUGcBJtSYqullHi1lFZJDp/ycgc6u
         gDftB3d1CFPtCpkgZT1nxu53Yuo5/wrEUe8knor6+MMVtqD79vydw/CIHB/4zICuLiVm
         IHOigZGoQPDnsaH8OqZuNlw6ctTm1vPQc7mCwwwXvCfDK3c7Wc5VzpwCY/7SCdsmeNr/
         ii4pGv20F3IFPVEdCqj7XHtSeR2G97J2v7Zm0JPD4VVwsHwlLv+5FIFYPRBVG1ZsMI/d
         lBqT8NHRl9uH7crOq6I4gp+2/++WI4u5n0Fzj860AgPiCCOpSlqrSR9Ur3mkmrj4++0P
         rZoA==
X-Gm-Message-State: AOAM531W4AkjHP9mSqC8367rvh49S2nsZKX/yL0uWFws0E9M5+vea8lL
        c83r5TBTvzfZqJo+er7ObTI=
X-Google-Smtp-Source: ABdhPJynlr56hUIGm77MB/+XdHVmQE9WJCF4/cvFGzgNtcIZYCGID8+vnvr9j88n+a8CO1dHLsp2uw==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr484815wmi.49.1628095231907;
        Wed, 04 Aug 2021 09:40:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v12sm3125785wrq.59.2021.08.04.09.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 09:40:30 -0700 (PDT)
Date:   Wed, 4 Aug 2021 16:40:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michael Kelley <mikelley@microsoft.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, ardb@kernel.org
Subject: Re: [PATCH v12 5/5] Drivers: hv: Enable Hyper-V code to be built on
 ARM64
Message-ID: <20210804164029.6xmloksmssrdsmvo@liuwe-devbox-debian-v2>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
 <1628092359-61351-6-git-send-email-mikelley@microsoft.com>
 <20210804161040.GC4857@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804161040.GC4857@arm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 05:10:41PM +0100, Catalin Marinas wrote:
> On Wed, Aug 04, 2021 at 08:52:39AM -0700, Michael Kelley wrote:
> > Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
> > ARM64, causing the Hyper-V specific code to be built. Exclude the
> > Hyper-V enlightened clocks/timers code from being built for ARM64.
> > 
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > ---
> >  drivers/hv/Kconfig | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 66c794d..e509d5d 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
> >  
> >  config HYPERV
> >  	tristate "Microsoft Hyper-V client drivers"
> > -	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
> > +	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > +		|| (ARM64 && !CPU_BIG_ENDIAN))
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR
> 
> Does this need to be:
> 
> 	select X86_HV_CALLBACK_VECTOR if X86
> 
> I haven't checked whether it gives a warning on arm64 but that symbol
> doesn't exist.
> 
> Anyway, I can fix it up locally.

I can fix it up while I queue these patches.

Wei.
