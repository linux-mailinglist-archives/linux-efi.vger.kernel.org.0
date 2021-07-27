Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55213D70A0
	for <lists+linux-efi@lfdr.de>; Tue, 27 Jul 2021 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhG0Hya (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Jul 2021 03:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235887AbhG0Hy2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Jul 2021 03:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627372468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msI4RjMytbP1n7F7yoVvayHHN7FThjzPJmiZOR0CDww=;
        b=HiioyW9V6mNgQmyq04TOLuK6VP7ciAjFusqxRaOJwMO7a4AzEev1cVj7scPOA74AS07e6z
        OJVCJj30tt1bB99HOsPBUgVtvvCF7YW8a41E9P/llhxeFIS4t3kuow2iq7NfvUZpLPOMYo
        GqKIfzcSe5Az0lYScURYQY3aSNFlHxI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-zsVspqspM62tOJIndSXY4A-1; Tue, 27 Jul 2021 03:54:27 -0400
X-MC-Unique: zsVspqspM62tOJIndSXY4A-1
Received: by mail-wm1-f69.google.com with SMTP id o32-20020a05600c5120b0290225ef65c35dso383305wms.2
        for <linux-efi@vger.kernel.org>; Tue, 27 Jul 2021 00:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msI4RjMytbP1n7F7yoVvayHHN7FThjzPJmiZOR0CDww=;
        b=Ioppq82dfyK24geIFuDv8LJhryCY47CAGLUrylUyoINQlFQch+y3GqBV0maLDXqBIl
         gaSE/w5gTqBadbu3fwxvfcCtpdZ1h590KzF22S6VzzwiNVmxwnk0GKyuqBGxj1jduCxg
         Izge+Btf2b48VQNZp01cKnl7c0BRG1KMUcVqF+znlDJtwDuZtyvBVHYE3cxBIprORBo5
         xfpnZjpUxHAtjAUO/qymRfQ8nTNk5oasp/1rxVNFeIgqKCFFoLW4FUzy8VsmDcyHT6Qf
         2VLh4UrX1Da6OFr5ixKT/uXAH0oHY60+UBdfzGhPznFhjAv3nkFpNkVoz/K15q1VF23i
         HZOg==
X-Gm-Message-State: AOAM530sBVUJg8/a7Z/BiwRpJt99rkNhtYkoC0uyk1vmeQQK1mdlUjJY
        bCyqUtFcF6bTKRya/X5nwu8rb1jR9zprfqrn3tARKzexRPNVGo5GuWoaSTqXPfVuqIKCuOq0sp6
        en+FwrnB3W2g+GPxIyTk1
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr2750543wmb.5.1627372465941;
        Tue, 27 Jul 2021 00:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxs3kNtwhKpPWdmwpsLv1on90CJ6AInc7UOF2HuXnQYNpNtZo7URlKNGEOuIDGFM2r1G3RPMg==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr2750536wmb.5.1627372465738;
        Tue, 27 Jul 2021 00:54:25 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id p22sm1716714wmq.44.2021.07.27.00.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 00:54:25 -0700 (PDT)
Subject: Re: [PATCH] efi: sysfb_efi: fix build when EFI is not set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>, linux-next@vger.kernel.org
References: <20210727050447.7339-1-rdunlap@infradead.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <9aa81fd9-359d-fc30-2969-50b8c7677f9f@redhat.com>
Date:   Tue, 27 Jul 2021 09:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727050447.7339-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/27/21 7:04 AM, Randy Dunlap wrote:
> When # CONFIG_EFI is not set, there are 2 definitions of
> sysfb_apply_efi_quirks(). The stub from sysfb.h should be used
> and the __init function from sysfb_efi.c should not be used.
> 
> ../drivers/firmware/efi/sysfb_efi.c:337:13: error: redefinition of ‘sysfb_apply_efi_quirks’
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
>              ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/firmware/efi/sysfb_efi.c:26:0:
> ../include/linux/sysfb.h:65:20: note: previous definition of ‘sysfb_apply_efi_quirks’ was here
>  static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
>                     ^~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-next@vger.kernel.org
> ---
>  drivers/firmware/efi/sysfb_efi.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linext-20210726.orig/drivers/firmware/efi/sysfb_efi.c
> +++ linext-20210726/drivers/firmware/efi/sysfb_efi.c
> @@ -332,6 +332,7 @@ static const struct fwnode_operations ef
>  	.add_links = efifb_add_links,
>  };
>  
> +#ifdef CONFIG_EFI
>  static struct fwnode_handle efifb_fwnode;
>  
>  __init void sysfb_apply_efi_quirks(struct platform_device *pd)
> @@ -354,3 +355,4 @@ __init void sysfb_apply_efi_quirks(struc
>  		pd->dev.fwnode = &efifb_fwnode;
>  	}
>  }
> +#endif
> 

Thanks for the patch.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

