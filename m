Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55253CC82
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jun 2022 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbiFCPpZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jun 2022 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiFCPpY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jun 2022 11:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5D7B2FFC2
        for <linux-efi@vger.kernel.org>; Fri,  3 Jun 2022 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654271121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFLK6p9itw+Shyl/XdOc3FeAWZox0NqEZ3BO5A44W9E=;
        b=Q63G41SNBrjoUhh/YZEcd/pF63onHqX/+bcsA+y3yFmpWIOXh640laGnXawXkby0OUL3+k
        o9LypOm/qGpZpb5tf/iqzVZb1grMaw1XECDBsBtKYecSOBKZI+eugzuR/3C5EfQEed46Ui
        9dMgo/4zN1oE9tq9rwFFEVH67k9UElE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-xPdQ21NtNYCvjT7x4Mbtqg-1; Fri, 03 Jun 2022 11:45:20 -0400
X-MC-Unique: xPdQ21NtNYCvjT7x4Mbtqg-1
Received: by mail-wm1-f72.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so3729809wmb.3
        for <linux-efi@vger.kernel.org>; Fri, 03 Jun 2022 08:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gFLK6p9itw+Shyl/XdOc3FeAWZox0NqEZ3BO5A44W9E=;
        b=KXnZjWISfB+ovNQ7rGF00V6+cL0fKzlNG+TMtw9qucEtdK8DdbWGNpma/bumUWTSnm
         blluRJNYm46qQWYMcmqil4S7bkTTb+Nc/esN3nf1h+Nm2ul8LHav+IPWN75mHqNLRMmw
         13dKTNA/58Lt+iI8eOjsTJMO2tQQmKed1poejTzbnbqSbDF2ODgkGjlE6PHrFZozAfo9
         40WYX+bFdqZRFeUwYTHUTL/jzbocPRDYaqsCU6VN+6I0olzN5BJoyfclmAksgUTqR3aK
         Jf0yNSKxW3Vo/PniqBXo6P4+bn/dPBbx72GS6PsxUHan1ELxn7fbcXmhxY1y5WeFMAMO
         xIDQ==
X-Gm-Message-State: AOAM533zxazGZFmqWP9/io+F/rDZrQ0ZE6L3oAw9CYCUuH6o+a1usg9r
        4xn+LVUJK1HFmnU1Bxj/x7SygERSUvreo6lZQeweTCYl6UdaOdS0W1wWoPiv8MOOaUMQ/uU/jTT
        GiccYft5wpuoSvWXouUQa
X-Received: by 2002:a5d:638b:0:b0:20f:c623:2597 with SMTP id p11-20020a5d638b000000b0020fc6232597mr8420983wru.271.1654271118813;
        Fri, 03 Jun 2022 08:45:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzko71vSLQmcFQDLwPq78I4FGYZ9j1hNTg2oD274MhjXeQdpP+ysWS+Fa36CAyhZ+sQYs7M+w==
X-Received: by 2002:a5d:638b:0:b0:20f:c623:2597 with SMTP id p11-20020a5d638b000000b0020fc6232597mr8420961wru.271.1654271118499;
        Fri, 03 Jun 2022 08:45:18 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b00397122e63b6sm9524731wms.29.2022.06.03.08.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 08:45:18 -0700 (PDT)
Message-ID: <fbf8b218-742b-c334-3ade-2a7388f07036@redhat.com>
Date:   Fri, 3 Jun 2022 17:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] efi: clean up Kconfig dependencies on CONFIG_EFI
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220528095540.2002868-1-ardb@kernel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220528095540.2002868-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard,

On 5/28/22 11:55, Ard Biesheuvel wrote:
> Geert reports that the new option CONFIG_EFI_DISABLE_RUNTIME is user
> visible even when EFI support is disabled, which is unnecessary and
> clutters the Kconfig interface.
> 
> So let's move this option into the existing Kconfig submenu that already
> depends on CONFIG_EFI, and while at it, give some other options the same
> treatment.
> 
> Also clean up a small wart where the efi/ subdirectory is listed twice.
> Let's just list it unconditionally so that both EFI and UEFI_CPER based
> pieces will be built independently (the latter only depends on the
> former on !X86)
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---

This makes sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

