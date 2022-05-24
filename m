Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB64C5323F7
	for <lists+linux-efi@lfdr.de>; Tue, 24 May 2022 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiEXHWQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 May 2022 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbiEXHWO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 May 2022 03:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9628668305
        for <linux-efi@vger.kernel.org>; Tue, 24 May 2022 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653376932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGpRKfeqQD5xtli8NfArxAht9/xTK9Q3vgrY1z7EGsQ=;
        b=DEJseGNuF0yW5doRvS1MQaLf7phx10Ia2OsmZZdGJWEW+gRNmImwHTMlioF6SW8N+8Y8Vb
        9g9915sFM8+BvWqkzx0SZ/7b3tzOY2qRXI/wM+95g3i3b6TWr0gKWBSrLhiV4OL9hQs0XC
        uPpujo9rfiLvwiQAutcbJBKGNQ7ndUU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-zqdILOVvPt-3YEYibRPplQ-1; Tue, 24 May 2022 03:22:11 -0400
X-MC-Unique: zqdILOVvPt-3YEYibRPplQ-1
Received: by mail-wr1-f70.google.com with SMTP id bv12-20020a0560001f0c00b0020e359b3852so4448026wrb.14
        for <linux-efi@vger.kernel.org>; Tue, 24 May 2022 00:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cGpRKfeqQD5xtli8NfArxAht9/xTK9Q3vgrY1z7EGsQ=;
        b=4TVb1DqghGC2f7siFuPccTSqvvCbkIqxEczztXA4ppE7fG9ueLgDRDVI2jgjQ6ygdJ
         zkaVBHxJJGtVow/fsaH9ob3iukrVRgVbK0ekkZIF5J3AkS0Sev54Is6tb8I1p7ZO7byc
         KRUNmVj2pzNyqQZLUi402cGcmvfEeuiL2gtTY1E7mQDjoews5GZIH2aDmtOu0nkC7oLR
         jJF3Q3dJStjPdUxMxDwPkf0RD7+u/qArbRksUMUQ+MuxjOVxv/CXm+bouUM+p3+IeEUD
         KW8WZJZpjWeq0a1NNO2uj00cpn8s5iHdFJkyyg4XtFQGKyB5Vk5xlpBaPJOEGdX0Hi53
         9oGw==
X-Gm-Message-State: AOAM532fuQ8d9iS3s814y9MUivWpaTB5d+kWKUNY4MDNxgwPeM2i/inv
        sghaLdT9FuXiELZZ8hBmV8JbZVJp+8WWW5hY53RWyaRIWOMKYdW1PhyCkh/Sob9eWeaxpcioaDO
        iz+85VsqYkJE6GQxVAbZY
X-Received: by 2002:adf:f2cb:0:b0:20f:d291:7064 with SMTP id d11-20020adff2cb000000b0020fd2917064mr9675527wrp.319.1653376929867;
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmsxx6H53W1/fydQLyoNgRCIIqy+M82z+0WVSUrKl9Ph2oPwoPovgb6FKlTBu3g1EoNZa7g==
X-Received: by 2002:adf:f2cb:0:b0:20f:d291:7064 with SMTP id d11-20020adff2cb000000b0020fd2917064mr9675508wrp.319.1653376929652;
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b003973b9d0447sm1294064wmr.36.2022.05.24.00.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 00:22:09 -0700 (PDT)
Message-ID: <f8a95dcd-4a9f-ddd2-b322-96720f666b37@redhat.com>
Date:   Tue, 24 May 2022 09:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] efi: EFI_DISABLE_RUNTIME should depend on EFI
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c7ccee444dbc50a61a703cabeffe28e73de4cda7.1653375268.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Geert,

On 5/24/22 08:54, Geert Uytterhoeven wrote:
> The EFI_DISABLE_RUNTIME config option controls the use of Extensible
> Firmware Interface (EFI) runtime services, which matters only if EFI
> support is enabled.
>

Indeed. Sorry for forgetting that dependency when adding the symbol.
 
> Hence add a dependency on EFI, to prevent asking the user about this
> control knob when configuring a kernel with EFI support.
>

I think you wanted to write here "without EFI support" ?
 
> Fixes: a031651ff2144a3d ("efi: Allow to enable EFI runtime services by default on RT")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

