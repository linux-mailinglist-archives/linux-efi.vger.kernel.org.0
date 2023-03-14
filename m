Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EA6B9BAE
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCNQfM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCNQes (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 12:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B542B9CF
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678811616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6jx+Feqw4PpEh8ZADrPDT989RAtGEM/tJSACFWTn+c=;
        b=IGekfNUSMv4z0a7naUxZRq3KUUQclhHki50MRZDmKjTtYeiCV8NTgVXlJwfZrVIcVW04bY
        ky6Gl/OjKOxTfBTVihdiB3PMg0nNTrXFwa7lWL3YdyrwrOYrqekTTMvPYJ/yhmj8Td1SvV
        HpVOAjqTxQviIQhWFnFOLkhBKMYnYNI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-2e6wGciuMLyHdq8GGEbGKw-1; Tue, 14 Mar 2023 12:33:34 -0400
X-MC-Unique: 2e6wGciuMLyHdq8GGEbGKw-1
Received: by mail-wr1-f70.google.com with SMTP id o15-20020a05600002cf00b002c54a27803cso2838001wry.22
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 09:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811613;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6jx+Feqw4PpEh8ZADrPDT989RAtGEM/tJSACFWTn+c=;
        b=tehTpVA64HSggHoDjOHog4S9xAGEUEgxN+yDZqs3Tz9gpGnm0hF3P3PdIYrxSdl7Sz
         FUHH08k1zX4Ip9DLG913tntoYqH1kjVJXduWfsud5x00gU7Bspis7sHaW7Gf4DzoPVzS
         ETKdEYMaM9aRYT3fRTNY85sDr4fyAJGXmNXVWZDBtMdo+X9n3UncW2gzkbYtnSc6mb2E
         nsvuWHo5H64CHped97U7FOs+mpwNIZ3KgaH7gZtIbZUHiDEZ7Bcv84Ju/29BPVfuw+Zj
         m2wOWQ5XWqHBgNny+hR84+0CiV1f6VhBN2aDL3v0RRul+Q61y+j3H/D1GGTTN83M/4YD
         87KQ==
X-Gm-Message-State: AO0yUKX7+fhbhioWzS53ScRnicpbQvm/MAXw1BespMGt+2z4Z3iMNVee
        6ld0h9biY1gOkABKFZiSg6g5JNhCed1aNn3RNpaQSczVQBjt9MkDJfIs3VioOqYBCRjRk18Cc8r
        qRdnRiYvWy23zoOAoWZ5P
X-Received: by 2002:adf:ef90:0:b0:2c5:a38f:ca31 with SMTP id d16-20020adfef90000000b002c5a38fca31mr11713957wro.7.1678811613666;
        Tue, 14 Mar 2023 09:33:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set++uHkeAYXjqua7szeU0r2S7/mqUy9hOKGwihSFQIHr3gcVZoG44qG6bwmWO8OKV4iHu3r1Nw==
X-Received: by 2002:adf:ef90:0:b0:2c5:a38f:ca31 with SMTP id d16-20020adfef90000000b002c5a38fca31mr11713939wro.7.1678811613397;
        Tue, 14 Mar 2023 09:33:33 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b002c8476dde7asm2474740wrt.114.2023.03.14.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:33:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 2/2] efi: sysfb_efi: Add quirk for Lenovo Yoga Book X91F/L
In-Reply-To: <20230314123103.522115-2-hdegoede@redhat.com>
References: <20230314123103.522115-1-hdegoede@redhat.com>
 <20230314123103.522115-2-hdegoede@redhat.com>
Date:   Tue, 14 Mar 2023 17:33:32 +0100
Message-ID: <87cz5bl2cj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Another Lenovo convertable which reports a landscape resolution of
> 1920x1200 with a pitch of (1920 * 4) bytes, while the actual framebuffer
> has a resolution of 1200x1920 with a pitch of (1200 * 4) bytes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

