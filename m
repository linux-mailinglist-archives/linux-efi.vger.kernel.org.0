Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997FBD444E
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJKPb0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 11:31:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJKPb0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 11:31:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so4641215pll.1;
        Fri, 11 Oct 2019 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUyvQUwH64RrvGUZkbUqcFnsFaCVnpHO+Cg8uCu3Wpc=;
        b=BVKmAcwHc5cR0AHG6ybPz+hr+ih5oBY6MSfRrVvfFBSzB607C41M7PEnN0qeH/FtoU
         dVUjXAT7gT16vqce5dCUCZgxq+LW99sOUmuALx/5mZiaLnectj9KlabkHa0Pfm/Z36Sn
         4SchI2V40nl5gomT8dHdMRxdfgP8KbEtB9+eoNiIItw1kxOSPG7jENc5gmulO+kq+0pZ
         q77CkhID+VgVj93FS2azHwuU2nwUm2C96Y4lcHxdmohAakFOQIMFmwaGAPvYJd+kKN1i
         N0zUf20ipVSTmCXAiclERUAGIAPKY04+HlOLGJeW905wEagEE0VtI5LH6UB7ifo6Cd8D
         2tiw==
X-Gm-Message-State: APjAAAUKBWjQEojZQ/5g1Ub2vZnVIfdUvA6dtWU7kJH5XVz4+x5DVQvF
        m38nBTeQdwWoLdQnuNAmbSI=
X-Google-Smtp-Source: APXvYqy9OjjUaweOwEO2GnINEmaN3ojxMBKdIOmpYig9DdDwwKFJTnr1+UV1rKIX8W5F4zU7HRHCyQ==
X-Received: by 2002:a17:902:9f81:: with SMTP id g1mr15833508plq.82.1570807884737;
        Fri, 11 Oct 2019 08:31:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r23sm9651377pgk.46.2019.10.11.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:31:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 4A51A403EA; Fri, 11 Oct 2019 15:31:22 +0000 (UTC)
Date:   Fri, 11 Oct 2019 15:31:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
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
Message-ID: <20191011153122.GR16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
 <20191004231733.GF22365@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004231733.GF22365@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 04, 2019 at 04:17:33PM -0700, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
> > In some cases the platform's main firmware (e.g. the UEFI fw) may contain
> > an embedded copy of device firmware which needs to be (re)loaded into the
> > peripheral. Normally such firmware would be part of linux-firmware, but in
> > some cases this is not feasible, for 2 reasons:
> > 
> > 1) The firmware is customized for a specific use-case of the chipset / use
> > with a specific hardware model, so we cannot have a single firmware file
> > for the chipset. E.g. touchscreen controller firmwares are compiled
> > specifically for the hardware model they are used with, as they are
> > calibrated for a specific model digitizer.
> > 
> > 2) Despite repeated attempts we have failed to get permission to
> > redistribute the firmware. This is especially a problem with customized
> > firmwares, these get created by the chip vendor for a specific ODM and the
> > copyright may partially belong with the ODM, so the chip vendor cannot
> > give a blanket permission to distribute these.
> > 
> > This commit adds a new platform fallback mechanism to the firmware loader
> > which will try to lookup a device fw copy embedded in the platform's main
> > firmware if direct filesystem lookup fails.
> > 
> > Drivers which need such embedded fw copies can enable this fallback
> > mechanism by using the new firmware_request_platform() function.
> 
> Why would drivers not want to fetch firmware from system firmware if it
> is not present on disk? I would say let driver to opt-out of this
> fallback, but default request_firmware() should do it by default.

It is the otherw way around, this looks first for the file on disk, and
if not present it looks for the firmware sprinked on EFI firmware, if
the driver was expected this fallback option for the device.

  Luis
