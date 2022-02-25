Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D44C513B
	for <lists+linux-efi@lfdr.de>; Fri, 25 Feb 2022 23:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiBYWKG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Feb 2022 17:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiBYWKF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Feb 2022 17:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2D84522D9
        for <linux-efi@vger.kernel.org>; Fri, 25 Feb 2022 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645826971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=SAXQnjTffBrkkXf84yXpQyobBf4trw+3AsaNsGw25gSPMtlAUJPCqhp5OxbNrxqJbjRxV9
        PAlouiSbsFde+PKZ0QF7zbVUA+wrcGdrTLxQTrfkzIE3ZeBrGTblDsI0aIbnul2mN5o4GR
        lvLvgVcH5f2Szi6qGFyTstJD7QCnAwc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-UEal6pMXNRS1WR-XgS_fwg-1; Fri, 25 Feb 2022 17:09:30 -0500
X-MC-Unique: UEal6pMXNRS1WR-XgS_fwg-1
Received: by mail-wm1-f71.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so1190940wmb.1
        for <linux-efi@vger.kernel.org>; Fri, 25 Feb 2022 14:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=2dRoqPhZfpNFPt32Mz39g1FSFQKnHNTo21NtoYxCU0XuhG4T8CUYGWsxah8TAxZk8I
         2n+1LyLu6S/E3/c9IshVnP7/rx6ZdtU9Acgb0bVto0klyMJv3x+aXDt0uvcGA+I3Wwut
         rpILWGB9yceCjf0IASRlXE/y9RRFToZaa3iW/5SRwTpv56CIBoSB8xqrgqE2jzPE7xYz
         gRDL3DsaWygUjZDagvWYPOxaJZ7KcQljKfKyWkz1dB0mze3kf5FK1Q6sqsrMkfWWmXNW
         XHcEzpkMLJcH3XV6ykKeTyOMQRhuUYItWaYqNCma1r1eng2zuK99mLIYgiFVEfpCVpm3
         Lr2w==
X-Gm-Message-State: AOAM530bhKPypo4YMk0QQ1OqiKwqob4UMNXYGzNTtvHzVfyT29Bdrvum
        yxi/AoPXfXXHwGyFRu8Ts7v3cRJ3Qgd/zHoGD+FWxrqPGvtp+bLQ+IrD63cAUjqOB4KplSZ/jyx
        ZtRHibJkvs/eeL3u9Mr1j
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329865wmq.20.1645826969212;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRz8kqXC26lmDuZDgPn8lbcKVBuJ71tDPuJGSpWOnTZ7pH1GMfhj1Tg6aY60ZvqiZQtVKhzw==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329851wmq.20.1645826969002;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0037df2e5d8c9sm4311870wmg.27.2022.02.25.14.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:09:28 -0800 (PST)
Message-ID: <b87cf8eb-a27f-5060-7941-3b374c2792dd@redhat.com>
Date:   Fri, 25 Feb 2022 23:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/3] sysfb: Make config option dependencies explicit
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Michal,

On 2/25/22 21:51, Michal Suchanek wrote:
> efifb and vesafb requires sysfb implicitly but this is not stated in
> Kconfig. Add the dependency.
> 
> With that all drivers that require sysfb depend on it so it can default
> to disabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

Thanks for the patch. This makes much more sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

