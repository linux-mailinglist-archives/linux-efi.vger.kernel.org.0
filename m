Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9E13C9C5
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAOQln (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:41:43 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55146 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOQln (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:41:43 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so167393pjb.4;
        Wed, 15 Jan 2020 08:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PFADiZneaHPl3Px4Pv4L/DBq5EnMqolLT+iGud91kB0=;
        b=TcWcAWKuKphn4tX30fIv+aiO/xw414ABKU82vTtQhUC9JRJyvedbvDyiYuNQwO1G0x
         kybQYg1pof0LKhBefS0DBvuTVffxEgwI05pYtzAI7iVst9FiJ1WXPHdDp3CL1l60asSQ
         JwtmteRdGHIVCNf4w8YvGCa8hTszxl0cpXBwndcajfZXJ5cTFAmAOI45YWr3Bi5l3Rad
         mHp6XdnEJIZkBNTCb5zlRBFw6aVx4Sso6S6CcZCunCMeVbl/+VTHkzR6YEsoI9ovKFvD
         SS5BEVMi1mMIhsepoErl/XZ5FHgU8pYH8YDboOyrVRd/57bWj0drkSOkai+UoE2iWH4V
         kgqw==
X-Gm-Message-State: APjAAAVg2JB9rw+pJ96G/FgXCNCwExqyzH/3TV4hxw3ZWM1UHeVboDLz
        IIfBiWHTt5JiNeIzgt2Ki+Y=
X-Google-Smtp-Source: APXvYqxQ5iZS2DU23A5DxkIq1CgidqGx+IdPMVn7NDtRouiDeH/+InapUnbFEYKLw+BDvNbhe8q16Q==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr835867pjr.22.1579106502730;
        Wed, 15 Jan 2020 08:41:42 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b8sm22555703pff.114.2020.01.15.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:41:41 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1161C40244; Wed, 15 Jan 2020 16:41:41 +0000 (UTC)
Date:   Wed, 15 Jan 2020 16:41:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v12 05/10] test_firmware: add support for
 firmware_request_platform
Message-ID: <20200115164141.GF11244@42.do-not-panic.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115163554.101315-6-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 15, 2020 at 05:35:49PM +0100, Hans de Goede wrote:
> Add support for testing firmware_request_platform through a new
> trigger_request_platform trigger.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
