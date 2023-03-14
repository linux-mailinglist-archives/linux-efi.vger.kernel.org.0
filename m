Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842656B9B9E
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 17:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCNQdu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCNQdq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 12:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFD88EF0
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678811556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ENuFieBhxiHtLNw0jCbF63V+Z/gQ5SLpJHpUyZoTfIU=;
        b=Xdojz2MAojHH0owFC2nMyCSvX5sBSQKp46fdfnwgWWN4mgk/i0ax8NNRVdPD6XdkYaBHK4
        DQvOwQnWUcgBDFHiTWSDaiJ+19nt6ezRp5JbEycGhGkQfXC1uRSACwlKBxGO5J5Xm+0Q10
        mVs0BAtBrqLfoThwTao+FwMVSvpeGUw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-kqcYTfUYM8KF_086e7Pz4w-1; Tue, 14 Mar 2023 12:32:35 -0400
X-MC-Unique: kqcYTfUYM8KF_086e7Pz4w-1
Received: by mail-wr1-f72.google.com with SMTP id r14-20020a0560001b8e00b002cdb76f7e80so2818198wru.19
        for <linux-efi@vger.kernel.org>; Tue, 14 Mar 2023 09:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811554;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENuFieBhxiHtLNw0jCbF63V+Z/gQ5SLpJHpUyZoTfIU=;
        b=Ut/dDBURbznSP5XL8aaDCmCBwLlLPh0nOjIJOsgt7eeXQ+mQ+9n5qrpoVhSEEg3m4Q
         466fBZw9JA9oLijYT438KQxLEIC2xpkMqpN/H9t5de8OcZiyqywpwufQVc2R08viXf8a
         4RVAMdH6KhkrrBA+JrHXUxVTWrANiWoZYuzATVw59ZPBObAshcCm9O+FJRyGgiwj8kDP
         OwvwyJdXM95tdgRtM6A6VvMwFvrUuk4ddHkjnuCcXsa+r43MDYsAZVmiABSU/C2HAi1Z
         cyW5v6wMtE4vqGBYIeYsJ96cz+wC8EjV/nUn4jjRGcrcfDxw71hbKO+kT8Gzf4hUjW42
         JWHg==
X-Gm-Message-State: AO0yUKVX8r8GEfwvFh5ckbWlmnv9Es1vei5S8T0TXCwzH0CVDArPqDKX
        uk5sM8D1X0k80VPELZ6wU/JOOfUFXPtDEIMM6R+yMuqpYw575Uovm/Q5VIvE9rvF7rKHo90NRun
        1KSQcVwqslqqIuBVO7QmG
X-Received: by 2002:a05:600c:3b99:b0:3ed:234d:b0c0 with SMTP id n25-20020a05600c3b9900b003ed234db0c0mr7627210wms.13.1678811553861;
        Tue, 14 Mar 2023 09:32:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set83ZCHUGW/upSbL2NTJtL0Ht3VQsjtWJkbu2JlZJDbSTbrLj6MLNQ2M53zNysaSVXtrIug+Bw==
X-Received: by 2002:a05:600c:3b99:b0:3ed:234d:b0c0 with SMTP id n25-20020a05600c3b9900b003ed234db0c0mr7627193wms.13.1678811553599;
        Tue, 14 Mar 2023 09:32:33 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l17-20020a7bc351000000b003e21f959453sm3258953wmj.32.2023.03.14.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:32:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] efi: sysfb_efi: Fix DMI quirks not working for
 simpledrm
In-Reply-To: <20230314123103.522115-1-hdegoede@redhat.com>
References: <20230314123103.522115-1-hdegoede@redhat.com>
Date:   Tue, 14 Mar 2023 17:32:32 +0100
Message-ID: <87fsa7l2e7.fsf@minerva.mail-host-address-is-not-set>
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

Hello Hans,

> Commit 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup
> for all arches") moved the sysfb_apply_efi_quirks() call in sysfb_init()
> from before the [sysfb_]parse_mode() call to after it.
> But sysfb_apply_efi_quirks() modifies the global screen_info struct which
> [sysfb_]parse_mode() parses, so doing it later is too late.
>
> This has broken all DMI based quirks for correcting wrong firmware efifb
> settings when simpledrm is used.
>

Indeed... sorry for missing this.

> To fix this move the sysfb_apply_efi_quirks() call back to its old place
> and split the new setup of the efifb_fwnode (which requires
> the platform_device) into its own function and call that at
> the place of the moved sysfb_apply_efi_quirks(pd) calls.
>
> Fixes: 8633ef82f101 ("drivers/firmware: consolidate EFI framebuffer setup for all arches")
> Cc: stable@vger.kernel.org
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

