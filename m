Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E598C100DB2
	for <lists+linux-efi@lfdr.de>; Mon, 18 Nov 2019 22:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKRVa0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Nov 2019 16:30:26 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42885 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRVa0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Nov 2019 16:30:26 -0500
Received: by mail-qv1-f68.google.com with SMTP id n4so4108273qvq.9;
        Mon, 18 Nov 2019 13:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbsJsPA/M9c8jyXlIJ6RFJqXLIPPmiIR0pywnPS5lrg=;
        b=YADiuJP2Bd7UWyIwWjxEG25hpZCGrSkXRvRh2FR2sL57R5Z6aVXaONG2niViPPIFYN
         GBieZp5yA4IrKbbaGpfXkch7C1grB0Gkbyyp0tZwisrShXxbpOyrGPfHRTJsudVUnHCy
         gyRt33zpp4zr1TuP8wFmn6xp084bkgJWaepf6RjLpxIeGPLQdExww6msMttyTLnG68vK
         w9NbFwYRu46uBdK0lK5DqXX1bfZPV1cB/fopxPcvKB0sO3Pw6SoDFPIngUCt9usUeeIS
         37Kh8+DnI5izfmbrYeiiWeRXX2AN2ayHqIo8YKpfpczhZTW5feOBq/7m9SEAXRfN9NYH
         edpQ==
X-Gm-Message-State: APjAAAWn4RHUlp45e/p9CV76SB6D37XrKDq/KWHx9+Z8rZ+H6uTqWPSP
        IOi3lVLZOgZnsRwtpubAN3o=
X-Google-Smtp-Source: APXvYqy/fZCPC24xRSzUWCH7JlKe2bWZMI2UsAiceAttN9T/hERdNGQMTcSAQma/5iD26J4R1zxRUg==
X-Received: by 2002:a0c:edaa:: with SMTP id h10mr14479334qvr.245.1574112625257;
        Mon, 18 Nov 2019 13:30:25 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t65sm9191918qkh.99.2019.11.18.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:30:23 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 56299401EA; Mon, 18 Nov 2019 21:30:20 +0000 (UTC)
Date:   Mon, 18 Nov 2019 21:30:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: Re: [PATCH v8 3/8] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
Message-ID: <20191118213020.GH11244@42.do-not-panic.com>
References: <20191115153529.215244-1-hdegoede@redhat.com>
 <20191115153529.215244-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115153529.215244-4-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 15, 2019 at 04:35:24PM +0100, Hans de Goede wrote:
> This is a preparation patch for adding a new platform fallback mechanism,
> which will have its own enable/disable FW_OPT_xxx option.
> 
> Note this also fixes a typo in one of the re-wordwrapped comments:
> enfoce -> enforce.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
