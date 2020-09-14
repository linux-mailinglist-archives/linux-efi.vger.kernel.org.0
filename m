Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E704026901F
	for <lists+linux-efi@lfdr.de>; Mon, 14 Sep 2020 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgINPe1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Sep 2020 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgINPeW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Sep 2020 11:34:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D200C06174A;
        Mon, 14 Sep 2020 08:34:22 -0700 (PDT)
Received: from zn.tnic (p200300ec2f09260028f4716b73cc78b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:28f4:716b:73cc:78b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEEF71EC058B;
        Mon, 14 Sep 2020 17:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600097660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YXmL5o+5O/KOYyqI3oi43ZTS7SkSSlK/ze8t5L5fSfQ=;
        b=EAmq5DFWpMxdEeL4KVyeHQyYWK+iggDCr5KBYNJ7gZtm4Y3fHirnEJJiGgLt5a7KM46hi+
        /6h83sABEAfSqwqR/AUM4jVJ/jS8tPPnfT9Vf0GSUMbs3ab1G4E7ka2dJI5fIYqxF+zysL
        s/ez1NP600mRFcG/8PVpAomZ8oAhXDk=
Date:   Mon, 14 Sep 2020 17:34:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 2/2] x86/mce/dev-mcelog: Fix updating kflags in AMD
 systems
Message-ID: <20200914153420.GD680@zn.tnic>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
 <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 03, 2020 at 06:45:31PM -0500, Smita Koralahalli wrote:
> The mcelog utility is not commonly used on AMD systems. Therefore, errors
> logged only by the dev_mce_log() notifier will be missed. This may occur
> if the EDAC modules are not loaded in which case it's preferable to print
> the error record by the default notifier.
> 
> However, the mce->kflags set by dev_mce_log() notifier makes the default
> notifier to skip over the errors assuming they are processed by
> dev_mce_log().
> 
> Do not update kflags in the dev_mce_log() notifier on AMD systems.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20200828203332.11129-3-Smita.KoralahalliChannabasappa@amd.com
> 
> v3:
> 	No change
> v2:
> 	No change
> ---
>  arch/x86/kernel/cpu/mce/dev-mcelog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 03e51053592a..100fbeebdc72 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -67,7 +67,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
>  unlock:
>  	mutex_unlock(&mce_chrdev_read_mutex);
>  
> -	mce->kflags |= MCE_HANDLED_MCELOG;
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		mce->kflags |= MCE_HANDLED_MCELOG;
> +
>  	return NOTIFY_OK;
>  }
>  
> -- 

This one is not related to your 1/2 so it sounds to me like I should
take this one now, independently?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
