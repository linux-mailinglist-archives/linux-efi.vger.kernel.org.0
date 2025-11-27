Return-Path: <linux-efi+bounces-5706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E852CC8C870
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 02:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5E7D353614
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D826248F51;
	Thu, 27 Nov 2025 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JMxRlQgq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1B1DFD96
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206302; cv=none; b=kgqea4KXuqCCiKs4ivwIII03I9dVVR3vnKwt5SH3q2wz38aGuvziAU6R9aXsOdaLaEBKr5g+QdULwX7Mw4OYhN9CBbskmlciKKm4kbrCH/hOutrXDFZwj4iOIeB4BsgE1cT4n9nWifsdkA4AqIxADPMAbUuWlYblwOE4FJRxCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206302; c=relaxed/simple;
	bh=GQVRD0kDLnRr8PlGCc+5Hnmo5Omwya0ZZMgiPEA57KI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBXojqgzhpGTwhi7GiFeYFoKGkXk2a1gkwnpdi5dbJzftA+o0KUqgNi3yxJN2tDgj+AX66jJVxSvb/DbLSHE9GTUNM5TE4eFrsR4TNJnwHBhbGDwOKwtZu8X9fGaeUT4u6xet/8JJqHShaGano5137VuPWUiXVYIcvBL/gTDKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JMxRlQgq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so1820535e9.0
        for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764206298; x=1764811098; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=JMxRlQgqJV81zARc+UmZ8Yx75jfyYOkeJj/362TMiAkwyKCfIpRWooE0QbExftrBnR
         n0kFaOP4QWjIP9jfTFiTg6NkGeqGWUUknZNkkbp+9CZel31jLfMgrTI93NqSCj2MbPnn
         SZ180e9rEn4C+M3cnexGEmWUES+B0xf223fHxCH6GuyS7ctvUBQuHv0RK99GQc+wBxZZ
         H1tHOkNFIDdWdcLrboTrnFHjD99uMicQlGDWnm7lB8qBTnNzWoZBRqAw8LNmHoqX5h1i
         4pxspkoaEDCqv9Y2zuoK2qDR4/5Yv2M/d4ha7GCPpYUPyHx9tf9SNnS4jRaxIgyw9SZp
         h08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206298; x=1764811098;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKgOFooMWN6cAHuCEA8Jqj3i0BZ6TtQryqGYElbczIg=;
        b=n7p4UiT9P4eYFNwcYv+MCG7cddpBIwUy1ksR1d7QJWDj3VZ7agiT4RzUXnUhXtu6S6
         hNcjIZe3alyJqw7Pf9gaYHwIshODvcZXGisT0XtmsAQ2siP/NKf7EFZqDo1OGPrMJ0V5
         Xt4hvjs9RPKbYm2sUEecbUoOXTfVrH0l264yPbx8mXcqSVGlcGTokwTfvePrlgNO/a4q
         NovvIZ3yb6ikomHa/15CEDNyAncxk8Nm/brDBAuO3H1oGZfD8igWg9tYUNWK37TiL5ov
         +YzSCn6mSPfHVUEAyT1x269B6UiX7nue1fhvqR7fmZ+1rF6wDNDwZ9lFmqBxqcmrGmAQ
         uYaA==
X-Forwarded-Encrypted: i=1; AJvYcCW7LOpjYbvbYcp0NOmmBOe7H5LTlQzZJ0ZYCprXVjaUFi1nMPlgIXEu0iKooz04RfYpfrysHCetOUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmyxaM49FTLwQgBF5sQOgcbOyS5abpOT1Unq9IVSOTMPBJUYb
	+P+ujjFDeA/CbXJyEllDzCcqvxXUvAOxPbgt71lq7yIOytGBSrMwwUmHnJt9h0hiFWo=
X-Gm-Gg: ASbGnct9WmEl4un0MGSIe4E42zn/3XbwXGqnETwBbXnTNqRnRD0Ykf/b4cxw84apU+R
	wVi+mnyYDOeJlVlMRuOTwuJd+sfXArsM7KJR+Lm868nMWxHr5ybqtMa2WHCqyXQMFKbOBohpYxv
	hOREJ2M1ZR/6CjVqxlhTXt7qMLQt3zP2OAwwfqRLNvGMd6sA1mvGp+mpncusERSQFIU5suquntO
	+RegnY3liz8XEZL/PXTh41WUer62fao7XofG+HFVGmGI4t/R42AuSat2Rh+TqQqknYCtQqOCM75
	1ty5v8+cxx+e9+Fju9g392Rjj8A+csaBxKYbgpFFeUiLZVKtd7qgamujtJzh29uZj8+K5sRfrhf
	MqoAUbqL5vr9nPoG15Q7z55NNdSoyl8ENSivovpZLknlnTMzaSvsLulz83vK0KA4dKkUMRy47AG
	IsCuQazb40CKhuikY2tkusYo0U6y6tcBv+
X-Google-Smtp-Source: AGHT+IHKRsRzIcI/YdpyjCx/e6RWPSP3syqAgwQHcfAEZoMWkqQomccWOuW4YSvp5SYEElJFnjRGrw==
X-Received: by 2002:a05:600c:19ce:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47904b25e63mr87066215e9.30.1764206297510;
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
Received: from r1chard (1-169-246-18.dynamic-ip.hinet.net. [1.169.246.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075ddsm207261215ad.3.2025.11.26.17.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:18:17 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 27 Nov 2025 09:18:09 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de, helgaas@kernel.org
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/9] sysfb: Add struct sysfb_display_info
Message-ID: <aSem0a7jTfCNTdX-@r1chard>
References: <20251126160854.553077-1-tzimmermann@suse.de>
 <20251126160854.553077-4-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126160854.553077-4-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/26 17:03, Thomas Zimmermann wrote:
> Add struct sysfb_display_info to wrap display-related state. For now
> it contains only the screen's video mode. Later EDID will be added as
> well.
> 
> This struct will be helpful for passing display state to sysfb drivers
> or from the EFI stub library.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/sysfb.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index 8527a50a5290..8b37247528bf 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/err.h>
> +#include <linux/screen_info.h>
>  #include <linux/types.h>
>  
>  #include <linux/platform_data/simplefb.h>
> @@ -60,6 +61,10 @@ struct efifb_dmi_info {
>  	int flags;
>  };
>  
> +struct sysfb_display_info {
> +	struct screen_info screen;
> +};
> +
>  #ifdef CONFIG_SYSFB
>  
>  void sysfb_disable(struct device *dev);
> -- 
> 2.51.1
> 

