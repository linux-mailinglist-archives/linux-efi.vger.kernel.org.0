Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D20656E49
	for <lists+linux-efi@lfdr.de>; Tue, 27 Dec 2022 20:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiL0TYr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Dec 2022 14:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiL0TY0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Dec 2022 14:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260255BF
        for <linux-efi@vger.kernel.org>; Tue, 27 Dec 2022 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672169017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7dbgHTngiyfazSG5sXwLfx+o+WyMctqSvzgKNLu/LU=;
        b=IQV9Fuuul5Z8ac5uulmDE7uffz1hNgOi7VQuq+g4+Wh4PKmFTPPy82nVgGmZ0ui8myUbw2
        21T1WGVJ1QnczchNkKe1tnAXczmA/4ITbZQgPdsMHKhcd/+lirybrI9QVAaFHFPFX4uYwo
        xuGp/V9mtJKj/fIm8USHpA7CSuhTJD8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-TYNzPdi7N4yGTQxInTwJHA-1; Tue, 27 Dec 2022 14:23:35 -0500
X-MC-Unique: TYNzPdi7N4yGTQxInTwJHA-1
Received: by mail-wr1-f70.google.com with SMTP id t18-20020adfa2d2000000b00277e6c6f275so779003wra.0
        for <linux-efi@vger.kernel.org>; Tue, 27 Dec 2022 11:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7dbgHTngiyfazSG5sXwLfx+o+WyMctqSvzgKNLu/LU=;
        b=cHiUAKnX7m1UmbIZ0FHMJVZiQmQrVJ0Dkx0GLhuAf7bBwqu9CjbJUOQ0Cm2s/wwLIq
         ia/4Ylzr3XQbGZtuV3DeIgxvQZQFGW1NCd6ASdsLpUm2KuWA79i8SpvdGGeWypjAFwVe
         nkYfcHrRGlTHAryt6XAmVNkfB8LyX4LfBeetaBO3iRIWMvCUgv7BH3V/PiOu95ERLrm+
         dn1isBrsEvvyukrlnnIPkaVG9vmlOxpDQpSd9JtjmatixVFRq5IdNM/fonzOCD7ayVAo
         2WcDgFkTSH3Tw5B4XNd8tcbOm88mdPDMab1PEB96DRC1EsNSGxjdfsTmrFftVDTMJAYj
         lIAA==
X-Gm-Message-State: AFqh2kr7jTBRqFpoPVsXv+Esm2Ko9JvosqtovG2mD2dYGd6LLktLFl5O
        DaVgVMx+PXQqHSq0VaGhyHLcV8L5UmezOcLyzMkyK0BTrlr5jTEZHkIhkvWk+HKIKeEmbyP3kNb
        2/L3qOiH3kx4J03uM4XdO
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id n16-20020a05600c3b9000b003d1f0f1ceb4mr16025409wms.19.1672169014395;
        Tue, 27 Dec 2022 11:23:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXva0B2UHKhAop8zDawG+uzkPkYfVViqdOdvS3DOeaUVR1+zQGk160j5uLhQYZ6Be0X+v85V8g==
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id n16-20020a05600c3b9000b003d1f0f1ceb4mr16025401wms.19.1672169014169;
        Tue, 27 Dec 2022 11:23:34 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q20-20020a1ce914000000b003b4935f04a4sm21286147wmc.5.2022.12.27.11.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 11:23:33 -0800 (PST)
Message-ID: <9911d249-ccc0-7724-b0bc-17bcf2a524e8@redhat.com>
Date:   Tue, 27 Dec 2022 20:23:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-efi@vger.kernel.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20221222183012.1046-1-mario.limonciello@amd.com>
 <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
 <f9b40837-ee2b-76fb-0ec1-d7dfda4ffb7e@amd.com>
 <CADnq5_M42GQhVquw5BM+P-6NKmdZ6yj8czq=s5iXVAmVOexAkw@mail.gmail.com>
 <CADnq5_OLf3VhFZm7=riDm9ezVT9j9nQ5Fwei3budnqPt5C4t9Q@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CADnq5_OLf3VhFZm7=riDm9ezVT9j9nQ5Fwei3budnqPt5C4t9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Alex,

On 12/27/22 18:04, Alex Deucher wrote:

[...]

> 
> I think something like this would do the trick:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2017b3466612..45aee27ab6b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2141,6 +2141,11 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>                 break;
>         }
> 
> +       /* Get rid of things like offb */
> +       r = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
> +       if (r)
> +               return r;
> +
>         if (amdgpu_has_atpx() &&
>             (amdgpu_is_atpx_hybrid() ||
>              amdgpu_has_atpx_dgpu_power_cntl()) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b8cfa48fb296..4e74d7abc3c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2123,11 +2123,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         }
>  #endif
> 
> -       /* Get rid of things like offb */
> -       ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev,
> &amdgpu_kms_driver);
> -       if (ret)
> -               return ret;
> -

I'm not familiar with the amdgpu driver but yes, something like that
is what I had in mind.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

