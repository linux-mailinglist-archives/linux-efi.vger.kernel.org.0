Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93373C756F
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jul 2021 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGMRCs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Jul 2021 13:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbhGMRCq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Jul 2021 13:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626195596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTHdlYNv/a9BuVPGjnPy+dQ/mQjufPe+yKG6ndLoXU8=;
        b=eX0vNDQetw4M4XvuzdRcpzZcTe4FtS5+xgrR+G5VXPhCmc0t0q/NkkDd+By1EFfppUZwyA
        j+0h4jpvRagFIp8303DxtzUj1YkYvw13WZsOOQGn4Jl4jrLAfIy0ZKR3eZwWWbnZr4HAVg
        wN0h7kqIAlJJ8TlEVQGTw3NU2rn9dCk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-A_zWNZF6OmuQmdBkUF4UIQ-1; Tue, 13 Jul 2021 12:59:55 -0400
X-MC-Unique: A_zWNZF6OmuQmdBkUF4UIQ-1
Received: by mail-wr1-f70.google.com with SMTP id 5-20020a0560001565b029013fe432d176so2670451wrz.23
        for <linux-efi@vger.kernel.org>; Tue, 13 Jul 2021 09:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XTHdlYNv/a9BuVPGjnPy+dQ/mQjufPe+yKG6ndLoXU8=;
        b=O6ogds3h1j7OPZ9T0rL4TggTNFRVqevzSP+aTs/nNnnpBSpmbUAF2ONwBRoj/5Klvm
         1X2VyB4afghCTLoVvRIl403XbIsYCxr9gHLJJxsOd7KaKlmuA9cenRx6JytHZdMGPAGf
         nw7Mci552g0vR20cY55lJNgc1/fX5Fe3drilFbQFspWl6VbRW5HdEj/8jn6gO7VLy0v9
         9OnE3O8mWE9UuFEz8hiXgqAmoNLicrd+ZFJCOqqdpx5qOFplAqq7PWieLE6FmFUSQwAe
         Vx/ZsfAs0gycDAiJEz/OtAXlvDZR12QOUfCrk7O+xAGb7rNjFqQcKgmMei/Z1bVN7Yvh
         97Kw==
X-Gm-Message-State: AOAM531a7uqe2gE/99gpVYA4qpCx7DjOysXGGkWsozJEv8l+rBo6u7Kv
        OX1Df0KPxPSwSlXxI88Uv1Mcyi/ISs8qUdKhIRoraZcdurklFCtpxmWyqPrbsuojYdEPZZU/UL9
        4+PByhEJaf9irmqPekFJI
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr1986028wml.18.1626195593924;
        Tue, 13 Jul 2021 09:59:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxumMUPdgM1d9aW8ug3rd8W69QVL7ebCKDjq/l4syiEd2xfO/CLyenHYKdqhxzMxt12Uge4rQ==
X-Received: by 2002:a05:600c:2105:: with SMTP id u5mr1986010wml.18.1626195593743;
        Tue, 13 Jul 2021 09:59:53 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o28sm19766410wra.71.2021.07.13.09.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 09:59:53 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] allow simple{fb,drm} drivers to be used on non-x86
 EFI platforms
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Borislav Petkov <bp@suse.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>
References: <20210625130947.1803678-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <e61cf77c-6bff-dfcc-d3df-2fb6b48e5897@redhat.com>
Date:   Tue, 13 Jul 2021 18:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625130947.1803678-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/25/21 3:09 PM, Javier Martinez Canillas wrote:
> The simplefb and simpledrm drivers match against a "simple-framebuffer"
> device, but for aarch64 this is only registered when using Device Trees
> and there's a node with a "simple-framebuffer" compatible string.
> 
> There is no code to register a "simple-framebuffer" platform device when
> using EFI instead. In fact, the only platform device that's registered in
> this case is an "efi-framebuffer", which means that the efifb driver is
> the only driver supported to have an early console with EFI on aarch64.
> 
> The x86 architecture platform has a Generic System Framebuffers (sysfb)
> support, that register a system frambuffer platform device. It either
> registers a "simple-framebuffer" for the simple{fb,drm} drivers or legacy
> VGA/EFI FB devices for the vgafb/efifb drivers.
> 
> The sysfb is generic enough to be reused by other architectures and can be
> moved out of the arch/x86 directory to drivers/firmware, allowing the EFI
> logic used by non-x86 architectures to be folded into sysfb as well.
> 

Any more comments on this series? It would be nice for this to land so the
simpledrm driver could be used on aarch64 EFI systems as well.

The patches have already been acked by x86 and DRM folks.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering

