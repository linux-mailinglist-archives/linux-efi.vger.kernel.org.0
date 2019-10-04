Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33804CC665
	for <lists+linux-efi@lfdr.de>; Sat,  5 Oct 2019 01:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfJDXRi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Oct 2019 19:17:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37040 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfJDXRh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Oct 2019 19:17:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so2812149pgi.4;
        Fri, 04 Oct 2019 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N6lld3QVqJ8v+1IBZTT7yl5zFiTihenHGMLoJcSj8pc=;
        b=M2KIa1h3cLctN2IUIjhYHR3D5/YPSUOLWsOO+ubugv/OGi5dURuk/tPs38woAwqL+a
         R8WFcDve8wRIPrygkMRObUTaD5m/YF2oMtpoRH3Brtl8S2kCuGOQQpwCQBCCi2S8qyXO
         TKfcDOsQr522/TIKefYh8Jx0EG9dlYQqaLr9KJ59nBFuH7Gj1i3zRVCfToVQOUrlfLN8
         m2UJiITUfRxFfGP4hxMPeEVQL9QicvoeRtkW+WIFGZYD54Vr2WmwZaY94dDa+WfNj81M
         oIdtUeIvJuj/5WkpeUG4Ec56EyLle2fHaOeVdNqDXTSxMdF6GaXGoP8jeXr/ZQMw294Y
         IeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N6lld3QVqJ8v+1IBZTT7yl5zFiTihenHGMLoJcSj8pc=;
        b=IJipXFazBFQ8bCkWNJreoiglBbDqVl6yjrTg1y8ZLJZv/xaVjaHdUAY8uMj9/2T/hF
         8HQPP5bVujbqZSsSJp06EKEs4aHpfIhpiTFTjGqLmRJ8DRhs5vZ8rzogySUFUxUepxUk
         nxdYfGzMG92lXtpFyUacWHBgeawtk2d0Qtn6SyArv51UeKeQ/+3/L2qMDf9dGuDB32NW
         6cCV9hjthiH8Bdqsptn2j5R6duA897nmaEOteXCHPkoNWeWpNO+43XQXzJeLbWKcjTVb
         yYQk+NGty1mApNbfT+hnBrov94SxU6013/NBd97XGUtTqeET+hIsXjtFK2e/8pSNVkiQ
         1cKQ==
X-Gm-Message-State: APjAAAXrNe1ty8wBdtW49/85GC3Eu0Ftku7gKOR41/bmNBNAXGDTh6P5
        3EgSnRjzaT/WAKN+1lramJY=
X-Google-Smtp-Source: APXvYqzfju1b5POi3rNfttLsKtoz2qe/HVmRXl91wV/sbwVNPo/D9T4qmwes+Mp3fb1tIwUmmqiR4Q==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr20259144pjo.71.1570231056558;
        Fri, 04 Oct 2019 16:17:36 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p88sm8055120pjp.22.2019.10.04.16.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 16:17:35 -0700 (PDT)
Date:   Fri, 4 Oct 2019 16:17:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
Message-ID: <20191004231733.GF22365@dtor-ws>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-5-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Hans,

On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
> In some cases the platform's main firmware (e.g. the UEFI fw) may contain
> an embedded copy of device firmware which needs to be (re)loaded into the
> peripheral. Normally such firmware would be part of linux-firmware, but in
> some cases this is not feasible, for 2 reasons:
> 
> 1) The firmware is customized for a specific use-case of the chipset / use
> with a specific hardware model, so we cannot have a single firmware file
> for the chipset. E.g. touchscreen controller firmwares are compiled
> specifically for the hardware model they are used with, as they are
> calibrated for a specific model digitizer.
> 
> 2) Despite repeated attempts we have failed to get permission to
> redistribute the firmware. This is especially a problem with customized
> firmwares, these get created by the chip vendor for a specific ODM and the
> copyright may partially belong with the ODM, so the chip vendor cannot
> give a blanket permission to distribute these.
> 
> This commit adds a new platform fallback mechanism to the firmware loader
> which will try to lookup a device fw copy embedded in the platform's main
> firmware if direct filesystem lookup fails.
> 
> Drivers which need such embedded fw copies can enable this fallback
> mechanism by using the new firmware_request_platform() function.

Why would drivers not want to fetch firmware from system firmware if it
is not present on disk? I would say let driver to opt-out of this
fallback, but default request_firmware() should do it by default.

Thanks.

-- 
Dmitry
