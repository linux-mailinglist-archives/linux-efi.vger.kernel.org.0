Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D70747EE9
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jul 2023 10:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGEID2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jul 2023 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjGEID1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jul 2023 04:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D2A19A1
        for <linux-efi@vger.kernel.org>; Wed,  5 Jul 2023 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688544153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDgcQtPSCk85F9YjOuVpAuyCl327gSG/7+9nyPHiobU=;
        b=ZzTxsnipfyFCU3irf8IadCie5h1SDiU8rvciTFHc5XbnR0JRYkR1lmRaIzL424MjhLm+5K
        7NhA/kGVC1WRpOV+ujvxUWkP/NllTOFWiC5JjlTSdP4GB53KzdmreNfIj1ATkyKjo7Rjnr
        c57dtYgDobMG3kcI6k9q4eP7DCeNDPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Vy92I7M9Pse9ofabia3FJQ-1; Wed, 05 Jul 2023 04:02:30 -0400
X-MC-Unique: Vy92I7M9Pse9ofabia3FJQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so37826875e9.3
        for <linux-efi@vger.kernel.org>; Wed, 05 Jul 2023 01:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688544149; x=1691136149;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDgcQtPSCk85F9YjOuVpAuyCl327gSG/7+9nyPHiobU=;
        b=E0v2e9bvuTvoW+Q9vO2xYAWp2j5B/AnAJAihFxgKsVi0M6z3UU91HvLkzbNJn+iQI/
         rKmCy4+ahiOGEg5ZEN60Pi8gGKyw86DvZzekvHB/hH+BRBOl+nRUhcnm6ymAMmpBCYwS
         jT33PbjJh/96ao9pkYjhpbVHhOQbDdZM3/ko9lTWl7uVvH0NHev9++JtntHAAvn8tcVg
         mIO1ppALKXE5C0t4sj55VHpTRylBwPYqg/UJSV4+DmCr9A0TZnymMVFmBXqgTiZ84JsU
         qmbhcV9KLlGgUxy3e2bggm7RzNZZBHZ6I246q3N7yWPSC3p7x3TgUr7sAjEmKlbzmv/l
         S6sQ==
X-Gm-Message-State: AC+VfDynE7s2d0IJm05SoWRoLkWPYArEX7cxi/IgWzZOtvJvKBv+2ub8
        ei2CvFTZN9aUtPgsjCBBpmMpTkL23iE4r32d/x8xcUJu2wLxYaJFEXD/sfj4oQ1cV6td6eblSoH
        o3B1Mg9pj6HnvGOLztLL+
X-Received: by 2002:a05:600c:b54:b0:3f5:ffe3:46a7 with SMTP id k20-20020a05600c0b5400b003f5ffe346a7mr12254775wmr.9.1688544149339;
        Wed, 05 Jul 2023 01:02:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vylDlXvfuU9EWjWb12pZMcRCpkOIK+1WjIMZRSIYzVmT0WCKJ1Gd1jMG8KQnYrrWHnxleng==
X-Received: by 2002:a05:600c:b54:b0:3f5:ffe3:46a7 with SMTP id k20-20020a05600c0b5400b003f5ffe346a7mr12254706wmr.9.1688544148234;
        Wed, 05 Jul 2023 01:02:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d4908000000b0031432c2fb95sm8956824wrq.88.2023.07.05.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:02:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-csky@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Maik Broemme <mbroemme@libmpq.org>, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/12] fbdev/core: Use fb_is_primary_device() in
 fb_firmware_edid()
In-Reply-To: <20230629121952.10559-11-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-11-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 10:02:27 +0200
Message-ID: <878rbuss4s.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Detect the primary VGA device with fb_is_primary_device() in the
> implementation of fb_firmware_edid(). Remove the existing code.
>

An explanation about why this is possible would be useful here.

> Adapt the function to receive an instance of struct fb_info and
> update all callers.
>

[...]

> -const unsigned char *fb_firmware_edid(struct device *device)
> +const unsigned char *fb_firmware_edid(struct fb_info *info)
>  {
> -	struct pci_dev *dev = NULL;
> -	struct resource *res = NULL;
>  	unsigned char *edid = NULL;
>  
> -	if (device)
> -		dev = to_pci_dev(device);
> -
> -	if (dev)
> -		res = &dev->resource[PCI_ROM_RESOURCE];
> -
> -	if (res && res->flags & IORESOURCE_ROM_SHADOW)

This open codes what used to be the fb_is_primary_device() logic before
commit 5ca1479cd35d ("fbdev: Simplify fb_is_primary_device for x86").
But now after that commit there is functional change since the ROM
shadowing check would be dropped.

I believe that's OK and Sima explains in their commit message that
vga_default_device() should be enough and the check is redundant.

Still, I think that this change should be documented in your commit
message. 

With that change,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

